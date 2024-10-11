#Requires AutoHotkey v2.0

; Initialize variables
windows := []
isRunning := false
currentMode := "Dark"  ; Set default to Dark mode
afkDuration := 7200  ; 2 hours in seconds (2 * 60 * 60 = 7200)
loopCount := 0

; Default hotkeys
reloadHotkey := "F5"
exitHotkey := "F6"

; Default activity settings
enableAFKRoom := true
enableGiftClaiming := true

; Settings file
settingsFile := A_ScriptDir "\settings.ini"

; Log file
logFile := A_ScriptDir "\macro_log.txt"

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
    FileAppend FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") " - " action "`n", logFile
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
    global isRunning, windows, enableAFKRoom, enableGiftClaiming, MyGui, loopCount
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
        if (enableAFKRoom) {
            PerformGettingIntoAFKRoom()
            PerformAFK()
        }
        KeepActive()
        if (enableGiftClaiming)
            PerformClaimingGifts()
        
        loopCount++
        UpdateLoopCounter()
        LogAction("Completed loop " loopCount)
    }
}

; Function to update loop counter display
UpdateLoopCounter() {
    global loopCount
    ToolTip "Loops: " loopCount, A_ScreenWidth - 100, A_ScreenHeight - 30
}

; ... (other functions like SpinAndClick, PerformGettingIntoAFKRoom, PerformAFK, PerformClaimingGifts, and KeepActive remain the same)

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
    global statusText
    statusText.Value := "Status: " status
    LogAction("Status update: " status)
}

; ... (GUI setup code remains largely the same, but update the hotkey labels)

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

; ... (rest of the GUI setup remains the same)

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
