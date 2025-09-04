<<<<<<< HEAD
﻿#Include Alignment.ahk
#Include Autobuy.ahk
#Include Functions.ahk

=======
﻿#Include Functions.ahk
#Include Autobuy.ahk
;#Include, Aligment.ahk
>>>>>>> f4a3b8e85bcc51a791fc4ba56ac89bb48942843a
#SingleInstance Force
Persistent
SendMode "Input"
CoordMode "Mouse", "Screen"
SetKeyDelay 50, 30

global settings := Map()
<<<<<<< HEAD
settings["Amount"] := 3
settings["SpeedMode"] := 0
settings["SpeedText"] := "NORMAL"
settings["AlignmentMode"] := 1
settings["AlignmentText"] := "YES"

=======

; --- Default values ---
settings["Amount"] := 3
settings["SpeedMode"] := 0
settings["speedText"] := "NORMAL"

; --- Auto Load/Save ---
>>>>>>> f4a3b8e85bcc51a791fc4ba56ac89bb48942843a
global settings := LoadSettings()
SaveSettings(settings)

global GuiOpen := false
global toggle := false
<<<<<<< HEAD
global myGui
global guiControls := Map()

OpenGUI() {
    global GuiOpen, settings, myGui, guiControls
=======
global myGui, SpeedButton, AmountEdit

; --- GUI ---
OpenGUI() {
    global GuiOpen, settings, SpeedButton, myGui, AmountEdit
>>>>>>> f4a3b8e85bcc51a791fc4ba56ac89bb48942843a
    if GuiOpen
        return

    myGui := Gui("+AlwaysOnTop +ToolWindow +Border", "Script settings")
    myGui.OnEvent("Close", (*) => CloseGUI())

    myGui.Add("Text",, "How much to buy?:")
<<<<<<< HEAD
    guiControls["AmountEdit"] := myGui.Add("Edit", "w20 Number", settings["Amount"])

    myGui.Add("Text",, "Speed:")
    guiControls["SpeedButton"] := myGui.Add("Button", "w75", settings["SpeedText"])
    guiControls["SpeedButton"].OnEvent("Click", (*) => ToggleSpeed())

    myGui.Add("Text",, "Auto-alignment:")
    guiControls["AlignmentButton"] := myGui.Add("Button", "w40", settings["AlignmentText"])
    guiControls["AlignmentButton"].OnEvent("Click", (*) => ToggleAutoAlignment())
=======
    AmountEdit := myGui.Add("Edit", "w20 Number", settings["Amount"])

    myGui.Add("Text",, "Speed:")
    SpeedButton := myGui.Add("Button", "w60", settings["speedText"])
    SpeedButton.OnEvent("Click", (*) => ToggleSpeed())
>>>>>>> f4a3b8e85bcc51a791fc4ba56ac89bb48942843a

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
<<<<<<< HEAD
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
=======
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
>>>>>>> f4a3b8e85bcc51a791fc4ba56ac89bb48942843a
    if value ~= "^\d+$"
        settings["Amount"] := value
    ToolTip "Settings applied."
    SetTimer () => ToolTip(), -1500
    SaveSettings(settings)
}

; --- Hotkeys ---
<<<<<<< HEAD
F6::ExitApp

=======
>>>>>>> f4a3b8e85bcc51a791fc4ba56ac89bb48942843a
F7::OpenGUI()

F8:: {
    global toggle
    toggle := !toggle
<<<<<<< HEAD
    if toggle {
        SetTimer AutoBuy, 100
    } 
}
=======

    if toggle {
        ToolTip("AUTO-BUY ON")  ; Timer started
        SetTimer AutoBuy, 100
    } else {
        ToolTip("AUTO-BUY STOPPING")  ; Current run may finish
        }
}


Esc::ExitApp


>>>>>>> f4a3b8e85bcc51a791fc4ba56ac89bb48942843a
