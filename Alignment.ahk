#Include Functions.ahk

alignment(settings) {
    ToolTip "Camera alignment"

    SafeClickRelative(0.5, 0.5)
    RandSleep()

    if (settings = 1) {
        cameraChange()
        RandSleep()
        zoomAlignment()
        RandSleep()
        cameraAlignment()
        RandSleep()
        characterAlignment()
        RandSleep()
        cameraChange()
        RandSleep(1000,1300)
    } else {
        zoomAlignment()
        RandSleep(1000,1300)
    }

}

cameraChange() {
    Tap("Escape")
    RandSleep()
    Tap("Tab")
    RandSleep()
    Tap("Down")
    RandSleep()
    Loop 2{
        Tap("Right")
        RandSleep()
    }
    Tap("Escape")
    RandSleep()
}

cameraAlignment() {
    Click "Right Down"
    RandSleep()
    SafeMoveRelative(0.5, 0.5)
    RandSleep()
    MouseMove 0, 800, 0, "R"
    RandSleep()
    Click "Right Up"
}

zoomAlignment() {
    global midX, midY
    SafeMoveRelative(0.5, 0.5)
    RandSleep()

    Loop 40 {
        Tap("WheelUp")
        Sleep 10
    }
    Sleep 10

    Loop 3 {
        Tap("WheelDown")
        Sleep 10
    }
    Sleep 10

    midX := getMouseCoord("x")
    midY := getMouseCoord("y")
}

characterAlignment() {
    Tap("\")
    RandSleep()

    Tap("Up")
    RandSleep()

    Loop 2{
        Tap("Right")
        Sleep 20
    }

    Loop 8 {
        Tap("Enter")
        Sleep 20
        Loop 2{
            Tap("Left")
        }
        Sleep 20
        Tap("Enter")
        Sleep 20
        Loop 2{
            Tap("Right")
        }
        Sleep 20
    }

    RandSleep()
    Tap("\")
}