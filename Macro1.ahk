﻿#Requires AutoHotkey v2.0

; Initialize variables
windows := []
isRunning := false
isPaused := false
currentMode := "Dark"  ; Set default to Dark mode
afkDuration := 10  ; 10 seconds for testing (in seconds)

; Default hotkeys
pauseHotkey := "F3"
unpauseHotkey := "F3"  ; Same as pause for toggle functionality
exitHotkey := "F6"
failsafeHotkey := "F10"  ; Reintroduced failsafe hotkey

; Settings file
settingsFile := A_ScriptDir "\settings.ini"

; Load settings from file
LoadSettings() {
    global pauseHotkey, unpauseHotkey, exitHotkey, failsafeHotkey, currentMode, enableAFKRoom, enableGiftClaiming
    if FileExist(settingsFile) {
        pauseHotkey := IniRead(settingsFile, "Hotkeys", "PauseKey", "F3")
        unpauseHotkey := pauseHotkey  ; Set unpause to same as pause
        exitHotkey := IniRead(settingsFile, "Hotkeys", "ExitKey", "F6")
        failsafeHotkey := IniRead(settingsFile, "Hotkeys", "FailsafeKey", "F12")
        currentMode := IniRead(settingsFile, "Settings", "Theme", "Dark")
        enableAFKRoom := IniRead(settingsFile, "Activities", "AFKRoom", "1") = "1"
        enableGiftClaiming := IniRead(settingsFile, "Activities", "GiftClaiming", "1") = "1"
    }
}

; Save settings to file
SaveSettings() {
    global pauseHotkey, exitHotkey, failsafeHotkey, currentMode, enableAFKRoom, enableGiftClaiming
    IniWrite(pauseHotkey, settingsFile, "Hotkeys", "PauseKey")
    IniWrite(exitHotkey, settingsFile, "Hotkeys", "ExitKey")
    IniWrite(failsafeHotkey, settingsFile, "Hotkeys", "FailsafeKey")
    IniWrite(currentMode, settingsFile, "Settings", "Theme")
    IniWrite(enableAFKRoom ? "1" : "0", settingsFile, "Activities", "AFKRoom")
    IniWrite(enableGiftClaiming ? "1" : "0", settingsFile, "Activities", "GiftClaiming")
}

; Detect Roblox windows across all monitors
DetectRobloxWindows() {
    global windows, statusText
    windows := []
    DetectHiddenWindows(true)
    windowsList := WinGetList("ahk_exe RobloxPlayerBeta.exe")
    for hwnd in windowsList {
        if WinGetStyle("ahk_id " hwnd) & 0x10000000  ; WS_VISIBLE
        {
            windows.Push(hwnd)
        }
    }
    DetectHiddenWindows(false)
    if (windows.Length = 0) {
        UpdateStatus("No Roblox windows detected.")
    } else {
        UpdateStatus("Found " windows.Length " Roblox windows across all monitors.")
    }
}

; Run the macro
RunMacro() {
    global isRunning, windows, isPaused, enableAFKRoom, enableGiftClaiming, MyGui
    if (windows.Length = 0) {
        UpdateStatus("No Roblox windows detected. Please detect windows first.")
        return
    }
    
    isRunning := true
    UpdateStatus("Running...")
    
    ; Minimize the GUI when the macro starts
    MyGui.Minimize()
    
    while isRunning {
        if (!isPaused) {
            if (enableAFKRoom) {
                PerformGettingIntoAFKRoom()
                PerformAFK()
            }
            KeepActive()
            if (enableGiftClaiming)
                PerformClaimingGifts()
        }
        Sleep(100)
    }
}

; Perform the "Getting into AFK Room" activity
PerformGettingIntoAFKRoom() {
    global windows
    for hwnd in windows {
        WinActivate("ahk_id " hwnd)
        Sleep(500)
        MouseMove(1636, 427)
        Click()
        Send("{Space down}")
        Send("{a down}")
        Send("{Space up}")
        Send("{a up}")
        Sleep(100)
        Send("{Tab}")
        Sleep(100)
        Send("{Shift}")
        Send("{A down}")
        Sleep(1000)
        Send("{A up}")
        Sleep(100)
        Send("{s down}")
        Sleep(500)
        Send("{s up}")
        Sleep(100)
        Send("{a down}")
        Sleep(1000)
        Send("{a up}")
        Sleep(100)
        Send("{Shift}")
        Send("{s down}")
        Sleep(1000)
        Send("{s up}")
        Sleep(100)
        Send("{w down}")
        Sleep(500)
        Send("{w up}")
        Sleep(100)
        Send("{S down}")
        Sleep(500)
        Send("{S up}") 
        Sleep(100)
        Send("{w down}")
        Sleep(500)
        Send("{w up}")
        Sleep(100)
        Send("{w down}")
        Sleep(500)
        Send("{w up}")
        Sleep(100)
        Send("{S down}")
        Sleep(500)
        Send("{S up}") 
        Sleep(100)
        Send("{w down}")
        Sleep(500)
        Send("{w up}")
        Sleep(100)
        Send("{d down}")
        Sleep(3750)
        Send("{d up}")
        Sleep(100)
        Send("{s down}")
        Sleep(3000)
        Send("{s up}")
        Sleep(1000)
    }
}

; Perform AFK behavior for the specified duration
PerformAFK() {
    global windows, afkDuration
    startTime := A_TickCount
    endTime := startTime + (afkDuration * 1000)  ; Convert seconds to milliseconds
    
    while (A_TickCount < endTime) {
        for hwnd in windows {
            WinActivate("ahk_id " hwnd)
            Send("{w down}")
            Sleep(100)
            Send("{w up}")
            Sleep(100)
            Send("{s down}")
            Sleep(100)
            Send("{s up}")
        }
        Sleep(1000)  ; Wait 1 second before the next movement
    }
}
; Perform the "Claiming Gifts" activity
PerformClaimingGifts() {
    global windows
    for hwnd in windows {
        WinActivate("ahk_id " hwnd)
        Sleep(500)
        MouseMove(1636, 427)
        Click(2)
        Sleep(1000)
        MouseMove(949, 825)
        Click(2)
        Sleep(500)
        MouseMove(950, 808)
        Click(2)
        Sleep(500)
        MouseMove(949, 825)
        Click(2)
        Sleep(15000)
        mousePositions := [[212, 930], [654, 447], [849, 447], [1052, 447], [1248, 447],
        [654, 620], [849, 620], [1052, 620], [1248, 620],
        [654, 807], [849, 807], [1052, 807], [1248, 807], [1331, 234]]
        for pos in mousePositions {
            MouseMove(pos[1], pos[2])
            Click()
            Sleep(500)
        }
        Sleep(1000)
    }
}

; Keep the application active
KeepActive() {
    global windows
    startTime := A_TickCount
    while (A_TickCount - startTime < 10 * 1000) {
        for hwnd in windows {
            WinActivate("ahk_id " hwnd)
            Send("{w}")
        }
        Sleep(1000)
    }
}

; Toggle Pause/Unpause the macro
TogglePause(*) {
    global isPaused
    isPaused := !isPaused
    if (isPaused) {
        UpdateStatus("Paused")
    } else {
        UpdateStatus("Resumed")
    }
}

; Exit the script
ExitScript(*) {
    ExitApp()
}

; Failsafe stop
FailsafeStop(*) {
    global isRunning, isPaused
    isRunning := false
    isPaused := true
    UpdateStatus("Stopped (Failsafe)")
}

; Update status in the GUI
UpdateStatus(status) {
    global statusText
    statusText.Value := "Status: " status
}

; Style the GUI based on the current theme
StyleGUI(guiObj) {
    global currentMode, pauseEdit, exitEdit, failsafeEdit
    
    if (currentMode = "Dark") {
        guiObj.BackColor := "333333"
        guiObj.SetFont("cWhite")
        pauseEdit.Opt("+Background444444 cWhite")
        exitEdit.Opt("+Background444444 cWhite")
        failsafeEdit.Opt("+Background444444 cWhite")
    } else {
        guiObj.BackColor := "FFFFFF"
        guiObj.SetFont("cBlack")
        pauseEdit.Opt("+Background444444 cBlack")
        exitEdit.Opt("+Background444444 cBlack")
        failsafeEdit.Opt("+Background444444 cBlack")
    }

    for ctrl in [pauseEdit, exitEdit, failsafeEdit] {
        ctrl.Opt("+Background444444")
        ctrl.SetFont("c" . (currentMode = "Dark" ? "White" : "Black"))
    }
}

; Toggle Dark/Light mode
ToggleTheme(*) {
    global currentMode
    currentMode := (currentMode = "Dark") ? "Light" : "Dark"
    SaveSettings()
    StyleGUI(MyGui)
}

; GUI Setup
MyGui := Gui("+AlwaysOnTop -Resize +ToolWindow")

TabGui := MyGui.Add("Tab3", "w320 h470", ["Hotkeys", "Activities", "Recommendations", "Accessibility"])

; Hotkeys Tab
TabGui.UseTab(1)

MyGui.Add("Text", "x10 y+20 w100", "Pause/Unpause Hotkey:")
pauseEdit := MyGui.Add("Edit", "x+5 w200 h30 vPauseHotkey", pauseHotkey)

MyGui.Add("Text", "x10 y+10 w100", "Exit Hotkey:")
exitEdit := MyGui.Add("Edit", "x+5 w200 h30 vExitHotkey", exitHotkey)

MyGui.Add("Text", "x10 y+10 w100", "Failsafe Hotkey:")
failsafeEdit := MyGui.Add("Edit", "x+5 w200 h30 vFailsafeHotkey", failsafeHotkey)

detectButton := MyGui.Add("Button", "x10 y+20 w300", "Detect Roblox Windows")
detectButton.OnEvent("Click", (*) => DetectRobloxWindows())

runButton := MyGui.Add("Button", "x10 y+10 w300", "Run Macro")
runButton.OnEvent("Click", (*) => RunMacro())

statusText := MyGui.Add("Text", "x10 y+10 vStatus w300", "Status: Waiting...")

saveSettingsButton := MyGui.Add("Button", "x10 y+20 w300", "Save Settings")
saveSettingsButton.OnEvent("Click", (*) => SaveSettingsGUI())

; Activities Tab
TabGui.UseTab(2)
MyGui.Add("Text", "x10 y+20 Section", "Enable/Disable Activities:")
afkRoomCheckbox := MyGui.Add("Checkbox", "xs y+10 w300 vAFKRoom", "AFK Room (10 seconds)")
afkRoomCheckbox.Value := enableAFKRoom
giftClaimingCheckbox := MyGui.Add("Checkbox", "xs y+10 w300 vGiftClaiming", "Gift Claiming")
giftClaimingCheckbox.Value := enableGiftClaiming

; Recommendations Tab
TabGui.UseTab(3)
recommendationLink := MyGui.Add("Link", "x10 y+20 w300", "<a href=`"https://forms.gle/your-google-form-id`">Submit Feedback or Suggestions</a>")

; Accessibility Tab
TabGui.UseTab(4)
MyGui.Add("Text", "x10 y+20 Section", "Accessibility Settings")
darkModeToggle := MyGui.Add("Checkbox", "x10 y+10 w300 vDarkMode", "Dark Mode")
darkModeToggle.OnEvent("Click", ToggleTheme)
darkModeToggle.Value := (currentMode = "Dark")

; Show the GUI
MyGui.Show("w340 h520")

; Load settings
LoadSettings()

; Set up hotkeys
SetupHotkeys()

; Apply initial styling
StyleGUI(MyGui)

; Setup hotkeys
SetupHotkeys() {
    global pauseHotkey, exitHotkey, failsafeHotkey
    Hotkey(pauseHotkey, TogglePause)
    Hotkey(exitHotkey, ExitScript)
    Hotkey(failsafeHotkey, FailsafeStop)
}

; SaveSettingsGUI function
SaveSettingsGUI() {
    global pauseHotkey, exitHotkey, failsafeHotkey, afkRoomCheckbox, giftClaimingCheckbox
    pauseHotkey := pauseEdit.Value
    exitHotkey := exitEdit.Value
    failsafeHotkey := failsafeEdit.Value
    enableAFKRoom := afkRoomCheckbox.Value
    enableGiftClaiming := giftClaimingCheckbox.Value
    SaveSettings()
    SetupHotkeys()
    UpdateStatus("Settings saved successfully.")
}

; Keep the script running
OnMessage(0x112, (*) => 0)  ; Prevent the script from exiting when the GUI is closed