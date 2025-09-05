#Include Functions.ahk

alignment(settings) {
    ToolTip "Camera alignment"

    SafeClickRelative(0.5, 0.5)
    RandSleep(100,150)

    if (settings = 1) {
        cameraChange()
        RandSleep(100,150)
        zoomAlignment()
        RandSleep(100,150)
        cameraAlignment()
        RandSleep(100,150)
        characterAlignment()
        RandSleep(100,150)
        cameraChange()
        RandSleep(1000,1300)
    } 
}

cameraChange() {
    Tap("Escape")
    RandSleep(100,150)
    Tap("Tab")
    RandSleep(100,150)
    Tap("Down")
    RandSleep(100,150)
    Loop 2{
        Tap("Right")
        RandSleep(100,150)
    }
    Tap("Escape")
    RandSleep(100,150)
}

cameraAlignment() {
    Click "Right Down"
    RandSleep(100,150)
    SafeMoveRelative(0.5, 0.5)
    RandSleep(100,150)
    MouseMove 0, 800, 0, "R"
    RandSleep(100,150)
    Click "Right Up"
}

zoomAlignment() {
    global midX, midY
    SafeMoveRelative(0.5, 0.5)
    RandSleep(100,150)

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
    RandSleep(100,150)

    Tap("Up")
    RandSleep(100,150)

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

    RandSleep(100,150)
    Tap("\")
}
