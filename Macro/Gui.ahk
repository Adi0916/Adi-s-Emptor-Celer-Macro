OpenGUI() {
    global GuiOpen, settings, myGui, guiControls
    global items := LoadItems()
    if GuiOpen
        return

    myGui := Gui("+AlwaysOnTop +ToolWindow +Border", "Emptor settings")
    myGui.OnEvent("Close", CloseGUI)

    ; --- Categories ---
    catX := 10, catY := 5, catWidth := 60
    guiControls["GUIAutoBuy"] := myGui.Add("Button", Format("x{} y{} w{}", catX, catY, catWidth), "AutoBuy")
    guiControls["GUIAutoBuy"].OnEvent("Click", (*) => OpenAutoBuyGUI()) ; Otwiera aktualne GUI
    catX += catWidth + 5
    guiControls["GUIAutoCraft"] := myGui.Add("Button", Format("x{} y{} w{}", catX, catY, catWidth), "AutoCraft")
    guiControls["GUIAutoCraft"].OnEvent("Click", (*) => OpenAutoCraftGUI()) ; Zamknie to GUI i otworzy AutoCraft
    catX += catWidth + 5
    ;guiControls["GUIAutoSMTH"] := myGui.Add("Button", Format("x{} y{} w{}", catX, catY, catWidth), "Coming...")

    ; --- LEFT PANEL: Kategorie i przedmioty ---
    x := 20, y := 35
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
            itemTextCtrl.SetFont("s8")
            
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

    myGui.Show("w740 h455")  ; Zwiększono rozmiar GUI
    GuiOpen := true
}

; Funkcja do otwierania GUI AutoBuy (aktualne GUI)
OpenAutoBuyGUI() {
    global GuiOpen
    if !GuiOpen
        OpenGUI()
}

; Funkcja do otwierania GUI AutoCraft
OpenAutoCraftGUI() {
    global GuiOpen, myGui
    if GuiOpen {
        myGui.Destroy()
        GuiOpen := false
    }
    
    ; Tutaj dodasz kod tworzący GUI AutoCraft
    CreateAutoCraftGUI()
}

; Funkcja do tworzenia GUI AutoCraft (na razie pusta)
CreateAutoCraftGUI() {
    global GuiOpen, autoCraftGui
    
    autoCraftGui := Gui("+AlwaysOnTop +ToolWindow +Border", "AutoCraft Settings")
    autoCraftGui.OnEvent("Close", (*) => (autoCraftGui.Destroy(), GuiOpen := false))
    
    ; Przycisk powrotu do głównego GUI
    backBtn := autoCraftGui.Add("Button", "x10 y10 w60", "Back")
    backBtn.OnEvent("Click", (*) => (
        autoCraftGui.Destroy(),
        GuiOpen := false,
        OpenGUI()
    ))
    
    ; --- TUTAJ DODASZ SWOJĄ IMPLEMENTACJĘ AUTOCRAFT ---
    autoCraftGui.Add("Text", "x10 y50", "AutoCraft GUI - do implementacji")
    
    autoCraftGui.Show("w400 h300")
    GuiOpen := true
}

CloseGUI(*) {
    global GuiOpen, myGui
    myGui.Destroy()
    GuiOpen := false
}