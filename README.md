# Eye Rest Reminder (Windows)

一个轻量、可开机自启的护眼提醒工具（AutoHotkey v2）。

每 20 分钟提醒一次：看远 20 秒（约 6 米），点击“我回来了，重新计时”后进入下一轮。

## 安装方案说明

本项目目前提供两种安装方案：

### 方案 1：打包好的版本（备选）

- 使用方式：下载 Release 中的压缩包，解压后运行 `Install.bat`
- 说明：这是为了方便快速安装提供的方案
- 注意：
  - 该方案**目前尚未经过完整回归测试**，不保证在所有机器上都完全一致
  - 仅作为**备选方案**提供

### 方案 2：我当前正在使用的方法（推荐）

- 使用方式：用户自行下载并安装 AutoHotkey v2，然后运行脚本
- 步骤：
  1. 安装 AutoHotkey v2
  2. 运行 `StartEyeRestReminder.bat`（或直接运行 `eye_rest_reminder.ahk`）
  3. 如需开机自启，运行 `InstallEyeRestAutostartAdmin.bat`
- 说明：这是作者当前长期使用的方法，行为更可控、更容易排错

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
- `StartEyeRestReminder.bat`：手动启动
- `InstallEyeRestAutostartAdmin.bat`：单独安装开机自启
- `UninstallEyeRestAutostart.bat`：单独卸载开机自启

## 安全说明

- 本地运行，不联网
- 不上传数据
- 不读取隐私文件

## 护眼建议

建议配合 20-20-20 原则：
每 20 分钟，看 20 秒，注视 20 英尺（约 6 米）之外。
