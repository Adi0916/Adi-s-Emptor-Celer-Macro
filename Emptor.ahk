#Include Alignment.ahk
#Include Autobuy.ahk
#Include Functions.ahk

#SingleInstance Force
Persistent
SendMode "Input"
CoordMode "Mouse", "Screen"
SetKeyDelay 50, 30

global settings := Map()
settings["Amount"] := 3
settings["SpeedMode"] := 0
settings["SpeedText"] := "NORMAL"
settings["AlignmentMode"] := 1
settings["AlignmentText"] := "YES"

global settings := LoadSettings()
SaveSettings(settings)

global GuiOpen := false
global toggle := false
global myGui
global guiControls := Map()

OpenGUI() {
    global GuiOpen, settings, myGui, guiControls
    if GuiOpen
        return

    myGui := Gui("+AlwaysOnTop +ToolWindow +Border", "Script settings")
    myGui.OnEvent("Close", (*) => CloseGUI())

    myGui.Add("Text",, "How much to buy?:")
    guiControls["AmountEdit"] := myGui.Add("Edit", "w20 Number", settings["Amount"])

    myGui.Add("Text",, "Speed:")
    guiControls["SpeedButton"] := myGui.Add("Button", "w75", settings["SpeedText"])
    guiControls["SpeedButton"].OnEvent("Click", (*) => ToggleSpeed())

    myGui.Add("Text",, "Auto-alignment:")
    guiControls["AlignmentButton"] := myGui.Add("Button", "w40", settings["AlignmentText"])
    guiControls["AlignmentButton"].OnEvent("Click", (*) => ToggleAutoAlignment())

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
    global settings, guiControls

    if (settings["SpeedMode"] = 0) {
        settings["SpeedMode"] := 1
        settings["SpeedText"] := "FAST #1"
    } else if (settings["SpeedMode"] = 1) {
        settings["SpeedMode"] := 2
        settings["SpeedText"] := "ULTRA #2"
    } else if (settings["SpeedMode"] = 2) {
        settings["SpeedMode"] := 3
        settings["SpeedText"] := "HYPER #3"
    } else if (settings["SpeedMode"] = 3) {
        settings["SpeedMode"] := 4
        settings["SpeedText"] := "INSANE #4"
    } else {
        settings["SpeedMode"] := 0
        settings["SpeedText"] := "NORMAL #0"
    }

    ApplySpeed()
    guiControls["SpeedButton"].Text := settings["SpeedText"]
}

ToggleAutoAlignment() {
    global settings, guiControls
    settings["AlignmentMode"] := settings["AlignmentMode"] ? 0 : 1
    settings["AlignmentText"] := settings["AlignmentMode"] ? "YES" : "NO"

    guiControls["AlignmentButton"].Text := settings["AlignmentText"]
}

ApplySettings() {
    global settings, guiControls
    value := guiControls["AmountEdit"].Text
    if value ~= "^\d+$"
        settings["Amount"] := value
    ToolTip "Settings applied."
    SetTimer () => ToolTip(), -1500
    SaveSettings(settings)
}

; --- Hotkeys ---
F6::ExitApp

F7::OpenGUI()

F8:: {
    global toggle
    toggle := !toggle
    if toggle {
        SetTimer AutoBuy, 100
    } 
}
