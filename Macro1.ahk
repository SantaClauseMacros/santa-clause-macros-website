#Requires AutoHotkey v2.0
#SingleInstance Force

; Global variables
isPaused := false
imagePath := "C:\Users\asapd\Pictures\"

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

; Define the complex action to perform
PerformAction() {
    try {
        EnsureRobloxFocus()
        
        ShowToolTip("Starting initial sequence...", 2000)
        SafeSend("{Space down}")
        SafeSend("{a down}")
        SafeSend("{Space up}")
        SafeSend("{a up}")
        Sleep(100)
        SafeSend("{Tab}")
        Sleep(100)
        SafeSend("{Shift}")
        SafeSend("{A down}")
        Sleep(2000)
        SafeSend("{A up}")
        Sleep(100)
        SafeSend("{s down}")
        Sleep(500)
        SafeSend("{s up}")
        Sleep(100)
        SafeSend("{a down}")
        Sleep(4500)
        SafeSend("{a up}")
        Sleep(100)
        SafeSend("{Shift}")
        SafeSend("{s down}")
        Sleep(1000)
        SafeSend("{s up}")
        Sleep(100)
        SafeSend("{w down}")
        Sleep(500)
        SafeSend("{w up}")
        Sleep(100)
        SafeSend("{S down}")
        Sleep(500)
        SafeSend("{S up}")
        Sleep(100)
        SafeSend("{w down}")
        Sleep(500)
        SafeSend("{w up}")
        Sleep(100)
        SafeSend("{w down}")
        Sleep(500)
        SafeSend("{w up}")
        Sleep(100)
        SafeSend("{S down}")
        Sleep(500)
        SafeSend("{S up}")
        Sleep(100)
        SafeSend("{d down}")
        Sleep(2300)
        SafeSend("{d up}")
        Sleep(100)
        SafeSend("{s down}")
        Sleep(2000)
        SafeSend("{s up}")
        
        ShowToolTip("Starting main action sequence...", 2000)
        SafeSleep(25000)

        MouseMove(1109, 369, 30)
        SafeSleep(1000)
        
        ShowToolTip("Searching for 'Choose Night' image...", 2000)
        Loop {
            if (isPaused) {
                break
            }
            MouseMove(1109, 369, 30)
            MouseMove(1110, 370, 30)
            MouseMove(1109, 369, 30)
            SafeSleep(500)
            SafeClick(1)
            SafeSleep(2500)
            if (ImageSearch(&FoundX, &FoundY, 1203, 230, 1605, 778, imagePath . "Choose Night.png")) {
                ShowToolTip("'Choose Night' image found!", 1500)
                break
            }
            SafeSleep(1000)
        }
        
        MouseMove(1387, 337, 30)
        SafeSleep(1000)
        
        ShowToolTip("Searching for 'Night Info' image...", 2000)
        Loop {
            if (isPaused) {
                break
            }
            MouseMove(1387, 337, 30)
            MouseMove(1390, 340, 30)
            MouseMove(1387, 337, 30)
            SafeSleep(500)
            SafeClick(1)
            SafeSleep(2500)
            if (ImageSearch(&FoundX, &FoundY, 336, 238, 668, 749, imagePath . "Sigma.png")) {
                ShowToolTip("'Night Info' image found!", 1500)
                break
            }
            SafeSleep(1000)
        }

        ShowToolTip("Performing main action sequence...", 2000)
        SafeSleep(1000)
        MouseMove(1381, 724, 30)
        SafeSleep(1000)
        MouseMove(1384, 705, 30)
        SafeSleep(1000)
        MouseMove(1381, 724, 30)
        SafeSleep(1000)
        MouseMove(1384, 705, 30)
        SafeSleep(1000)
        SafeClick(1)
        SafeSleep(15000)
        SafeSend("{s down}")
        Sleep(1000)
        SafeSend("{s up}")
        Sleep(100)
        SafeSend("{d down}")
        Sleep(500)
        SafeSend("{d up}")
        Sleep(100)
        SafeSend("{s down}")
        Sleep(250)
        SafeSend("{s up}")
        Sleep(50)
        Sleep(100)
        MouseMove(1614, 818, 10)
        Sleep(500)
        SafeClick(2)
        SafeSend("{1 down}")
        SafeSend("{1 up}")
        Sleep(750)
        MouseMove(1600, 800, 10)
        Sleep(500)
        MouseMove(1614, 818, 10)
        SafeClick()
        SafeSend("{s down}")
        Sleep(1250)
        SafeSend("{s up}")
        Sleep(100)
        SafeSend("{1 down}")
        SafeSend("{1 up}")
        Sleep(50)
        SafeClick()
        SafeSend("{d down}")
        Sleep(800)
        SafeSend("{d up}")
        Sleep(100)
        SafeSend("{s down}")
        Sleep(500)
        SafeSend("{s up}")
        SafeSend("{d down}")
        Sleep(300)
        SafeSend("{d up}")
        Sleep(100)
        SafeSend("{1 down}")
        SafeSend("{1 up}")
        MouseMove(1500, 900, 10)
        Sleep(500)
        MouseMove(1510, 899, 10)
        SafeClick()
        Sleep(500)
        SafeClick()
        MouseMove(1500, 900, 10)
        Sleep(500)
        MouseMove(1510, 899, 10)
        SafeClick()
        SafeSend("{e down}")
        SafeSend("{e up}")
        Loop 75 {
            if (isPaused) {
                break
            }
            SafeSend("{e down}")
            SafeSend("{e up}")
            Sleep(100)
        }
        SafeSend("{a down}")
        Sleep(800)
        SafeSend("{a up}")
        Sleep(100)
        SafeSend("{w down}")
        Sleep(500)
        SafeSend("{w up}")
        Sleep(100)
        SafeSend("{a down}")
        Sleep(300)
        SafeSend("{a up}")
        MouseMove(1600, 800, 10)
        Sleep(500)
        MouseMove(1614, 818, 10)
        SafeClick()
        Sleep(500)
        Loop 64 {
            if (isPaused) {
                break
            }
            SafeSend("{e down}")
            SafeSend("{e up}")
            Sleep(100)
        }
        SafeSend("{w down}")
        Sleep(1350)
        SafeSend("{w up}")
        MouseMove(1600, 800, 10)
        Sleep(500)
        MouseMove(1614, 818, 10)
        SafeClick()
        Sleep(500)
        Loop 64 {
            if (isPaused) {
                break
            }
            SafeSend("{e down}")
            SafeSend("{e up}")
            Sleep(100)
        }
        SafeSend("{s down}")
        Sleep(150)
        SafeSend("{s up}")
        Sleep(100)
        SafeSend("{d down}")
        Sleep(1000)
        SafeSend("{d up}")
        SafeSend("{s down}")
        Sleep(150)
        SafeSend("{s up}")
        Sleep(200)
        SafeSend("{3 down}")
        SafeSend("{3 up}")
        Sleep(500)
        SafeClick()
        Sleep(500)
        SafeClick()
        Sleep(500)
        Loop 450 {
            if (isPaused) {
                break
            }
            SafeSend("{e down}")
            SafeSend("{e up}")
            Sleep(100)
        }
        SafeSend("{s down}")
        Sleep(500)
        SafeSend("{s up}")
        Sleep(250)
        SafeSend("{5 down}")
        SafeSend("{5 up}")
        Sleep(500)
        SafeClick()
        Sleep(500)
        MouseMove(1600, 800, 10)
        Sleep(500)
        MouseMove(1614, 818, 10)
        SafeClick()
        Sleep(500)
        Loop 100 {
            if (isPaused) {
                break
            }
            SafeSend("{e down}")
            SafeSend("{e up}")
            Sleep(100)
        }
	Sleep(90000)
        ShowToolTip("Action sequence completed", 2000)
    } catch as err {
        ShowToolTip("Error: " . err.Message, 5000)
    }
}

; Main loop
MainLoop() {
    global isPaused
    Loop {
        if (!isPaused) {
            PerformAction()
            ShowToolTip("Action complete. Repeating...", 3000)
        }
        Sleep(100)
    }
}

; Start the macro
F1::
{
    SetTimer(MainLoop, -1)
    ShowToolTip("Macro started - Performing actions repeatedly", 3000)
}

; Pause/Unpause the macro
F3::
{
    global isPaused
    isPaused := !isPaused
    if (isPaused) {
        ShowToolTip("Macro paused. Press F3 to resume.", 3000)
    } else {
        ShowToolTip("Macro resumed. Press F3 to pause.", 3000)
    }
}

; Exit the script
F6::
{
    ShowToolTip("Macro stopped. Exiting script...", 2000)
    Sleep(2000)
    ExitApp
}

; Reload the script
F5::
{
    ShowToolTip("Reloading script...", 2000)
    Sleep(1000)
    Reload()
    Sleep(1000)
    ShowToolTip("Script could not be reloaded. Please check for errors.", 5000)
}

; Show initial tooltip
ShowToolTip("Macro ready. F1: Start, F3: Pause/Resume, F5: Reload, F6: Exit", 5000)