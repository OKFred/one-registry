#!/bin/bash
#@description:  同步所有的镜像
#@author: Fred Zhang Qi
#@datetime: 2024-01-12

#文件依赖
#⚠️import--需要引入包含函数的文件
source ./.github/scripts/the_aliyun_registry_feeder.sh

the_repo_sync() {
  local MY_SRC_REGISTRY_USERNAME=$1
  local MY_SRC_REGISTRY_PASSWORD=$2
  local MY_SRC_REGISTRY_URL=$3
  local MY_DEST_REGISTRY_URL=$4
  local MY_ALIYUN_REGISTRY_NAMESPACED_URL=$5
  echo "Ready to sync all repos--准备同步镜像"
  echo "Loading repo lists--获取源 Registry 的镜像列表..."
  # 注意避坑，用curl访问需要再次登录
  local str=$(curl -s -u $MY_SRC_REGISTRY_USERNAME:$MY_SRC_REGISTRY_PASSWORD "https://${MY_SRC_REGISTRY_URL}/v2/_catalog")
  local all_images_str=$(echo $str | jq -r '.repositories[]')
  all_images_arr=(${all_images_str// / })
  echo "📦Total images: "${#all_images_arr[@]}
  echo "检查通过，开始同步镜像"
  # 遍历镜像并同步
  for my_image in ${all_images_arr[@]}; do
    # 提取镜像名
    local my_image_name=$(echo $my_image | sed "s/$MY_SRC_REGISTRY_URL\///")
    echo "⌛syncing--正在同步"$my_image_name
    # 构建源和目标镜像的完整路径
    local src_image_path="$MY_SRC_REGISTRY_URL/$my_image_name"
    #如果MY_DEST_REGISTRY_URL不为空，则登录目标仓库
    if [ -n "$MY_DEST_REGISTRY_URL" ]; then
      local dest_image_path="$MY_DEST_REGISTRY_URL/$my_image_name"
      # 使用 skopeo 复制镜像
      skopeo copy "docker://"$src_image_path "docker://"$dest_image_path
      date
      echo "✔️已同步"
    fi
    echo "添加到阿里云复制任务..."$MY_ALIYUN_REGISTRY_NAMESPACED_URL
    local aliyun_image_path="$MY_ALIYUN_REGISTRY_NAMESPACED_URL/$my_image_name"
    the_aliyun_registry_feeder $src_image_path $aliyun_image_path
  done
  echo "------------------------"
  echo "✅all done--同步完成，总计任务数："${#all_images_arr[@]}
}
