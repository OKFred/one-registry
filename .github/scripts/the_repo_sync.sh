#!/bin/bash
#@description:  同步所有的镜像
#@author: Fred Zhang Qi
#@datetime: 2024-01-12

#文件依赖
#⚠️import--需要引入包含函数的文件
# none

the_repo_sync() {
  local my_src_registry_username=$1
  local my_src_registry_password=$2
  local my_src_registry_url=$3
  local my_dest_registry_url=$4
  echo "Ready to sync all repos--准备同步镜像"
  echo "Loading repo lists--获取源 Registry 的镜像列表..."
  # 注意避坑，用curl访问需要再次登录
  local str=$(curl -s -u $my_src_registry_username:$my_src_registry_password "https://${my_src_registry_url}/v2/_catalog")
  local all_images_str=$(echo $str | jq -r '.repositories[]')
  all_images_arr=(${all_images_str// / })
  echo "📦Total images: "${#all_images_arr[@]}
  #检查命令可用性
  sudo apt install sed -y
  echo "Checking skopeo--检查 skopeo 命令是否可用" && command -v skopeo >/dev/null 2>&1 || { echo >&2 "❌Skopeo is not installed. Please install it first. Skopeo 未安装，请先安装."; exit 1; }
  echo "Checking sed--检查 sed 命令是否可用" && command -v sed >/dev/null 2>&1 || { echo >&2 "❌Sed is not installed. Please install it first. Sed 未安装，请先安装."; exit 1; }
  # 遍历镜像并同步
  local i=0
  for my_image in ${all_images_arr[@]}; do
    # 提取镜像名
    local my_image_name=$(echo $my_image | sed "s/$my_src_registry_url\///")
    ((i++))
    echo "⌛Task."$i": syncing--正在同步"$my_image_name
    # 构建源和目标镜像的完整路径
    local src_image_path="docker://$my_src_registry_url/$my_image_name"
    local dest_image_path="docker://$my_dest_registry_url/$my_image_name"
    echo $src_image_path
    echo $dest_image_path
    # 使用 skopeo 复制镜像
    skopeo copy $src_image_path $dest_image_path
    date
    echo "✔️已同步"
  done
  echo "✅all done--同步完成，总计任务数："$i
}
