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

3. 项目默认为定时执行，有需要可以修改 `.github/workflows/sync-images.yml` 中的 `schedule` 字段
