SaveSettings(settings) {
    file := FileOpen("settings.txt", "w", "UTF-8")  ; tryb w = nadpisanie
    for key, value in settings {
        file.WriteLine(key "=" value)
    }
    file.Close()
}

LoadSettings() {
    if !FileExist("settings.txt")
        return settings

    content := FileRead("settings.txt", "UTF-8")
    for line in StrSplit(content, "`n", "`r") {
        if !line
            continue
        parts := StrSplit(line, "=")
        if (parts.Length = 2) {
            key := parts[1]
            val := parts[2]
            if val ~= "^\d+$"
                val := Integer(val)
            settings[key] := val
        }
    }
    return settings
}

ApplySpeed() {
    global RandMin, RandMax, settings
    if (settings["SpeedMode"] = 0) {
        RandMin := 200
        RandMax := 250
    } else if (settings["SpeedMode"] = 1) {
        RandMin := 100
        RandMax := 150
    } else if (settings["SpeedMode"] = 2) {
        RandMin := 50
        RandMax := 75
    } else if (settings["SpeedMode"] = 3) {
        RandMin := 20
        RandMax := 40
    } else if (settings["SpeedMode"] = 4) {
        RandMin := 10
        RandMax := 20
    } 
}

RandSleep(min := "", max := "") {
    ApplySpeed()
    global RandMin, RandMax

    if (min = "" || max = "") {
        min := RandMin
        max := RandMax
    }
    Sleep Random(min, max)
}


Tap(key, hold := 40) {
    SendEvent "{" key " down}"
    Sleep hold
    SendEvent "{" key " up}"
}

SafeMoveRelative(xRatio, yRatio, steps := 20) {
    hwnd := WinExist("ahk_exe RobloxPlayerBeta.exe")
    if !hwnd
        return

    x := 0, y := 0, w := 0, h := 0
    WinGetPos(&x, &y, &w, &h, "ahk_id " hwnd)

    targetX := x + Round(xRatio * w)
    targetY := y + Round(yRatio * h)

    MouseGetPos &curX, &curY

    Loop steps {
        t := A_Index / steps
        moveX := curX + Round((targetX - curX) * t)
        moveY := curY + Round((targetY - curY) * t)
        MouseMove moveX, moveY, 0
        Sleep 20
    }

    MouseMove targetX, targetY
}



SafeClickRelative(xRatio, yRatio) {
    hwnd := WinExist("ahk_exe RobloxPlayerBeta.exe")
    if !hwnd
        return

    x := 0, y := 0, w := 0, h := 0
    WinGetPos(&x, &y, &w, &h, "ahk_id " hwnd)

    clickX := x + Round(xRatio * w)
    clickY := y + Round(yRatio * h)

    SafeMoveRelative(xRatio, yRatio)
    RandSleep()
    Click
    RandSleep()
}






getMouseCoord(axis) {
    win := WinGetPos(, , , , "ahk_exe RobloxPlayerBeta.exe")
    if (win = "")
        return ""

    winX := win.X
    winY := win.Y
    winW := win.W
    winH := win.H

    CoordMode("Mouse", "Screen")
    mouse := MouseGetPos()

    relX := (mouse.X - winX) / winW
    relY := (mouse.Y - winY) / winH

    if (axis = "x")
        return relX
    else if (axis = "y")
        return relY

    return ""
}