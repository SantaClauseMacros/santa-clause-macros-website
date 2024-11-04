#Requires AutoHotkey v2.0
#SingleInstance Force

; Macro 2: Game 4 Night 1 Hell mode
; This script automates actions for a specific game scenario

; Global variables
global performActionCounter := 0
global isRunning := false
global logFile := A_ScriptDir . "\Macro 2_Game 4_Night 1_Hell mode_log.txt"

; Create log file and write initial message
FileAppend("Macro 2: Game 4 Night 1 Hell mode - Log file created at " . A_Now . "`n", logFile)

; Show message box with log file location
MsgBox("Macro 2: Game 4 Night 1 Hell mode`nLog file is located at:`n" . logFile)

; Logging function
LogMessage(message) {
    FileAppend(A_Now . " - " . message . "`n", logFile)
}

; Enhanced tooltip function
ShowToolTip(message, duration := 3000) {
    ToolTip(message)
    SetTimer(() => ToolTip(), -duration)
    LogMessage("Tooltip: " . message)
}

; Window focus check function
EnsureRobloxFocus() {
    if (!WinActive("ahk_exe RobloxPlayerBeta.exe")) {
        WinActivate("ahk_exe RobloxPlayerBeta.exe")
        WinWaitActive("ahk_exe RobloxPlayerBeta.exe", , 2)
        if (!WinActive("ahk_exe RobloxPlayerBeta.exe")) {
            LogMessage("Failed to focus Roblox window")
            throw Error("Failed to focus Roblox window")
        }
    }
    LogMessage("Roblox window focused")
}

; Function to perform a faster spinning motion and click
SpinAndClick(x, y, radius := 10, duration := 500) {
    startTime := A_TickCount
    while (A_TickCount - startTime < duration) {
        angle := Mod((A_TickCount - startTime) / duration * 360, 360)
        newX := x + radius * Cos(angle * 0.01745)
        newY := y + radius * Sin(angle * 0.01745)
        MouseMove(newX, newY, 1)
        Sleep(5)
    }
    Click(x, y)
    LogMessage("Spun and clicked at coordinates: " . x . ", " . y)
}

; Define the complex action to perform
PerformAction() {
    global performActionCounter
    performActionCounter++
    LogMessage("Starting PerformAction() - Execution #" . performActionCounter)
    
    try {
        EnsureRobloxFocus()
        
        ShowToolTip("Starting initial sequence...", 2000)
        Send("{Space down}")
        Send("{a down}")
        Send("{Space up}")
        Send("{a up}")
        Sleep(100)
        Send("{Tab}")
        Sleep(100)
        Send("{Shift}")
        Send("{A down}")
        Sleep(3000)
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
        Send("{d down}")
        Sleep(2300)
        Send("{d up}")
        Sleep(100)
        Send("{s down}")
        Sleep(1975)
        Send("{s up}")
        Sleep(100)
        Send("{w down}")
        Sleep(250)
        Send("{w up}")
        Sleep(100)
        Send("{s down}")
        Sleep(300)
        Send("{s up}")
        Sleep(100)
        Send("{w down}")
        Sleep(250)
        Send("{w up}")
        Sleep(100)
        Send("{s down}")
        Sleep(300)
        Send("{s up}")
        
        LogMessage("Initial sequence completed")
        ShowToolTip("Starting main action sequence...", 2000)
        Sleep(30000)

        SpinAndClick(1109, 369)
        Sleep(1000)
        SpinAndClick(1387, 337)
        Sleep(1000)

        LogMessage("Performing main action sequence")
        ShowToolTip("Performing main action sequence...", 2000)
        
        SpinAndClick(1498, 645)
        Sleep(1000)
        SpinAndClick(1498, 645)
        Sleep(1000)
        SpinAndClick(1498, 645)
        Sleep(1000)
        SpinAndClick(1498, 645)
        Sleep(1000)

        SpinAndClick(1381, 724)
        Sleep(1000)
        SpinAndClick(1384, 705)
        Sleep(1000)
        SpinAndClick(1381, 724)
        Sleep(1000)
        SpinAndClick(1384, 705)        
        Sleep(15000)
        SpinAndClick(1458, 524)
        Sleep(100)
        Send("{s down}")
        Sleep(1000)
        Send("{s up}")
        Sleep(100)
        Send("{d down}")
        Sleep(500)
        Send("{d up}")
        Sleep(100)
        Send("{s down}")
        Sleep(250)
        Send("{s up}")
        Sleep(250)
        SpinAndClick(1614, 818)
        Send("{1 down}")
        Send("{1 up}")
        Sleep(250)
        SpinAndClick(1614, 818)
        Sleep(250)
        Send("{s down}")
        Sleep(1250)
        Send("{s up}")
        Sleep(100)
        Send("{1 down}")
        Send("{1 up}")
        SpinAndClick(1614, 818)
        Sleep(100)
        SpinAndClick(1614, 818)
        Sleep(100)
        Loop 100 {
            Send("{e down}")
            Send("{e up}")
            Sleep(100)
        }
        Sleep(250)
        SpinAndClick(1614, 818)
        Sleep(250)
        Send("{w down}")
        Sleep(1350)
        Send("{w up}")
        Sleep(250)
        SpinAndClick(1614, 818)
	Sleep(250)
        Loop 64 {
            Send("{e down}")
            Send("{e up}")
            Sleep(100)
        }
        Sleep(2000)
        Send("{s down}")
        Sleep(150)
        Send("{s up}")
        Sleep(100)
        Send("{d down}")
        Sleep(1000)
        Send("{d up}")
        Send("{s down}")
        Sleep(150)
        Send("{s up}")
        Sleep(200)
        Send("{2 down}")
        Send("{2 up}")
        Sleep(250)
        SpinAndClick(1614, 818)        
        Sleep(250)
        SpinAndClick(1614, 818)        
        Sleep(250)
        Loop 625 {
            Send("{e down}")
            Send("{e up}")
            Sleep(100)
        }
        Sleep(5000)
        Send("{s down}")
        Sleep(700)
        Send("{s up}")
        Sleep(250)
        Send("{4 down}")
        Send("{4 up}")
        Sleep(250)
        SpinAndClick(1614, 818)
        Sleep(250)
        SpinAndClick(1614, 818)
        Sleep(250)
        Loop 250 {
            Send("{e down}")
            Send("{e up}")
            Sleep(100)
        }
        Send("{D down}")
        Sleep(575)
        Send("{D up}")
        Sleep(100)
        Send("{5 down}")
        Send("{5 up}")
        Sleep(250)
        SpinAndClick(1614, 818)
        Sleep(250)
        SpinAndClick(1614, 818)
        Sleep(250)
        Loop 250 {
            Send("{e down}")
            Send("{e up}")
            Sleep(100)
        }
        Sleep(67500)
        
        ; Reset character sequence
        Send("{Escape}")  ; Press Escape key
        Sleep(2000)       ; Wait for 2 seconds
        Send("r")         ; Press R key
        Sleep(2000)       ; Short sleep
        Send("{Enter}")   ; Press Enter key
        Sleep(5000)
        LogMessage("Action sequence completed")
        ShowToolTip("Action sequence completed", 2000)
    } catch as err {
        LogMessage("Error in PerformAction(): " . err.Message)
        ShowToolTip("Error: " . err.Message, 5000)
    }
    
    LogMessage("Exiting PerformAction() - Execution #" . performActionCounter)
}

; Main loop
MainLoop() {
    global isRunning
    counter := 0
    while (isRunning) {
        counter++
        LogMessage("Starting MainLoop iteration " . counter)
        ShowToolTip("Starting iteration " . counter, 2000)
        PerformAction()
        LogMessage("MainLoop iteration " . counter . " finished")
        ShowToolTip("Action complete. Iteration " . counter . " finished. Repeating...", 3000)
        Sleep(1000)  ; Increased sleep time to ensure we can see the tooltip
    }
}

; Start the macro
F1::
{
    global isRunning
    if (!isRunning) {
        isRunning := true
        LogMessage("Macro started")
        MainLoop()  ; Call MainLoop directly
        ShowToolTip("Macro started - Performing actions repeatedly", 3000)
    } else {
        LogMessage("Attempt to start macro while already running")
        ShowToolTip("Macro is already running", 3000)
    }
}

; Stop the macro
F4::
{
    global isRunning
    isRunning := false
    LogMessage("Macro stopped")
    ShowToolTip("Macro stopped. Press F1 to start again.", 3000)
}

; Exit the script
F6::
{
    LogMessage("Exiting script")
    ShowToolTip("Macro stopped. Exiting script...", 2000)
    Sleep(2000)
    ExitApp
}

; Reload the script
F5::
{
    LogMessage("Attempting to reload script")
    ShowToolTip("Reloading script...", 2000)
    Sleep(1000)
    Reload()
    Sleep(1000)
    LogMessage("Script could not be reloaded")
    ShowToolTip("Script could not be reloaded. Please check for errors.", 5000)
}

; Show initial tooltip
ShowToolTip("Macro 2: Game 4 Night 1 Hell mode`nReady. F1: Start, F4: Stop, F5: Reload, F6: Exit", 5000)
