#!/bin/bash
#@description:  同步所有的镜像
#@author: Fred Zhang Qi
#@datetime: 2024-01-12

#文件依赖
#⚠️import--需要引入包含函数的文件
source ./.github/scripts/the_repo_login.sh
source ./.github/scripts/the_repo_sync.sh

main() {
  local MY_SRC_REGISTRY_USERNAME=$1
  local MY_SRC_REGISTRY_PASSWORD=$2
  local MY_SRC_REGISTRY_URL=$3
  local MY_DEST_REGISTRY_USERNAME=$4
  local MY_DEST_REGISTRY_PASSWORD=$5
  local MY_DEST_REGISTRY_URL=$6
  local MY_ALIYUN_REGISTRY_USERNAME=$7
  local MY_ALIYUN_REGISTRY_PASSWORD=$8
  local MY_ALIYUN_REGISTRY_NAMESPACED_URL=$9

  the_repo_login $MY_SRC_REGISTRY_USERNAME $MY_SRC_REGISTRY_PASSWORD $MY_SRC_REGISTRY_URL
  if [ $? -ne 0 ]; then
    echo "❌error--登录失败"
    return 1
  fi
  the_repo_login $MY_DEST_REGISTRY_USERNAME $MY_DEST_REGISTRY_PASSWORD $MY_DEST_REGISTRY_URL
  if [ $? -ne 0 ]; then
    echo "❌error--登录失败"
    return 1
  fi
  the_repo_sync $MY_SRC_REGISTRY_USERNAME $MY_SRC_REGISTRY_PASSWORD $MY_SRC_REGISTRY_URL $MY_DEST_REGISTRY_URL $MY_ALIYUN_REGISTRY_NAMESPACED_URL
  echo "------------------------"
  echo "准备同步到阿里云，生成./auth.yaml"
  echo "$MY_ALIYUN_REGISTRY_NAMESPACED_URL:
  username: $MY_ALIYUN_REGISTRY_USERNAME
  password: $MY_ALIYUN_REGISTRY_PASSWORD
$MY_SRC_REGISTRY_URL:
  username: $MY_SRC_REGISTRY_USERNAME
  password: $MY_SRC_REGISTRY_PASSWORD" >./auth.yaml
}
