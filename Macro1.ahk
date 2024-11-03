#Requires AutoHotkey v2.0

; Initialize variables
windows := []
isRunning := false
currentMode := "Dark"  ; Set default to Dark mode
afkDuration := 7200  ; 2 hours in seconds

; Default hotkeys
reloadHotkey := "F5"
exitHotkey := "F6"
failsafeHotkey := "F10"  ; Reintroduced failsafe hotkey

; Settings file
settingsFile := A_ScriptDir "\settings.ini"

; Load settings from file
LoadSettings() {
    global reloadHotkey, exitHotkey, failsafeHotkey, currentMode
    if FileExist(settingsFile) {
        reloadHotkey := IniRead(settingsFile, "Hotkeys", "ReloadKey", "F5")
        exitHotkey := IniRead(settingsFile, "Hotkeys", "ExitKey", "F6")
        failsafeHotkey := IniRead(settingsFile, "Hotkeys", "FailsafeKey", "F10")
        currentMode := IniRead(settingsFile, "Settings", "Theme", "Dark")
    }
}

; Save settings to file
SaveSettings() {
    global reloadHotkey, exitHotkey, failsafeHotkey, currentMode
    IniWrite(reloadHotkey, settingsFile, "Hotkeys", "ReloadKey")
    IniWrite(exitHotkey, settingsFile, "Hotkeys", "ExitKey")
    IniWrite(failsafeHotkey, settingsFile, "Hotkeys", "FailsafeKey")
    IniWrite(currentMode, settingsFile, "Settings", "Theme")
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
    global isRunning, windows, MyGui
    if (windows.Length = 0) {
        UpdateStatus("No Roblox windows detected. Please detect windows first.")
        return
    }
    
    isRunning := true
    UpdateStatus("Running...")
    
    ; Minimize the GUI when the macro starts
    WinMinimize("ahk_id " . MyGui.Hwnd)
    
    while isRunning {
        PerformGettingIntoAFKRoom()
        PerformAFK()
        KeepActive()
        PerformClaimingGifts()
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
        Sleep(2000)
        Send("{A up}")
        Sleep(100)
        Send("{s down}")
        Sleep(500)
        Send("{s up}")
        Sleep(100)
        Send("{a down}")
        Sleep(6000)
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

; Reload the script
ReloadScript(*) {
    Reload()
}

; Exit the script
ExitScript(*) {
    ExitApp()
}

; Failsafe stop
FailsafeStop(*) {
    global isRunning
    isRunning := false
    UpdateStatus("Stopped (Failsafe)")
}

; Update status in the GUI
UpdateStatus(status) {
    global statusText
    statusText.Value := "Status: " status
}

; Style the GUI based on the current theme
StyleGUI(guiObj) {
    global currentMode, reloadEdit, exitEdit, failsafeEdit, titleBar, minimizeButton, closeButton
    
    if (currentMode = "Dark") {
        guiObj.BackColor := "333333"
        guiObj.SetFont("cWhite")
        reloadEdit.Opt("+Background444444 cWhite")
        exitEdit.Opt("+Background444444 cWhite")
        failsafeEdit.Opt("+Background444444 cWhite")
        titleBar.SetFont("cWhite")
        minimizeButton.SetFont("cWhite")
        closeButton.SetFont("cWhite")
    } else {
        guiObj.BackColor := "FFFFFF"
        guiObj.SetFont("cBlack")
        reloadEdit.Opt("+Background444444 cBlack")
        exitEdit.Opt("+Background444444 cBlack")
        failsafeEdit.Opt("+Background444444 cBlack")
        titleBar.SetFont("cBlack")
        minimizeButton.SetFont("cBlack")
        closeButton.SetFont("cBlack")
    }

    for ctrl in [reloadEdit, exitEdit, failsafeEdit] {
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
MyGui := Gui("+Resize +MinSize320x520")  ; Allow resizing with a minimum size

; Add a custom title bar
titleBar := MyGui.Add("Text", "x0 y0 w340 h30 +BackgroundTrans", "Roblox Macro")
titleBar.SetFont("s12 Bold", "Arial")
titleBar.OnEvent("Click", (*) => SendInput("{LButton down}{LButton up}"))

; Add minimize and close buttons
minimizeButton := MyGui.Add("Text", "x300 y5 w15 h15", "—")
minimizeButton.SetFont("s12 Bold", "Arial")
minimizeButton.OnEvent("Click", (*) => WinMinimize("ahk_id " . MyGui.Hwnd))

closeButton := MyGui.Add("Text", "x320 y5 w15 h15", "×")
closeButton.SetFont("s12 Bold", "Arial")
closeButton.OnEvent("Click", (*) => ExitScript())

TabGui := MyGui.Add("Tab3", "x0 y30 w340 h490", ["Hotkeys", "Recommendations", "Accessibility"])

; Hotkeys Tab
TabGui.UseTab(1)

MyGui.Add("Text", "x10 y+20 w100", "Reload Hotkey:")
reloadEdit := MyGui.Add("Edit", "x+5 w200 h30 vReloadHotkey", reloadHotkey)

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

; Recommendations Tab
TabGui.UseTab(2)
recommendationLink := MyGui.Add("Link", "x10 y+20 w300", "<a href=`"https://forms.gle/your-google-form-id`">Submit Feedback or Suggestions</a>")

; Accessibility Tab
TabGui.UseTab(3)
MyGui.Add("Text", "x10 y+20 Section", "Accessibility Settings")
darkModeToggle := MyGui.Add("Checkbox", "x10 y+10 w300 vDarkMode", "Dark Mode")
darkModeToggle.OnEvent("Click", ToggleTheme)
darkModeToggle.Value := (currentMode = "Dark")

; Show the GUI
MyGui.Show("w340 h520")

; Make the window movable
OnMessage(0x201, WM_LBUTTONDOWN)
WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {
    global titleBar
    if (hwnd == MyGui.Hwnd && GetCurrentControl() == titleBar) {
        PostMessage(0xA1, 2)  ; WM_NCLBUTTONDOWN
    }
}

; Function to get the control under the cursor
GetCurrentControl() {
    mouseX := 0
    mouseY := 0
    MouseGetPos(&mouseX, &mouseY, , &control, 2)
    return control
}

; Load settings
LoadSettings()

; Set up hotkeys
SetupHotkeys()

; Apply initial styling
StyleGUI(MyGui)
; Setup hotkeys
SetupHotkeys() {
    global reloadHotkey, exitHotkey, failsafeHotkey
    Hotkey(reloadHotkey, ReloadScript)
    Hotkey(exitHotkey, ExitScript)
    Hotkey(failsafeHotkey, FailsafeStop)
}

; SaveSettingsGUI function
SaveSettingsGUI() {
    global reloadHotkey, exitHotkey, failsafeHotkey
    reloadHotkey := reloadEdit.Value
    exitHotkey := exitEdit.Value
    failsafeHotkey := failsafeEdit.Value
    SaveSettings()
    SetupHotkeys()
    UpdateStatus("Settings saved successfully.")
}

; Keep the script running
OnMessage(0x112, (*) => 0)  ; Prevent the script from exiting when the GUI is closed
