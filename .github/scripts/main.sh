#!/bin/bash
#@description:  同步所有的镜像
#@author: Fred Zhang Qi
#@datetime: 2024-01-12

#文件依赖
#⚠️import--需要引入包含函数的文件
source ./.github/scripts/the_repo_login.sh
source ./.github/scripts/the_repo_sync.sh

main() {
  local my_src_registry_username=$1
  local my_src_registry_password=$2
  local my_src_registry_url=$3
  local my_dest_registry_username=$4
  local my_dest_registry_password=$5
  local my_dest_registry_url=$6
  local my_aliyun_registry_username=$7
  local my_aliyun_registry_password=$8
  local my_aliyun_registry_namespaced_url=$9

  the_repo_login $my_src_registry_username $my_src_registry_password $my_src_registry_url
  if [ $? -ne 0 ]; then
    echo "❌error--登录失败"
    return 1
  fi
  the_repo_login $my_dest_registry_username $my_dest_registry_password $my_dest_registry_url
  if [ $? -ne 0 ]; then
    echo "❌error--登录失败"
    return 1
  fi
  the_repo_sync $my_src_registry_username $my_src_registry_password $my_src_registry_url $my_dest_registry_url $my_aliyun_registry_namespaced_url
  echo "------------------------"
  echo "准备同步到阿里云，生成./auth.yaml"
  echo "$my_aliyun_registry_namespaced_url:
  username: $my_aliyun_registry_username
  password: $my_aliyun_registry_password
$my_src_registry_url:
  username: $my_src_registry_username
  password: $my_src_registry_password" >./auth.yaml
}
