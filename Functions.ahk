; Pobranie rozdzielczości ekranu
ScreenWidth := SysGet(78)
ScreenHeight := SysGet(79)

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
    global RandMin, RandMax
    if (settings["SpeedMode"] = 0) {
        RandMin := 200
        RandMax := 250
    } else {
        RandMin := 100
        RandMax := 150
    }
}

RandSleep(min := "", max := "") {
    global RandMin, RandMax
    if (min = "")
        min := RandMin
    if (max = "")
        max := RandMax
    d := Random(min, max)
    Sleep d
}

Tap(key, hold := 40) {
    SendEvent "{" key " down}"
    Sleep hold
    SendEvent "{" key " up}"
}

SmoothMove(x, y, speed := 20) {
    MouseGetPos &x0, &y0
    dx := x - x0
    dy := y - y0
    steps := speed
    Loop steps {
        nx := x0 + (dx * A_Index / steps)
        ny := y0 + (dy * A_Index / steps)
        MouseMove nx, ny, 0
        delay := Random(10, 30)
        Sleep delay
    }
}

SmoothClick(x, y) {
    SmoothMove(x, y, 30)
    delay := Random(80, 150)
    Sleep delay
    Click "left"
}

ScrollDownMax(scrolls) {
    Send "\"
    RandSleep()
    Send "\"
    RandSleep()
    Tap("Up")
    RandSleep()
    count := scrolls + 1
    Loop count {
        Tap("Down")
        RandSleep()
    }
}

BuyInShopSEED(items, amount) {
    if (amount = "" || amount <= 0)
        amount := 3

    Send "\"
    RandSleep()
    Send "\"
    RandSleep()
    Tap("Up")
    RandSleep()
   
    Loop items {
        Tap("Enter")
        RandSleep()
        Tap("Down")
        RandSleep()
        Tap("Left")
        RandSleep()
        Loop amount {
            Tap("Enter")
            RandSleep()
        }
        Loop 2 {
            Tap("Up")
            RandSleep()
        }
    }
}

BuyInShopGEAR(items, amount) {
    if (amount = "" || amount <= 0)
        amount := 3

    Send "\"
    RandSleep()
    Send "\"
    RandSleep()
    Tap("Up")
    RandSleep()

    Loop items {
        Tap("Enter")
        RandSleep()
        Tap("Down")
        RandSleep()
        if (A_Index != 16) {
            Tap("Left")
            RandSleep()
        }
        Loop amount {
            Tap("Enter")
            RandSleep()
        }
        Loop 2 {
            Tap("Up")
            RandSleep()
        }
    }

    Tap("Enter")
    RandSleep()
    Send "\"
    RandSleep(1200, 1800)
}

TPtoSEEDS() {
    Send "\"
    RandSleep()
    Tap("Up")
    RandSleep()
    Tap("Enter")
    RandSleep(1200, 1800)
}

TPtoGEARS() {
    global ScreenHeight
    Send "1"
    RandSleep()
    SmoothClick(0, ScreenHeight/4)
    RandSleep(900, 1300)
    Send "e"
    RandSleep(3000, 3500)
}

OpenSEEDS() {
    Send "e"
    RandSleep(3000, 3500)
}
