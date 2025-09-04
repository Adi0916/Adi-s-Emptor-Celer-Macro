#Include Functions.ahk
#Include Autobuy.ahk
;#Include, Aligment.ahk
#SingleInstance Force
Persistent
SendMode "Input"
CoordMode "Mouse", "Screen"
SetKeyDelay 50, 30

global settings := Map()

; --- Default values ---
settings["Amount"] := 3
settings["SpeedMode"] := 0
settings["speedText"] := "NORMAL"

; --- Auto Load/Save ---
global settings := LoadSettings()
SaveSettings(settings)

global GuiOpen := false
global toggle := false
global myGui, SpeedButton, AmountEdit

; --- GUI ---
OpenGUI() {
    global GuiOpen, settings, SpeedButton, myGui, AmountEdit
    if GuiOpen
        return

    myGui := Gui("+AlwaysOnTop +ToolWindow +Border", "Script settings")
    myGui.OnEvent("Close", (*) => CloseGUI())

    myGui.Add("Text",, "How much to buy?:")
    AmountEdit := myGui.Add("Edit", "w20 Number", settings["Amount"])

    myGui.Add("Text",, "Speed:")
    SpeedButton := myGui.Add("Button", "w60", settings["speedText"])
    SpeedButton.OnEvent("Click", (*) => ToggleSpeed())

    SaveBtn := myGui.Add("Button", "w90", "Save")
    SaveBtn.OnEvent("Click", (*) => ApplySettings())

    myGui.Show()
    GuiOpen := true
}

CloseGUI() {
    global GuiOpen, myGui
    if myGui
        myGui.Destroy()
    GuiOpen := false
}

ToggleSpeed() {
    global settings, SpeedButton

    if (settings["SpeedMode"] = 0) {
        settings["SpeedMode"] := 1
        settings["speedText"] := "FAST"
    } else {
        settings["SpeedMode"] := 0
        settings["speedText"] := "NORMAL"
    }
    
    ApplySpeed()

    SpeedButton.Text := settings["speedText"]
}

ApplySettings() {
    global settings, AmountEdit
    value := AmountEdit.Text
    if value ~= "^\d+$"
        settings["Amount"] := value
    ToolTip "Settings applied."
    SetTimer () => ToolTip(), -1500
    SaveSettings(settings)
}

; --- Hotkeys ---
F7::OpenGUI()

F8:: {
    global toggle
    toggle := !toggle

    if toggle {
        ToolTip("AUTO-BUY ON")  ; Timer started
        SetTimer AutoBuy, 100
    } else {
        ToolTip("AUTO-BUY STOPPING")  ; Current run may finish
        }
}


Esc::ExitApp


