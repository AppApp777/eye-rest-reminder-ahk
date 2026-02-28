# Eye Rest Reminder (Windows)

一个轻量、可开机自启的护眼提醒工具（AutoHotkey v2）。

每 20 分钟提醒一次：看远 20 秒（约 6 米），点击“我回来了，重新计时”后进入下一轮。

## 一键安装（推荐）

1. 下载本仓库代码（或 Release 压缩包）
2. 右键 `Install.bat`，选择“以管理员身份运行”
3. 安装完成后会自动启动，并设置开机自动运行（最高权限）

安装程序会自动处理：
- 自动安装 AutoHotkey v2（若未安装）
- 复制程序到 `%ProgramFiles%\EyeRestReminder`
- 注册开机自启任务（管理员权限）
- 生成卸载入口 `%ProgramFiles%\EyeRestReminder\Uninstall.bat`

## 功能

- 托盘显示剩余倒计时（悬停可见）
- 托盘菜单查看剩余时间
- 到点弹窗提醒 + 一键重置
- 稍后 1 分钟提醒
- 暂停 / 继续
- 开机自启（自动注册计划任务）

## 项目文件

- `eye_rest_reminder.ahk`：主脚本
- `Install.bat`：一键安装（提权 + 开机自启 + 自动启动）
- `StartEyeRestReminder.bat`：开发环境下手动启动
- `InstallEyeRestAutostartAdmin.bat`：开发环境下单独安装开机自启
- `UninstallEyeRestAutostart.bat`：开发环境下单独卸载开机自启

## 安全说明

- 本地运行，不联网
- 不上传数据
- 不读取隐私文件

## 护眼建议

建议配合 20-20-20 原则：
每 20 分钟，看 20 秒，注视 20 英尺（约 6 米）之外。
