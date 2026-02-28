# Eye Rest Reminder (Windows)

一个超轻量的 Windows 护眼提醒工具（AutoHotkey v2）。

每 20 分钟提醒一次：
- 看窗外 20 秒
- 望向约 6 米远处
- 点击“我回来了，重新计时”后进入下一轮

## Features

- 超低资源占用（本地运行，无联网依赖）
- 托盘实时倒计时（悬停可见）
- 托盘菜单查看剩余时间
- 到点弹窗提醒 + 一键重置
- 稍后 1 分钟提醒
- 暂停 / 继续
- 开机自启（可选，管理员方式）

## Files

- `eye_rest_reminder.ahk`：主程序
- `StartEyeRestReminder.bat`：手动启动
- `InstallEyeRestAutostartAdmin.bat`：安装开机自启（最高权限）
- `UninstallEyeRestAutostart.bat`：卸载开机自启

## Quick Start

1. 安装 [AutoHotkey v2](https://www.autohotkey.com/)
2. 双击 `StartEyeRestReminder.bat` 启动
3. 如果要开机自启，双击 `InstallEyeRestAutostartAdmin.bat`

## Safety

- 纯本地运行
- 不上传数据
- 不读取隐私文件
- 不需要账号登录

## Uninstall

- 关闭托盘中的程序
- 双击 `UninstallEyeRestAutostart.bat`（如果你安装过开机自启）
- 删除项目文件即可

## Recommended Habit

建议配合 20-20-20 原则：
每 20 分钟，看 20 秒，注视 20 英尺（约 6 米）之外。
