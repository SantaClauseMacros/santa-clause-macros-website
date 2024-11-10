#Requires AutoHotkey v2.0
#SingleInstance Force

; Macro 2: Game 4 Night 1 Hell Mode
; Description: Automates specific game actions with spin clicking
; Controls: F1 (Start), F4 (Stop), F5 (Reload), F6 (Exit)

; Global variables
global performActionCounter := 0
global isRunning := false

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
}

; Define the sequence of actions
PerformAction() {
    global performActionCounter
    performActionCounter++
    
    try {
        EnsureRobloxFocus()
        
        ShowToolTip("Starting initial sequence...", 2000)
        ShowToolTip("Starting main action sequence...", 2000)
        Sleep(30000)

        SpinAndClick(1109, 369)
        Sleep(1000)
        SpinAndClick(1387, 337)
        Sleep(1000)
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

        ; Color detection and final click sequence
        ShowToolTip("Searching for color match (1E1E1E)...", 2000)
        startTime := A_TickCount
        pixelFound := false
        
        while (A_TickCount - startTime < 100000) { ; 100 seconds
            if (PixelSearch(&foundX, &foundY, 0, 0, A_ScreenWidth, A_ScreenHeight, "0x1E1E1E")) {
                pixelFound := true
                ShowToolTip("Color match found! Executing click.", 1000)
                SpinAndClick(823, 838)
                break
            }
            Sleep(100)
        }

        if (!pixelFound) {
            ShowToolTip("Wait complete - executing click", 1000)
            SpinAndClick(823, 838)
        }

        ; Reset character sequence
        Send("{Escape}")
        Sleep(2000)
        Send("r")
        Sleep(2000)
        Send("{Enter}")
        Sleep(5000)
        ShowToolTip("Action sequence completed", 2000)
        
    } catch as err {
        ShowToolTip("Error: " . err.Message, 5000)
    }
}

; Main loop
MainLoop() {
    global isRunning
    counter := 0
    while (isRunning) {
        counter++
        ShowToolTip("Starting iteration " . counter, 2000)
        PerformAction()
        ShowToolTip("Action complete. Iteration " . counter . " finished. Repeating...", 3000)
        Sleep(1000)
    }
}

; Hotkeys
F1:: ; Start macro
{
    global isRunning
    if (!isRunning) {
        isRunning := true
        MainLoop()
        ShowToolTip("Macro started - Performing actions repeatedly", 3000)
    } else {
        ShowToolTip("Macro is already running", 3000)
    }
}

F4:: ; Stop macro
{
    global isRunning
    isRunning := false
    ShowToolTip("Macro stopped. Press F1 to start again.", 3000)
}

F5:: ; Reload script
{
    ShowToolTip("Reloading script...", 2000)
    Sleep(1000)
    Reload()
}

F6:: ; Exit script
{
    ShowToolTip("Macro stopped. Exiting script...", 2000)
    Sleep(2000)
    ExitApp
}

; Show initial tooltip
ShowToolTip("Macro 2: Game 4 Night 1 Hell Mode`nReady. F1: Start, F4: Stop, F5: Reload, F6: Exit", 5000)
