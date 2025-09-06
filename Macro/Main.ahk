#Requires AutoHotkey v2.0+
#Include Alignment.ahk
#Include Autobuy.ahk
#Include Functions.ahk
#Include Gui.ahk

#SingleInstance Force
Persistent
SendMode "Input"
CoordMode "Mouse", "Screen"

CreateDefaultSettings()
CreateDefaultItemsFile()
global items := LoadItems()
CreateDefaultItems()
global settings := LoadSettings()
SaveSettings(settings)
CreateDefaultGUI()

if (settings["AutoGuiMode"] = 1){
        OpenGUI()
    }

; --- Hotkeys ---
F6::ExitApp
F7::{
    global GuiOpen
    if (GuiOpen = true){
        CloseGUI()
    } else {
        OpenGUI()
    }
}
F8:: {
    global toggle
    toggle := !toggle
    if toggle
        SetTimer AutoBuy, 100
}