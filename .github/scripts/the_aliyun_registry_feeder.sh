#!/bin/bash
#@description:  生成临时的镜像同步列表，供image-sync-action调用
#@author: Fred Zhang Qi
#@datetime: 2024-01-13

#文件依赖
#⚠️import--需要引入包含函数的文件
# none
aliyun_image_file=./images.yaml

the_aliyun_registry_feeder() {
  local my_src_image=$1
  local my_dest_image=$2
  echo "src_image: $my_src_image" >$aliyun_image_file
}

the_aliyun_image_file_maker(){
  sudo touch $aliyun_image_file
  echo "阿里云配置文件已生成"
}

the_aliyun_image_file_maker