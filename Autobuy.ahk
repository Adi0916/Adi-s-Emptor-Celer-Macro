#Include Functions.ahk


AutoBuy() {
    global toggle, settings

    SetTimer AutoBuy, 0 
    Sleep 1000

    BuyInShopSEED(26, settings["Amount"])
    BuyInShopGEAR(18, settings["Amount"])
    
    if toggle{
        SetTimer AutoBuy, 3000
    } else {
        ToolTip()
    }
        
}

BuyInShopSEED(items, amount) {
    TPtoSEEDS()
    ScrollDownMax(26)    

    Send "\"
    RandSleep()
    Send "\"
    RandSleep()
    Tap("Up")
    RandSleep()
    Loop items {
        Tap("Enter")
        RandSleep()
        Tap("Down")
        RandSleep()
        Tap("Left")
        RandSleep()
        Loop amount {
            Tap("Enter")
            RandSleep()
        }
        Loop 2 {
            Tap("Up")
            RandSleep()
        }
    }

    Tap("Enter")
    RandSleep()
    Send "\"
    RandSleep(1200, 1800) 
}

BuyInShopGEAR(items, amount) {
    TPtoGEARS()
    ScrollDownMax(18)    

    Send "\"
    RandSleep()
    Send "\"
    RandSleep()
    Tap("Up")
    RandSleep()

    Loop items {
        Tap("Enter")
        RandSleep()
        Tap("Down")
        RandSleep()
        if (A_Index != 16) {
            Tap("Left")
            RandSleep()
        }
        Loop amount {
            Tap("Enter")
            RandSleep()
        }
        Loop 2 {
            Tap("Up")
            RandSleep()
        }
    }

    Tap("Enter")
    RandSleep()
    Send "\"
    RandSleep(1200, 1800)
}

TPtoSEEDS() {
    Send "\"
    RandSleep()
    Tap("Up")
    RandSleep()
    Tap("Enter")
    RandSleep(1200, 1800)
    Send "e"
    RandSleep(3000, 3500)
}

TPtoGEARS() {
    global ScreenHeight
    Send "1"
    RandSleep()
    SmoothClick(0, ScreenHeight/4)
    RandSleep(900, 1300)
    Send "e"
    RandSleep(3000, 3500)
    Send "\"
    RandSleep()
}

ScrollDownMax(scrolls) {
    Send "\"
    RandSleep()
    Send "\"
    RandSleep()
    Tap("Up")
    RandSleep()
    count := scrolls + 1
    Loop count {
        Tap("Down")
        RandSleep()
    }
}

