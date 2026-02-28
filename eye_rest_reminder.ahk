#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent

global reminderIntervalMs := 20 * 60 * 1000
global nextReminderTick := A_TickCount + reminderIntervalMs
global pausedRemainingMs := reminderIntervalMs
global isPaused := false
global popupGui := 0

BuildTrayMenu()
UpdateTrayTooltip()
SetTimer(TimerTick, 1000)

TrayTip("每20分钟会提醒你看远20秒。", "护眼提醒已启动")

BuildTrayMenu() {
    A_TrayMenu.Delete()
    A_TrayMenu.Add("查看剩余时间", ShowRemainingTime)
    A_TrayMenu.Add("立即提醒", ShowReminderNow)
    A_TrayMenu.Add()
    A_TrayMenu.Add("暂停提醒", TogglePause)
    A_TrayMenu.Add("重置20分钟", ResetTimerFromNow)
    A_TrayMenu.Add()
    A_TrayMenu.Add("退出", (*) => ExitApp())

    A_TrayMenu.Default := "查看剩余时间"
    A_TrayMenu.ClickCount := 1
}

TimerTick(*) {
    global isPaused, nextReminderTick

    if isPaused {
        UpdateTrayTooltip()
        return
    }

    if (A_TickCount >= nextReminderTick) {
        ShowReminderPopup()
    }

    UpdateTrayTooltip()
}

ShowRemainingTime(*) {
    global isPaused, nextReminderTick, pausedRemainingMs

    remainingMs := isPaused ? pausedRemainingMs : (nextReminderTick - A_TickCount)
    body := isPaused
        ? "当前已暂停，剩余时间：" . FormatRemaining(remainingMs)
        : "距离下次护眼提醒还有：" . FormatRemaining(remainingMs)

    MsgBox(body, "护眼倒计时", "T3 Iconi")
}

ShowReminderNow(*) {
    ShowReminderPopup()
}

ShowReminderPopup() {
    global popupGui

    if IsObject(popupGui) {
        popupGui.Show("AutoSize Center")
        return
    }

    popupGui := Gui("+AlwaysOnTop +ToolWindow", "护眼提醒")
    popupGui.SetFont("s11", "Microsoft YaHei UI")
    popupGui.AddText("w340", "看窗外20秒，望向6米远处，让眼睛休息一下。")

    backBtn := popupGui.AddButton("xm y+14 w165 h34 Default", "我回来了，重新计时")
    snoozeBtn := popupGui.AddButton("x+10 yp w165 h34", "稍后1分钟")

    backBtn.OnEvent("Click", OnBackClicked)
    snoozeBtn.OnEvent("Click", OnSnoozeClicked)
    popupGui.OnEvent("Close", OnSnoozeClicked)

    popupGui.Show("AutoSize Center")
    SoundBeep(900, 120)
    SoundBeep(1100, 120)
}

OnBackClicked(*) {
    HidePopup()
    ResetTimerFromNow()
}

OnSnoozeClicked(*) {
    HidePopup()
    SnoozeMinutes(1)
}

HidePopup() {
    global popupGui

    if IsObject(popupGui) {
        popupGui.Hide()
    }
}

SnoozeMinutes(minutes) {
    global isPaused, nextReminderTick

    if isPaused {
        return
    }

    nextReminderTick := A_TickCount + (minutes * 60 * 1000)
    UpdateTrayTooltip()
}

TogglePause(*) {
    global isPaused, pausedRemainingMs, nextReminderTick

    isPaused := !isPaused
    if isPaused {
        pausedRemainingMs := Max(nextReminderTick - A_TickCount, 0)
        TryRenameMenu("暂停提醒", "继续提醒")
    } else {
        nextReminderTick := A_TickCount + pausedRemainingMs
        TryRenameMenu("继续提醒", "暂停提醒")
    }

    UpdateTrayTooltip()
}

TryRenameMenu(oldLabel, newLabel) {
    try A_TrayMenu.Rename(oldLabel, newLabel)
}

ResetTimerFromNow(*) {
    global reminderIntervalMs, nextReminderTick, pausedRemainingMs, isPaused

    isPaused := false
    nextReminderTick := A_TickCount + reminderIntervalMs
    pausedRemainingMs := reminderIntervalMs
    TryRenameMenu("继续提醒", "暂停提醒")
    UpdateTrayTooltip()
}

UpdateTrayTooltip() {
    global isPaused, nextReminderTick, pausedRemainingMs

    remainingMs := isPaused ? pausedRemainingMs : (nextReminderTick - A_TickCount)
    tipPrefix := isPaused ? "护眼提醒(已暂停)" : "护眼提醒"
    A_IconTip := tipPrefix . "`n剩余: " . FormatRemaining(remainingMs)
}

FormatRemaining(ms) {
    totalSec := Ceil(ms / 1000)
    if (totalSec < 0) {
        totalSec := 0
    }

    minutes := Floor(totalSec / 60)
    seconds := Mod(totalSec, 60)
    return Format("{:02}分{:02}秒", minutes, seconds)
}
