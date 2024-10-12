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
    global isRunning, windows, enableAFKRoom, enableGiftClaiming, MyGui, loopCount, currentLoopProgress
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
        
        if (enableAFKRoom) {
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
        Sleep(15000)
        mousePositions := [
            [49, 458],  ; Adjusted from 100, 550
            [147, 208], ; Adjusted from 300, 250
            [191, 208], ; Adjusted from 390, 250
            [235, 208], ; Adjusted from 480, 250
            [279, 208], ; Adjusted from 570, 250
            [147, 291], ; Adjusted from 300, 350
            [191, 291], ; Adjusted from 390, 350
            [235, 291], ; Adjusted from 480, 350
            [279, 291], ; Adjusted from 570, 350
            [147, 374], ; Adjusted from 300, 450
            [191, 374], ; Adjusted from 390, 450
            [235, 374], ; Adjusted from 480, 450
            [279, 374], ; Adjusted from 570, 450
            [298, 83]   ; Adjusted from 610, 100
        ]
        for pos in mousePositions {
            SpinAndClick(pos[1], pos[2])
            Sleep(500)
        }
        Sleep(1000)
    }
    LogAction("Performed claiming gifts")
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
    LogAction("Kept application active")
}

; Reload the macro
ReloadMacro(*) {
    LogAction("Reloading macro")
    Reload
}

; Exit the script
ExitScript(*) {
    LogAction("Exiting macro")
    ExitApp()
}

; Update status in the GUI
UpdateStatus(status) {
    global statusText, detailedStatusText
    statusText.Value := "Status: " . status
    detailedStatusText.Value := "Detailed Status:`n" . status
    LogAction("Status update: " . status)
}

; Style the GUI based on the current theme
StyleGUI(guiObj) {
    global currentMode, reloadEdit, exitEdit
    
    if (currentMode = "Dark") {
        guiObj.BackColor := "333333"
        guiObj.SetFont("cWhite")
        reloadEdit.Opt("+Background444444 cWhite")
        exitEdit.Opt("+Background444444 cWhite")
    } else {
        guiObj.BackColor := "FFFFFF"
        guiObj.SetFont("cBlack")
        reloadEdit.Opt("+Backgrounddddddd cBlack")
        exitEdit.Opt("+Backgrounddddddd cBlack")
    }

    for ctrl in [reloadEdit, exitEdit] {
        ctrl.Opt("+Background" . (currentMode = "Dark" ? "444444" : "dddddd"))
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
TabGui := MyGui.Add("Tab3", "w320 h470", ["Hotkeys", "Activities", "Detailed Status", "Accessibility"])

; Hotkeys Tab
TabGui.UseTab(1)

MyGui.Add("Text", "x10 y+20 w100", "Reload Hotkey:")
reloadEdit := MyGui.Add("Edit", "x+5 w200 h30 vReloadHotkey", reloadHotkey)
reloadEdit.ToolTip := "Press this key to reload the macro"

MyGui.Add("Text", "x10 y+10 w100", "Exit Hotkey:")
exitEdit := MyGui.Add("Edit", "x+5 w200 h30 vExitHotkey", exitHotkey)
exitEdit.ToolTip := "Press this key to exit the macro"

detectButton := MyGui.Add("Button", "x10 y+20 w300", "Detect Roblox Windows")
detectButton.OnEvent("Click", (*) => DetectRobloxWindows())
detectButton.ToolTip := "Click to detect and resize Roblox windows"

runButton := MyGui.Add("Button", "x10 y+10 w300", "Run Macro")
runButton.OnEvent("Click", (*) => RunMacro())
runButton.ToolTip := "Click to start the macro"

statusText := MyGui.Add("Text", "x10 y+10 vStatus w300", "Status: Waiting...")

saveSettingsButton := MyGui.Add("Button", "x10 y+20 w300", "Save Settings")
saveSettingsButton.OnEvent("Click", (*) => SaveSettingsGUI())
saveSettingsButton.ToolTip := "Click to save current settings"

; Activities Tab
TabGui.UseTab(2)
MyGui.Add("Text", "x10 y+20 Section", "Enable/Disable Activities:")
afkRoomCheckbox := MyGui.Add("Checkbox", "xs y+10 w300 vAFKRoom", "AFK Room (2 hours)")
afkRoomCheckbox.Value := enableAFKRoom
giftClaimingCheckbox := MyGui.Add("Checkbox", "xs y+10 w300 vGiftClaiming", "Gift Claiming")
giftClaimingCheckbox.Value := enableGiftClaiming

; Detailed Status Tab
TabGui.UseTab(3)
detailedStatusText := MyGui.Add("Text", "x10 y+20 w300 h400", "Detailed Status: Waiting...")

; Accessibility Tab
TabGui.UseTab(4)
MyGui.Add("Text", "x10 y+20 Section", "Accessibility Settings")
darkModeToggle := MyGui.Add("Checkbox", "x10 y+10 w300 vDarkMode", "Dark Mode")
darkModeToggle.OnEvent("Click", ToggleTheme)
darkModeToggle.Value := (currentMode = "Dark")

; Show the GUI
MyGui.Show("w340 h520")

; Function to periodically update the GUI
UpdateGUI() {
    UpdateProgressDisplay()
}

; Set up a timer to update the GUI every second
SetTimer(UpdateGUI, 1000)

; Setup hotkeys
SetupHotkeys() {
    global reloadHotkey, exitHotkey
    Hotkey(reloadHotkey, ReloadMacro)
    Hotkey(exitHotkey, ExitScript)
}

; SaveSettingsGUI function
SaveSettingsGUI() {
    global reloadHotkey, exitHotkey, afkRoomCheckbox, giftClaimingCheckbox
    reloadHotkey := reloadEdit.Value
    exitHotkey := exitEdit.Value
    enableAFKRoom := afkRoomCheckbox.Value
    enableGiftClaiming := giftClaimingCheckbox.Value
    SaveSettings()
    SetupHotkeys()
    UpdateStatus("Settings saved successfully.")
    LogAction("Saved settings")
}

; Load settings
LoadSettings()

; Set up hotkeys
SetupHotkeys()

; Apply initial styling
StyleGUI(MyGui)

; Keep the script running
OnMessage(0x112, (*) => 0)  ; Prevent the script from exiting when the GUI is closed
