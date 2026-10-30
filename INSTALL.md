# 考试宝宝 iOS 版 · 构建与安装指南

苹果装 App 和安卓不一样：没有「直接下载 APK 点安装」这条路。这个工程的做法是——

1. 把本仓库上传到你的 **GitHub**（免费账号即可），让 GitHub 的服务器替你编译出 IPA
2. 用 **Sideloadly**（Windows 电脑上的免费工具）把 IPA 装进 iPhone

全程不需要 Mac、不需要花 688 元买开发者账号。App 完全离线，数据（练习进度、错题本、收藏）
都存在手机里。

---

## 第一步：GitHub 云端编译出 IPA（约 5 分钟）

1. 注册 / 登录 [github.com](https://github.com)
2. 右上角 **+** → **New repository**：名字随便（比如 `exambuddy-ios`），选 **Public**，**不要**勾任何初始化选项，点 Create
3. 在仓库页面点 **uploading an existing file**，把 `考试宝宝-iOS工程.zip` **解压出来的所有文件和文件夹**一起拖进去（包括 `.github` 文件夹——它是隐藏文件夹，确保拖的时候带上），点 **Commit changes** 等上传完成
4. 仓库顶部 **Settings** → 左侧 **Actions** → **General** → Actions permissions 选 **Allow all actions**，保存
5. 回到仓库页，顶部 **Actions** 标签 → 左边 **Build IPA** → 右边 **Run workflow** → 绿色按钮 **Run workflow**
6. 等 2～5 分钟，列表里这条构建变绿 → 点进去 → 底部 **Artifacts** 下载 **ExamBuddy-ipa**，解压得到 `考试宝宝.ipa`

> 构建失败（变红叉）？把失败的日志截图发回来，我来修。

## 第二步：Sideloadly 装进 iPhone（约 10 分钟）

1. Windows 电脑装两个苹果官方组件（驱动必需）：
   - [iCloud for Windows](https://apps.apple.com/cn/app/icloud/photos-and-drive/id1475966378)（Microsoft Store 版即可，装完打开登录一次再退出没关系）
   - [iTunes](https://apps.apple.com/cn/app/itunes/id1475966379)（Microsoft Store 版）
2. 下载安装 [Sideloadly](https://sideloadly.io)（官网绿字 Download for Windows）
3. iPhone 用数据线连电脑，手机上弹「信任此电脑」点信任
4. 打开 Sideloadly：把 IPA 拖进去 → **Apple ID** 填你自己的 Apple ID 邮箱 → 点 **Start**
5. 手机上：设置 → 通用 → **VPN 与设备管理** → 找到你的 Apple ID → 点**信任**
6. 桌面出现「考试宝宝」图标，拔线，完工

## 常见问题

- **7 天后 App 打不开 / 提示过期**：免费 Apple ID 签名只有 7 天有效期。到期前把手机连电脑，
  Sideloadly 里再点一次 Start 覆盖装一遍就行，**练习数据不会丢**。想一年不用管，花 688 元/年
  注册 Apple Developer 后同样流程签名，有效期一年。
- **数据会不会丢**：进度、错题本、收藏都存手机 App 沙盒里，覆盖重签不丢；删 App 才会清空。
- **能和其他设备同步吗**：不能，iOS 版数据只在手机上。
- **为什么不能直接上架 App Store**：上架需要付费开发者账号和苹果审核，且 App 里的图片素材
  不是自有版权，审核过不了。个人侧载（上面这套）是合法的正规渠道。

## 更新题库 / 版本

以后出新版，把 `ios/Resources/index.html` 换成新的（打包脚本 `tools/make_ios_package.py`
自动生成），`control` 和 `ExamBuddy.plist` 里的版本号改一下，重新走一遍第一步编译、
第二步覆盖安装即可。
