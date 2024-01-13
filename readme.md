### @description: 用于创建仓库间镜像同步任务

### @author: Fred Zhang Qi

### @datetime: 2024-01-12

#### 步骤

1. fork 本仓库
2. 在仓库的 Settings -> Secrets 中添加以下几个 secret

-   `MY_SRC_REGISTRY_USERNAME` 源仓库的用户名
-   `MY_SRC_REGISTRY_PASSWORD` 源仓库的密码
-   `MY_SRC_REGISTRY_URL` 源仓库的地址（不需要 http/https 前缀）
-   `MY_DEST_REGISTRY_USERNAME` 目标仓库的用户名
-   `MY_DEST_REGISTRY_PASSWORD` 目标仓库的密码
-   `MY_DEST_REGISTRY_URL` 目标仓库的地址（不需要 http/https 前缀）
-   `MY_ALIYUN_REGISTRY_USERNAME` 阿里云仓库的用户名
-   `MY_ALIYUN_REGISTRY_PASSWORD` 阿里云仓库的密码
-   `MY_ALIYUN_REGISTRY_NAMESPACED_URL` 阿里云仓库的带命名空间的地址（不需要 http/https 前缀）
-   `MY_ALIYUN_REGISTRY_REGION_SERVER` 阿里云仓库所在区域的地址，如 registry.cn-hangzhou.aliyuncs.com（不需要 http/https 前缀）

3. 项目默认为定时执行，有需要可以修改 `.github/workflows/sync-images.yml` 中的 `schedule` 字段

### 更多信息，请参考： [阿里云容器镜像服务](https://cr.console.aliyun.com/)
