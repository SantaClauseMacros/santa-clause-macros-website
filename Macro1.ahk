#Requires AutoHotkey v2.0

global windows := []
global isRunning := false
global currentMode := "Dark"
global afkDuration := 7200
global loopCount := 0
global currentLoopProgress := 0

global reloadHotkey := "F5"
global exitHotkey := "F6"

global enableAFKRoom := true
global enableGiftClaiming := true
global getIntoAFKRoom := true

global settingsFile := A_ScriptDir "\settings.ini"
global logFile := A_ScriptDir "\macro_log.txt"

global MyGui := ""
global TabGui := ""

LoadSettings(*) {
    global reloadHotkey, exitHotkey, currentMode, enableAFKRoom, enableGiftClaiming, getIntoAFKRoom, MyGui
    try {
        if FileExist(settingsFile) {
            reloadHotkey := IniRead(settingsFile, "Hotkeys", "ReloadKey", "F5")
            exitHotkey := IniRead(settingsFile, "Hotkeys", "ExitKey", "F6")
            currentMode := IniRead(settingsFile, "Settings", "Theme", "Dark")
            enableAFKRoom := IniRead(settingsFile, "Activities", "AFKRoom", "1") = "1"
            enableGiftClaiming := IniRead(settingsFile, "Activities", "GiftClaiming", "1") = "1"
            getIntoAFKRoom := IniRead(settingsFile, "Activities", "GetIntoAFKRoom", "1") = "1"
        }
    } catch as e {
        LogAction("Error loading settings: " . e.Message)
    }
    
    if IsObject(MyGui) {
        UpdateGUIControls()
    }
    
    UpdateStatus("Settings loaded.")
}

SaveAppSettings(*) {
    global reloadHotkey, exitHotkey, currentMode, enableAFKRoom, enableGiftClaiming, getIntoAFKRoom, MyGui
    try {
        reloadHotkey := MyGui["ReloadEdit"].Value
        exitHotkey := MyGui["ExitEdit"].Value
        enableAFKRoom := MyGui["EnableAFKRoom"].Value
        enableGiftClaiming := MyGui["EnableGiftClaiming"].Value
        getIntoAFKRoom := MyGui["GetIntoAFKRoom"].Value

        IniWrite(reloadHotkey, settingsFile, "Hotkeys", "ReloadKey")
        IniWrite(exitHotkey, settingsFile, "Hotkeys", "ExitKey")
        IniWrite(currentMode, settingsFile, "Settings", "Theme")
        IniWrite(enableAFKRoom ? "1" : "0", settingsFile, "Activities", "AFKRoom")
        IniWrite(enableGiftClaiming ? "1" : "0", settingsFile, "Activities", "GiftClaiming")
        IniWrite(getIntoAFKRoom ? "1" : "0", settingsFile, "Activities", "GetIntoAFKRoom")
        UpdateStatus("Settings saved successfully.")
    } catch as e {
        LogAction("Error saving settings: " . e.Message)
        UpdateStatus("Error saving settings.")
    }
}

LogAction(action) {
    try {
        FileAppend(FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") . " - " . action . "`n", logFile)
    } catch as e {
        MsgBox("Error writing to log file: " . e.Message)
    }
}

ResizeRobloxWindows() {
    global windows
    for hwnd in windows {
        try {
            WinActivate("ahk_id " hwnd)
            WinMove(,, 800, 600, "ahk_id " hwnd)
            Sleep(100)
        } catch as e {
            LogAction("Error resizing window: " . e.Message)
        }
    }
    UpdateStatus("Roblox windows resized to 800x600")
    LogAction("Resized Roblox windows to 800x600")
}

DetectRobloxWindows(*) {
    global windows
    windows := []
    DetectHiddenWindows(true)
    windowsList := WinGetList("ahk_exe RobloxPlayerBeta.exe")
    for hwnd in windowsList {
        if WinGetStyle("ahk_id " hwnd) & 0x10000000
            windows.Push(hwnd)
    }
    DetectHiddenWindows(false)
    if (windows.Length = 0) {
        UpdateStatus("No Roblox windows detected.")
        LogAction("No Roblox windows detected")
    } else {
        UpdateStatus("Found " windows.Length " Roblox windows.")
        LogAction("Detected " windows.Length " Roblox windows")
        ResizeRobloxWindows()
    }
}

RunMacro(*) {
    global isRunning, windows, enableAFKRoom, enableGiftClaiming, getIntoAFKRoom, MyGui, loopCount, currentLoopProgress
    if (windows.Length = 0) {
        UpdateStatus("No Roblox windows detected. Please detect windows first.")
        LogAction("Attempted to run macro with no windows detected")
        return
    }

    isRunning := true
    UpdateStatus("Running...")
    LogAction("Started macro")

    MyGui.Minimize()

    SetTimer(UpdateProgressDisplay, 1000)

    while isRunning {
        loopCount++
        currentLoopProgress := 0

        if (enableAFKRoom && getIntoAFKRoom) {
            PerformGettingIntoAFKRoom()
            currentLoopProgress := 25

            PerformAFK()
            currentLoopProgress := 50
        }

        KeepActive()
        currentLoopProgress := 75

        if enableGiftClaiming {
            PerformClaimingGifts()
        }

        currentLoopProgress := 100
        LogAction("Completed loop " . loopCount)

        Sleep(1000)
    }

    SetTimer(UpdateProgressDisplay, 0)
}

UpdateProgressDisplay() {
    global loopCount, currentLoopProgress
    SetTimer(UpdateProgressDisplay, 0)
    progressText := "Loops: " . loopCount . " | Current Loop Progress: " . currentLoopProgress . "%"
    ToolTip(progressText, A_ScreenWidth - 300, A_ScreenHeight - 30)
    SetTimer(UpdateProgressDisplay, 1000)
}

SpinAndClick(x, y) {
    MouseMove(x, y)
    Sleep(100)

    radius := 5
    steps := 10
    Loop steps {
        angle := (A_Index - 1) * (2 * 3.14159 / steps)
        newX := x + radius * Cos(angle)
        newY := y + radius * Sin(angle)
        MouseMove(newX, newY)
        Sleep(10)
    }

    Click()
    Sleep(100)
}

PerformGettingIntoAFKRoom() {
    global windows
    for hwnd in windows {
        if !WinExist("ahk_id " hwnd) {
            continue
        }
        WinActivate("ahk_id " hwnd)
        Sleep(500)
        SpinAndClick(366, 93)
        Send("{Space down}")
        Send("{a down}")
        Send("{Space up}")
        Send("{a up}")
        Sleep(100)
        Send("{Tab}")
        Sleep(100)
        Send("{Shift}")
        Send("{A down}")
        Sleep(1500)
        Send("{A up}")
        Sleep(100)
        Send("{s down}")
        Sleep(500)
        Send("{s up}")
        Sleep(100)
        Send("{a down}")
        Sleep(6500)
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
        Send("{d down}")
        Sleep(3750)
        Send("{d up}")
        Sleep(100)
        Send("{s down}")
        Sleep(3000)
        Send("{s up}")
        Sleep(1000)
    }
    LogAction("Performed getting into AFK room")
}

PerformAFK() {
    global isRunning, windows, afkDuration
    afkStartTime := A_TickCount
    afkEndTime := afkStartTime + (afkDuration * 1000)

    while isRunning && (A_TickCount < afkEndTime) {
        for hwnd in windows {
            if !WinExist("ahk_id " hwnd) {
                continue
            }
            WinActivate("ahk_id " hwnd)
            Send("{w down}")
            Sleep(100)
            Send("{w up}")
            Sleep(100)
            Send("{s down}")
            Sleep(100)
            Send("{s up}")
        }
        Sleep(1000)
    }
    LogAction("Performed AFK behavior")
}

PerformClaimingGifts() {
    global windows
    for hwnd in windows {
        if !WinExist("ahk_id " hwnd) {
            continue
        }
        WinActivate("ahk_id " hwnd)
        Sleep(500)
        SpinAndClick(366, 93)
        Sleep(1000)
        SpinAndClick(213, 458)
        Sleep(500)
        SpinAndClick(213, 450)
        Sleep(500)
        SpinAndClick(213, 458)
        Sleep(1000)
    }
    LogAction("Performed claiming gifts")
}

KeepActive() {
    global windows
    for hwnd in windows {
        if WinExist("ahk_id " hwnd) {
            WinActivate("ahk_id " hwnd)
            Sleep(100)
        }
    }
}

CreateMainGUI() {
    global MyGui, TabGui, enableAFKRoom, enableGiftClaiming, getIntoAFKRoom, reloadHotkey, exitHotkey

    MyGui := Gui(, "Roblox Macro Manager")
    MyGui.BackColor := "404040"
    MyGui.MarginX := 10
    MyGui.MarginY := 10

    TabGui := MyGui.Add("Tab3", "w380 h350", ["General", "Settings"])

    TabGui.UseTab(1)
    AddWhiteText("Enable AFK Room Activity:")
    MyGui.Add("CheckBox", "vEnableAFKRoom Checked" . (enableAFKRoom ? 1 : 0) . " c000000", "")
    AddWhiteText("Get Into AFK Room:")
    MyGui.Add("CheckBox", "vGetIntoAFKRoom Checked" . (getIntoAFKRoom ? 1 : 0) . " c000000", "")
    AddWhiteText("Enable Gift Claiming Activity:")
    MyGui.Add("CheckBox", "vEnableGiftClaiming Checked" . (enableGiftClaiming ? 1 : 0) . " c000000", "")

    MyGui.Add("Button", "w100 y+20", "Run Macro").OnEvent("Click", (*) => RunMacro())
    MyGui.Add("Button", "w100 x+10", "Stop Macro").OnEvent("Click", (*) => StopMacro())
    MyGui.Add("Button", "w100 x10 y+10", "Detect Windows").OnEvent("Click", (*) => DetectRobloxWindows())

    AddWhiteText("Status:", "y+20")
    MyGui.Add("Text", "vStatusText w360 cWhite", "Idle")
    AddWhiteText("Detailed Status:", "y+10")
    MyGui.Add("Edit", "vDetailedStatusText w360 h100 ReadOnly cWhite Background404040")

    TabGui.UseTab(2)
    AddWhiteText("Hotkey to reload script:")
    MyGui.Add("Edit", "w100 vReloadEdit cBlack", reloadHotkey)
    AddWhiteText("Hotkey to exit script:", "y+10")
    MyGui.Add("Edit", "w100 vExitEdit cBlack", exitHotkey)
    MyGui.Add("Button", "w100 y+20", "Save Settings").OnEvent("Click", (*) => SaveAppSettings())
    MyGui.Add("Button", "w100 x+10", "Load Settings").OnEvent("Click", (*) => LoadSettings())

    TabGui.UseTab()

    MyGui.OnEvent("Close", (*) => ExitApp())
    MyGui.Show("w400 h400")
}

AddWhiteText(text, options := "") {
    MyGui.Add("Text", "cWhite " . options, text)
}

UpdateStatus(status) {
    global MyGui
    if IsObject(MyGui) {
        MyGui["StatusText"].Value := status
        MyGui["DetailedStatusText"].Value .= FormatTime(, "HH:mm:ss") . " - " . status . "`n"
        MyGui["DetailedStatusText"].Opt("+Redraw")
    }
}

UpdateGUIControls() {
    global MyGui, enableAFKRoom, enableGiftClaiming, getIntoAFKRoom, reloadHotkey, exitHotkey
    MyGui["EnableAFKRoom"].Value := enableAFKRoom
    MyGui["EnableGiftClaiming"].Value := enableGiftClaiming
    MyGui["GetIntoAFKRoom"].Value := getIntoAFKRoom
    MyGui["ReloadEdit"].Value := reloadHotkey
    MyGui["ExitEdit"].Value := exitHotkey
}

StopMacro(*) {
    global isRunning
    isRunning := false
    UpdateStatus("Macro stopped.")
    LogAction("Macro stopped")
}

LoadSettings()
CreateMainGUI()

HotIfWinActive("A")
Hotkey(reloadHotkey, (*) => LoadSettings())
Hotkey(exitHotkey, (*) => StopMacro())
