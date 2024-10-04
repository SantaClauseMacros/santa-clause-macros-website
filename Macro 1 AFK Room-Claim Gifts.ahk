#Requires AutoHotkey v2.0
#SingleInstance Force

; Global variables
isPaused := false
imagePath := "C:\Users\asapd\Pictures\"
enableAFKRoom := false
enableGiftClaiming := false
currentMode := "Light"  ; Default to light mode

; Enhanced tooltip function
ShowToolTip(message, duration := 3000) {
    ToolTip(message)
    SetTimer(() => ToolTip(), -duration)
}

; Window focus check function
EnsureRobloxFocus() {
    if (!WinActive("ahk_exe RobloxPlayerBeta.exe")) {
        WinActivate("ahk_exe RobloxPlayerBeta.exe")
        WinWaitActive("ahk_exe RobloxPlayerBeta.exe", , 2)
        if (!WinActive("ahk_exe RobloxPlayerBeta.exe")) {
            throw Error("Failed to focus Roblox window")
        }
    }
}

; Safe sleep function that checks for pause
SafeSleep(duration) {
    endTime := A_TickCount + duration
    while (A_TickCount < endTime) {
        if (isPaused) {
            ShowToolTip("Macro paused. Press F3 to resume.", 3000)
            while (isPaused) {
                Sleep(100)
            }
            ShowToolTip("Macro resumed.", 2000)
            endTime := A_TickCount + (endTime - A_TickCount)
        }
        Sleep(100)
    }
}

; Safe send function that checks for pause
SafeSend(keys) {
    if (!isPaused) {
        Send(keys)
    }
}

; Safe click function that checks for pause
SafeClick(n := 1) {
    if (!isPaused) {
        Click(n)
    }
}

; Perform the action
PerformAction() {
    try {
        EnsureRobloxFocus()
        ShowToolTip("Starting initial sequence...", 2000)
        SafeSend("{Space down}")
        ; Rest of the complex sequence here...
    } catch e {
        ShowToolTip("Error: " . e.Message, 3000)
    }
}

; Function to run the macro
RunMacro() {
    PerformAction()
}

; Function to detect Roblox windows
DetectRobloxWindows() {
    ShowToolTip("Detecting Roblox windows...", 2000)
    ; Add window detection logic here
}

; Function to save GUI settings
SaveSettingsGUI() {
    Gui.Submit()  ; Save the settings from the GUI
    ShowToolTip("Settings saved.", 2000)
}

; Function to toggle dark mode
ToggleTheme() {
    if (currentMode = "Dark") {
        currentMode := "Light"
        ShowToolTip("Light mode enabled.", 2000)
    } else {
        currentMode := "Dark"
        ShowToolTip("Dark mode enabled.", 2000)
    }
}

; GUI Setup
MyGui := Gui("+AlwaysOnTop -Resize +ToolWindow")
TabGui := MyGui.Add("Tab3", "w320 h470", ["Hotkeys", "Activities", "Recommendations", "Accessibility"])

; Hotkeys Tab
TabGui.UseTab(1)
MyGui.Add("Text", "x10 y+20 w100", "Pause/Unpause Hotkey:")
pauseEdit := MyGui.Add("Edit", "x+5 w200 h30 vPauseHotkey", "F3")

MyGui.Add("Text", "x10 y+10 w100", "Exit Hotkey:")
exitEdit := MyGui.Add("Edit", "x+5 w200 h30 vExitHotkey", "F4")

MyGui.Add("Text", "x10 y+10 w100", "Failsafe Hotkey:")
failsafeEdit := MyGui.Add("Edit", "x+5 w200 h30 vFailsafeHotkey", "F5")

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
giftClaimingCheckbox := MyGui.Add("Checkbox", "xs y+10 w300 vGiftClaiming", "Gift Claiming")

; Recommendations Tab
TabGui.UseTab(3)
recommendationLink := MyGui.Add("Link", "x10 y+20 w300", "<a href=`"https://forms.gle/your-google-form-id`">Submit Feedback or Suggestions</a>")

; Accessibility Tab
TabGui.UseTab(4)
MyGui.Add("Text", "x10 y+20 Section", "Accessibility Settings")
darkModeToggle := MyGui.Add("Checkbox", "x10 y+10 w300 vDarkMode", "Dark Mode")
darkModeToggle.OnEvent("Click", ToggleTheme)

; Show the GUI
MyGui.Show("w340 h520")
