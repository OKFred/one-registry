#!/bin/bash
#@description:  同步所有的镜像
#@author: Fred Zhang Qi
#@datetime: 2024-01-12

#文件依赖
#⚠️import--需要引入包含函数的文件
# none

the_repo_sync() {
  local my_src_registry=$1
  local my_dest_registry=$2
  echo "Ready to sync all repos--准备同步镜像"
  echo "Loading repo lists--获取源 Registry 的镜像列表..."
  local all_images=$(docker images --format "{{.Repository}}" | grep "$my_src_registry")

  # 遍历镜像并同步
  local i=0
  for my_image in $all_images; do

    # 提取镜像名
    local my_image_name=$(echo $my_image | sed "s/$my_src_registry\///")
    ((i++))
    echo "⌛Task."$i": syncing--正在同步"$my_image_name

    # 构建源和目标镜像的完整路径
    local src_image_path="docker://$my_src_registry/$my_image_name"
    local dest_image_path="docker://$my_dest_registry/$my_image_name"

    # 使用 skopeo 复制镜像
    skopeo copy $src_image_path $dest_image_path
    if [ $? -ne 0 ]; then
      echo "❌sync error--同步失败"
      return
    fi
    date
    echo "✔️已同步"
  done
  echo "✅all done--同步完成，总计任务数："$i
}
