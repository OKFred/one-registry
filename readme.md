### @description: 用于创建仓库间镜像同步任务

### @author: Fred Zhang Qi

### @datetime: 2024-01-12

#### 步骤

1. fork 本仓库
2. 在仓库的 Settings -> Secrets 中添加以下几个 secret

-   `my_src_registry_username` 源仓库的用户名
-   `my_src_registry_password` 源仓库的密码
-   `my_src_registry_url` 源仓库的地址（不需要 http/https 前缀）
-   `my_dest_registry_username` 目标仓库的用户名
-   `my_dest_registry_password` 目标仓库的密码
-   `my_dest_registry_url` 目标仓库的地址（不需要 http/https 前缀）
-   `my_aliyun_registry_username` 阿里云仓库的用户名
-   `my_aliyun_registry_password` 阿里云仓库的密码
-   `my_aliyun_registry_namespaced_url` 阿里云仓库的带命名空间的地址（不需要 http/https 前缀）
-   `my_aliyun_registry_region_server` 阿里云仓库所在区域的地址，如 registry.cn-hangzhou.aliyuncs.com（不需要 http/https 前缀）

3. 项目默认为定时执行，有需要可以修改 `.github/workflows/sync-images.yml` 中的 `schedule` 字段

### 更多信息，请参考： [阿里云容器镜像服务](https://cr.console.aliyun.com/)
