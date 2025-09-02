#SingleInstance Force
#Persistent
SendMode Input
CoordMode, Mouse, Screen
SetKeyDelay, 50, 30        ; wolniejsze i pewniejsze wysyłanie klawiszy

; --- DOMYŚLNE USTAWIENIA ---
Amount := 3
custom_click := 600
RandMinGlobal := 200
RandMaxGlobal := 250
toggle := false

; --- GUI USTAWIEŃ ---
Gui, New, +AlwaysOnTop
Gui, Add, Text,, How much to buy?:
Gui, Add, Edit, vGuiAmount w80 Number, %Amount%
Gui, Add, Text,, Custom click (Y):
Gui, Add, Edit, vGuiCustomClick w80 Number, %custom_click%
Gui, Add, Button, gSetNormalSpeed, Normal Speed
Gui, Add, Button, gSetFastSpeed, Fast Speed
Gui, Add, Button, gApplySettings, Save
Gui, Add, Button, gCloseGUI, Close
Gui, Show,, Script settings
return

; --- Przycisk Normal Speed ---
SetNormalSpeed:
RandMinGlobal := 200
RandMaxGlobal := 250
Tooltip, Speed set to NORMAL
SetTimer, RemoveTip, -1000
return

; --- Przycisk Fast Speed ---
SetFastSpeed:
RandMinGlobal := 100
RandMaxGlobal := 150
Tooltip, Speed set to FAST
SetTimer, RemoveTip, -1000
return

; --- Zapis ustawień GUI ---
ApplySettings:
Gui, Submit, NoHide
if (GuiAmount is number)
    Amount := GuiAmount
else
    Amount := 3

if (GuiCustomClick is number)
    custom_click := GuiCustomClick
else
    custom_click := 600

Tooltip, Settings saved.
SetTimer, RemoveTip, -1500
return

CloseGUI:
Gui, Destroy
return

RemoveTip:
Tooltip
return

; --- WŁ/WYŁ automatu (F8) ---
F8::
toggle := !toggle
if (toggle) {
    Tooltip, AUTO-BUY: ON
    SetTimer, AutoBuy, 100
} else {
    Tooltip, AUTO-BUY: OFF
    SetTimer, AutoBuy, Off
    SetTimer, RemoveTip, -1000
}
return

; --- RandSleep ---
RandSleep(min := "", max := "") {
    global RandMinGlobal, RandMaxGlobal
    if (min = "")
        min := RandMinGlobal
    if (max = "")
        max := RandMaxGlobal
    Random, d, %min%, %max%
    Sleep, d
}

; --- Tap key ---
Tap(key, hold := 40) {
    SendEvent, {%key% down}
    Sleep, hold
    SendEvent, {%key% up}
}

; --- SmoothMove ---
SmoothMove(x, y, speed := 20) {
    MouseGetPos, x0, y0
    dx := x - x0
    dy := y - y0
    steps := speed
    Loop, %steps% {
        nx := x0 + (dx * A_Index / steps)
        ny := y0 + (dy * A_Index / steps)
        MouseMove, %nx%, %ny%, 0
        Random, delay, 10, 30
        Sleep, delay
    }
}

; --- SmoothClick ---
SmoothClick(x, y) {
    SmoothMove(x, y, 30)
    Random, delay, 80, 150
    Sleep, delay
    Click, left
}

; --- Set focus in UI ---
SetUI() {
    Send, \
    RandSleep()
    Tap("Up")
    RandSleep()
    Loop, 5 {
        Tap("Left")
        RandSleep()
    }
    Tap("Up")
    RandSleep()
}

; --- Scroll down ---
ScrollDownMax(scrolls) {
    Send, \
    RandSleep()
    Send, \
    RandSleep()
    Tap("Up")
    RandSleep()
    count := scrolls + 1
    Loop, %count% {
        Tap("Down")
        RandSleep()
    }
}

; --- Buy in SEED shop ---
BuyInShopSEED(items, amount) {
    if (amount = "" || amount <= 0)
        amount := 3

    Send, \
    RandSleep()
    Send, \
    RandSleep()
    Tap("Down")
    RandSleep()
    Tap("Right")
    RandSleep()
    Tap("Down")
    RandSleep()

    Loop, %items% {
        Tap("Enter")
        RandSleep()
        Tap("Down")
        RandSleep()
        Tap("Left")
        RandSleep()
        Loop, %amount% {
            Tap("Enter")
            RandSleep()
        }
        Loop, 2 {
            Tap("Up")
            RandSleep()
        }
    }
}

; --- Buy in GEAR shop ---
BuyInShopGEAR(items, amount) {
    if (amount = "" || amount <= 0)
        amount := 3

    Send, \
    RandSleep()
    Send, \
    RandSleep()
    Tap("Down")
    RandSleep()
    Tap("Right")
    RandSleep()
    Tap("Down")
    RandSleep()

    Loop, %items% {
        Tap("Enter")
        RandSleep()
        Tap("Down")
        RandSleep()
        if (A_Index != 16) {
            Tap("Left")
            RandSleep()
        }
        Loop, %amount% {
            Tap("Enter")
            RandSleep()
        }
        Loop, 2 {
            Tap("Up")
            RandSleep()
        }
    }
}

; --- Main automation sequence ---
AutoBuy:
SetTimer, AutoBuy, Off
Sleep, 1000

; Step 1 - teleport to SEEDS
SetUI()
Loop, 3 {
    Tap("Right")
    RandSleep()
}
Tap("Enter")
RandSleep(1200, 1800)

; Step 2 - open SEEDS shop
Send, e
RandSleep(3000, 3500)

; Step 3 - scroll SEEDS shop
ScrollDownMax(26)

; Step 4 - buy in SEEDS shop
BuyInShopSEED(26, Amount)

; Step 5 - teleport to GEARS
Send, 1
RandSleep()
SmoothClick(0, custom_click)
RandSleep(900, 1300)
Send, e
RandSleep(2000, 2250)

; Step 6 - scroll GEAR shop
ScrollDownMax(18)

; Step 7 - buy in GEAR shop
BuyInShopGEAR(18, Amount)

Tap("Enter")
RandSleep()
Send, \
RandSleep(1200, 1800)

; Repeat if enabled
if (toggle)
    SetTimer, AutoBuy, 3000
return

; --- Exit ---
Esc::ExitApp
