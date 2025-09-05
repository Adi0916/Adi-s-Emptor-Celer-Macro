#Include Alignment.ahk
#Include Autobuy.ahk
#Include Functions.ahk

#SingleInstance Force
Persistent
SendMode "Input"
CoordMode "Mouse", "Screen"
;SetitemTextDelay 50, 30

CreateDefaultSettings()

CreateDefaultItemsFile()

global items := LoadItems()

CreateDefaultItems()

global settings := LoadSettings()

SaveSettings(settings)

CreateDefaultGUI()

if (settings["AutoGuiMode"] = 1)
    OpenGUI()

OpenGUI() {
    global GuiOpen, settings, myGui, guiControls
    global items := LoadItems()
    if GuiOpen
        return

    myGui := Gui("+AlwaysOnTop +ToolWindow +Border", "Script settings")
    myGui.OnEvent("Close", CloseGUI)

    ; --- LEFT PANEL: Kategorie i przedmioty ---
    x := 20, y := 20
    spacingX := 150, spacingY := 15  ; Zwiększono odstępy
    btnSize := 15  ; Zwiększono rozmiar przycisku
    textWidth := 100  ; szerokość dla nazwy przedmiotu

    guiControls := Map()
    guiControls["ItemButtons"] := []

    ; Ustalona kolejność kategorii
    categories := ["SEEDS", "GEARS", "EGGS", "COSMETICS"]

    for i, cat in categories {
        objList := items[cat]  ; pobierz przedmioty z mapy wg nazwy kategorii
        colX := x + spacingX*(i-1)
        myGui.Add("Text", Format("x{} y{}", colX, y), cat)

        itemStartY := y + 25
        for j, itemText in objList {
            ; Dodaj nazwę przedmiotu
            itemY := itemStartY + spacingY*(j-1)
            itemTextCtrl := myGui.Add("Text", Format("x{} y{} w{}", colX, itemY, textWidth), itemText)
            itemTextCtrl.SetFont("s7")
            
            ; Dodaj przycisk obok nazwy
            btnX := colX + textWidth + 5  ; Pozycja X przycisku - obok tekstu
            btn := myGui.Add("Button", Format("x{} y{} w{} h{}", btnX, itemY, btnSize, btnSize), "")

            ; ustaw początkowy stan guzika
            btn.Text := settings[itemText] ? "X" : ""

            ; callback dla każdego guzika
            btn.OnEvent("Click", ToggleItemMode.Bind(btn, itemText))

            guiControls["ItemButtons"].Push(btn)
        }
    }

    ; --- RIGHT PANEL: ustawienia ---
    labelX := 620, ctrlY := y
    spacingRight := 50

    myGui.Add("Text", Format("x{} y{}", labelX, ctrlY), "Amount to buy?:")
    guiControls["AmountEdit"] := myGui.Add("Edit", Format("x{} y{} w40 Number", labelX, ctrlY + 20), settings["Amount"])
    ctrlY += spacingRight

    myGui.Add("Text", Format("x{} y{}", labelX, ctrlY), "Speed:")
    guiControls["SpeedButton"] := myGui.Add("Button", Format("x{} y{} w100", labelX, ctrlY + 20), settings["SpeedText"])
    guiControls["SpeedButton"].OnEvent("Click", ToggleSpeed)
    ctrlY += spacingRight

    myGui.Add("Text", Format("x{} y{}", labelX, ctrlY), "Auto-alignment:")
    guiControls["AlignmentButton"] := myGui.Add("Button", Format("x{} y{} w50", labelX, ctrlY + 20), settings["AlignmentText"])
    guiControls["AlignmentButton"].OnEvent("Click", ToggleAutoAlignment)
    ctrlY += spacingRight

    myGui.Add("Text", Format("x{} y{}", labelX, ctrlY), "Auto-open GUI:")
    guiControls["AutoGuiButton"] := myGui.Add("Button", Format("x{} y{} w50", labelX, ctrlY + 20), settings["AutoGuiText"])
    guiControls["AutoGuiButton"].OnEvent("Click", ToggleAutoGui)
    ctrlY += spacingRight

    SaveBtn := myGui.Add("Button", Format("x{} y{} w100", labelX, ctrlY), "Save")
    SaveBtn.OnEvent("Click", ApplySettings)

    myGui.Show("w740 h450")  ; Zwiększono rozmiar GUI
    GuiOpen := true
}

ToggleItemMode(btn, itemText, *) {
    global settings
    settings[itemText] := !settings[itemText]  ; przełączamy 0 <-> 1
    btn.Text := settings[itemText] ? "X" : ""
}

CloseGUI(*) {
    global GuiOpen, myGui
    myGui.Destroy()
    GuiOpen := false
}

ToggleSpeed(*) {
    global settings, guiControls
    ; zmiana trybu prędkości
    if (settings["SpeedMode"] = 0) {
        settings["SpeedMode"] := 1, settings["SpeedText"] := "FAST #1"
    } else if (settings["SpeedMode"] = 1) {
        settings["SpeedMode"] := 2, settings["SpeedText"] := "ULTRA #2"
    } else if (settings["SpeedMode"] = 2) {
        settings["SpeedMode"] := 3, settings["SpeedText"] := "HYPER #3"
    } else if (settings["SpeedMode"] = 3) {
        settings["SpeedMode"] := 4, settings["SpeedText"] := "INSANE #4"
    } else {
        settings["SpeedMode"] := 0, settings["SpeedText"] := "NORMAL #0"
    }
    ApplySpeed()
    guiControls["SpeedButton"].Text := settings["SpeedText"]
}

ToggleAutoAlignment(*) {
    global settings, guiControls
    settings["AlignmentMode"] := settings["AlignmentMode"] ? 0 : 1
    settings["AlignmentText"] := settings["AlignmentMode"] ? "YES" : "NO"
    guiControls["AlignmentButton"].Text := settings["AlignmentText"]
}

ToggleAutoGui(*) {
    global settings, guiControls
    settings["AutoGuiMode"] := settings["AutoGuiMode"] ? 0 : 1
    settings["AutoGuiText"] := settings["AutoGuiMode"] ? "YES" : "NO"
    guiControls["AutoGuiButton"].Text := settings["AutoGuiText"]
}

ApplySettings(*) {
    global settings, guiControls
    value := guiControls["AmountEdit"].Text
    if value ~= "^\d+$"
        settings["Amount"] := value
    ToolTip "Settings applied."
    SetTimer () => ToolTip(), -1500
    SaveSettings(settings)
}

; --- HotitemTexts ---
F6::ExitApp
F7::OpenGUI()
F8:: {
    global toggle
    toggle := !toggle
    if toggle
        SetTimer AutoBuy, 100
}