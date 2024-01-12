#!/bin/bash
#@description:  登录镜像仓库函数
#@author: Fred Zhang Qi
#@datetime: 2024-01-12

#文件依赖
#⚠️import--需要引入包含函数的文件
# none

the_repo_login() {
  local my_registry_username=$1
  local my_registry_password=$2
  local my_registry_url=$3
  echo "Ready to login--准备登录"
  skopeo login --username=$my_registry_username --password=$my_registry_password $my_registry_url
  if [ $? -ne 0 ]; then
    echo "❌error--登录失败"
    return 1
  fi
  echo "✅ok--登录成功"
  return 0
}