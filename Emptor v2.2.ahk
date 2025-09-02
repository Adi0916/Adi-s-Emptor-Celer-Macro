#Include, Functions.ahk
#SingleInstance Force
#Persistent
SendMode Input
CoordMode, Mouse, Screen
SetKeyDelay, 50, 30

global settings := {}
settings["Amount"] := 3
settings["SpeedMode"] := 1

ApplySpeedMode()

global GuiOpen := false
global toggle := false
global SpeedButton

; --- GUI ---
OpenGUI() {
    global GuiOpen, settings, SpeedButton
    if GuiOpen
        return
    Gui, New, +AlwaysOnTop +ToolWindow +Border
    Gui, Add, Text,, How much to buy?:
    Gui, Add, Edit, vGuiAmount w80 Number, % settings["Amount"]
    speedText := (settings["SpeedMode"] = 1) ? "Speed: NORMAL" : "Speed: FAST"
    Gui, Add, Button, gToggleSpeed w100 vSpeedButton, %speedText%
    Gui, Add, Button, gApplySettings w80, Save
    Gui, Show,, Script settings
    GuiOpen := true
}

CloseGUI() {
    global GuiOpen
    Gui, Destroy
    GuiOpen := false
}

ToggleSpeed:
    global settings, SpeedButton
    settings["SpeedMode"] := (settings["SpeedMode"] = 1) ? 2 : 1
    newText := (settings["SpeedMode"] = 1) ? "Speed: NORMAL" : "Speed: FAST"
    GuiControl,, SpeedButton, %newText%
    ApplySpeedMode()
return

ApplySettings:
    Gui, Submit, NoHide
    if (GuiAmount is number)
        settings["Amount"] := GuiAmount
    ApplySpeedMode()
    Tooltip, Settings applied.
    SetTimer, RemoveTip, -1500
return

RemoveTip:
    Tooltip
return

GuiClose:
    CloseGUI()
return

; --- Hotkeys ---
F7::OpenGUI()

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

; --- Main automation ---
AutoBuy:
    SetTimer, AutoBuy, Off
    Sleep, 1000
    TPtoSEEDS()
    OpenSEEDS()
    ScrollDownMax(26)
    BuyInShopSEED(26, settings["Amount"])
    TPtoGEARS()
    ScrollDownMax(18)
    BuyInShopGEAR(18, settings["Amount"])
    if (toggle)
        SetTimer, AutoBuy, 3000
return

Esc::ExitApp
