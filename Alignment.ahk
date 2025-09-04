alignment() {
    ToolTip "Beginning Alignment"
    SetTimer () => ToolTip(), -5000

    SafeClickRelative(0.5, 0.5)
    Sleep 100

    searchitem("recall")
    Sleep 200

    if (AutoAlign) {
        cameraChange()
        Sleep 100
        zoomAlignment()
        Sleep 100
        cameraAlignment()
        Sleep 100
        characterAlignment()
        Sleep 100
        cameraChange()
        Sleep 100
    } else {
        zoomAlignment()
        Sleep 100
    }

    Sleep 1000
    uiUniversal(11110)
    Sleep 100

    ToolTip "Alignment Complete"
    SetTimer () => ToolTip(), -1000
}

cameraChange() {
    ; zmiana trybu kamery (follow)
    Send "{Escape}"
    Sleep 500
    Send "{Tab}"
    Sleep 400
    Send "{Down}"
    Sleep 100
    repeatKey("Right", 2, (SavedSpeed = "Ultra") ? 55 : (SavedSpeed = "Max") ? 60 : 30)
    Sleep 100
    Send "{Escape}"
}

cameraAlignment() {
    ; ustawia widok z góry
    Click "Right Down"
    Sleep 200
    SafeMoveRelative(0.5, 0.5)
    Sleep 200
    MouseMove 0, 800, 0, "R"
    Sleep 200
    Click "Right Up"
}

zoomAlignment() {
    ; ustawia poprawny zoom
    SafeMoveRelative(0.5, 0.5)
    Sleep 100

    Loop 40 {
        Send "{WheelUp}"
        Sleep 20
    }
    Sleep 200

    Loop 6 {
        Send "{WheelDown}"
        Sleep 20
    }

    midX := getMouseCoord("x")
    midY := getMouseCoord("y")
}

characterAlignment() {
    ; wyrównuje postać spamując TP + follow camera
    sendKeybind(SavedKeybind)
    Sleep 10

    repeatKey("Right", 3)
    Loop ((SavedSpeed = "Ultra") ? 12 : (SavedSpeed = "Max") ? 18 : 8) {
        Send "{Enter}"
        Sleep 10
        repeatKey("Right", 2)
        Sleep 10
        Send "{Enter}"
        Sleep 10
        repeatKey("Left", 2)
        Sleep 10
    }

    Sleep 10
    sendKeybind(SavedKeybind)
}

SafeMoveRelative(xRatio, yRatio) {
    if WinExist("ahk_exe RobloxPlayerBeta.exe") {
        WinGetPos &winX, &winY, &winW, &winH, "ahk_exe RobloxPlayerBeta.exe"
        moveX := winX + Round(xRatio * winW)
        moveY := winY + Round(yRatio * winH)
        MouseMove moveX, moveY
    }
}

SafeClickRelative(xRatio, yRatio) {
    if WinExist("ahk_exe RobloxPlayerBeta.exe") {
        WinGetPos &winX, &winY, &winW, &winH, "ahk_exe RobloxPlayerBeta.exe"
        clickX := winX + Round(xRatio * winW)
        clickY := winY + Round(yRatio * winH)
        Click clickX, clickY
    }
}
