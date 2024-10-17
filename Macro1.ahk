#Requires AutoHotkey v2.0

; Initialize variables
global windows := []
global isRunning := false
global currentMode := "Dark"  ; Set default to Dark mode
global afkDuration := 7200  ; 2 hours in seconds (2 * 60 * 60 = 7200)
global loopCount := 0
global currentLoopProgress := 0

; Default hotkeys
global reloadHotkey := "F5"
global exitHotkey := "F6"

; Default activity settings
global enableAFKRoom := true
global enableGiftClaiming := true

; Settings file
global settingsFile := A_ScriptDir "\settings.ini"

; Log file
global logFile := A_ScriptDir "\macro_log.txt"

; GUI variables
global MyGui := ""
global TabGui := ""
global statusText := ""
global reloadEdit := ""
global exitEdit := ""
global afkRoomCheckbox := ""
global giftClaimingCheckbox := ""
global getIntoAFKRoomCheckbox := ""  ; New checkbox for getting into AFK room
global detailedStatusText := ""

; Load settings from file
LoadSettings() {
    global reloadHotkey, exitHotkey, currentMode, enableAFKRoom, enableGiftClaiming
    if FileExist(settingsFile) {
        reloadHotkey := IniRead(settingsFile, "Hotkeys", "ReloadKey", "F5")
        exitHotkey := IniRead(settingsFile, "Hotkeys", "ExitKey", "F6")
        currentMode := IniRead(settingsFile, "Settings", "Theme", "Dark")
        enableAFKRoom := IniRead(settingsFile, "Activities", "AFKRoom", "1") = "1"
        enableGiftClaiming := IniRead(settingsFile, "Activities", "GiftClaiming", "1") = "1"
    }
}

; Save settings to file
SaveSettings() {
    global reloadHotkey, exitHotkey, currentMode, enableAFKRoom, enableGiftClaiming
    IniWrite(reloadHotkey, settingsFile, "Hotkeys", "ReloadKey")
    IniWrite(exitHotkey, settingsFile, "Hotkeys", "ExitKey")
    IniWrite(currentMode, settingsFile, "Settings", "Theme")
    IniWrite(enableAFKRoom ? "1" : "0", settingsFile, "Activities", "AFKRoom")
    IniWrite(enableGiftClaiming ? "1" : "0", settingsFile, "Activities", "GiftClaiming")
}

; Function to log actions
LogAction(action) {
    FileAppend(FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") . " - " . action . "`n", logFile)
}

; Function to resize Roblox windows
ResizeRobloxWindows() {
    global windows
    for hwnd in windows {
        WinActivate("ahk_id " hwnd)
        WinMove(,, 800, 600, "ahk_id " hwnd)  ; Resize to 800x600
        Sleep(100)
    }
    UpdateStatus("Roblox windows resized to 800x600")
    LogAction("Resized Roblox windows to 800x600")
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
        LogAction("No Roblox windows detected")
    } else {
        UpdateStatus("Found " windows.Length " Roblox windows across all monitors.")
        LogAction("Detected " windows.Length " Roblox windows")
        ResizeRobloxWindows()
    }
}

; Run the macro
RunMacro() {
    global isRunning, windows, enableAFKRoom, enableGiftClaiming, getIntoAFKRoomCheckbox, MyGui, loopCount, currentLoopProgress
    if (windows.Length = 0) {
        UpdateStatus("No Roblox windows detected. Please detect windows first.")
        LogAction("Attempted to run macro with no windows detected")
        return
    }

    ResizeRobloxWindows()

    isRunning := true
    UpdateStatus("Running...")
    LogAction("Started macro")

    ; Minimize the GUI when the macro starts
    MyGui.Minimize()

    while isRunning {
        loopCount++
        currentLoopProgress := 0
        UpdateProgressDisplay()

        if (enableAFKRoom && getIntoAFKRoomCheckbox.Value) {
            PerformGettingIntoAFKRoom()
            currentLoopProgress := 25
            UpdateProgressDisplay()

            PerformAFK()
            currentLoopProgress := 50
            UpdateProgressDisplay()
        }

        KeepActive()
        currentLoopProgress := 75
        UpdateProgressDisplay()

        if (enableGiftClaiming) {
            PerformClaimingGifts()
        }

        currentLoopProgress := 100
        UpdateProgressDisplay()
        LogAction("Completed loop " . loopCount)
    }
}

; Function to update progress display
UpdateProgressDisplay() {
    global loopCount, currentLoopProgress
    progressText := "Loops: " . loopCount . " | Current Loop Progress: " . currentLoopProgress . "%"
    ToolTip(progressText, A_ScreenWidth - 300, A_ScreenHeight - 30)
}

; Function to perform a spin and click action
SpinAndClick(x, y) {
    MouseMove(x, y)
    Sleep(100)

    ; Perform a circular motion
    radius := 5  ; Reduced radius for smaller window
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

; Perform the "Getting into AFK Room" activity
PerformGettingIntoAFKRoom() {
    global windows
    for hwnd in windows {
        WinActivate("ahk_id " hwnd)
        Sleep(500)
        SpinAndClick(366, 93)  ; Adjusted from 750, 200 for 800x600 window
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
    LogAction("Performed AFK behavior")
}

; Perform the "Claiming Gifts" activity
PerformClaimingGifts() {
    global windows
    for hwnd in windows {
        WinActivate("ahk_id " hwnd)
        Sleep(500)
        SpinAndClick(366, 93)  ; Adjusted from 750, 200 for 800x600 window
        Sleep(1000)
        SpinAndClick(213, 458)  ; Adjusted from 435, 550 for 800x600 window
        Sleep(500)
        SpinAndClick(213, 450)  ; Adjusted from 435, 540 for 800x600 window
        Sleep(500)
        SpinAndClick(213, 458)  ; Adjusted from 435, 550 for 800x600 window
        Sleep(1000)
    }
    LogAction("Performed claiming gifts")
}

; Function to keep the active window alive
KeepActive() {
    global windows
    for hwnd in windows {
        WinActivate("ahk_id " hwnd)
        Sleep(100)
    }
}

; Function to update the GUI status
UpdateStatus(status) {
    global statusText, MyGui
    statusText := status
    MyGui.StatusText.Text := statusText
}

; Create the main GUI
CreateMainGUI() {
    global MyGui, TabGui, afkRoomCheckbox, giftClaimingCheckbox, getIntoAFKRoomCheckbox

    MyGui := Gui(, "Roblox Macro")
    MyGui.SetFont("s10")
    TabGui := MyGui.AddTabControl()

    ; Hotkeys Tab
    TabGui.UseTab(1)
    MyGui.Add("Text", "x10 y+20 Section", "Hotkeys:")
    MyGui.Add("Text", "x10 y+10", "Reload Hotkey:")
    reloadEdit := MyGui.Add("Edit", "x150 y+10 w100 vReloadKey", reloadHotkey)
    MyGui.Add("Text", "x10 y+40", "Exit Hotkey:")
    exitEdit := MyGui.Add("Edit", "x150 y+40 w100 vExitKey", exitHotkey)

    ; Activities Tab
    TabGui.UseTab(2)
    MyGui.Add("Text", "x10 y+20 Section", "Enable/Disable Activities:")
    afkRoomCheckbox := MyGui.Add("Checkbox", "xs y+10 w300 vAFKRoom", "AFK Room (2 hours)")
    afkRoomCheckbox.Value := enableAFKRoom
    getIntoAFKRoomCheckbox := MyGui.Add("Checkbox", "xs y+10 w300 vGetIntoAFKRoom", "Getting into AFK Room")
    getIntoAFKRoomCheckbox.Value := true  ; Default to enabled
    giftClaimingCheckbox := MyGui.Add("Checkbox", "xs y+10 w300 vGiftClaiming", "Gift Claiming")
    giftClaimingCheckbox.Value := enableGiftClaiming

    ; Status Display
    MyGui.Add("Text", "x10 y+10", "Status:")
    MyGui.StatusText := MyGui.Add("Text", "x10 y+30 w400", statusText)

    ; Start and Exit Buttons
    MyGui.Add("Button", "x10 y+20 g=StartMacro", "Start Macro")
    MyGui.Add("Button", "x120 y+20 g=StopMacro", "Stop Macro")
    MyGui.Add("Button", "x240 y+20 g=DetectWindows", "Detect Windows")
    MyGui.Add("Button", "x360 y+20 g=SaveSettings", "Save Settings")
    
    MyGui.OnEvent("Close", "OnClose")
    MyGui.Show()
}

; Function to handle starting the macro
StartMacro() {
    global isRunning, enableAFKRoom, enableGiftClaiming, MyGui, getIntoAFKRoomCheckbox
    if isRunning {
        UpdateStatus("Macro is already running.")
        return
    }
    
    enableAFKRoom := afkRoomCheckbox.Value
    enableGiftClaiming := giftClaimingCheckbox.Value
    RunMacro()
}

; Function to handle stopping the macro
StopMacro() {
    global isRunning
    isRunning := false
    UpdateStatus("Macro stopped.")
    LogAction("Macro stopped")
}

; Function to detect windows
DetectWindows() {
    DetectRobloxWindows()
}

; Function to save settings
SaveSettings() {
    SaveSettings()
    UpdateStatus("Settings saved.")
}

; Function to handle GUI closure
OnClose() {
    StopMacro()
    ExitApp()
}

; Load settings and create the GUI
LoadSettings()
CreateMainGUI()
