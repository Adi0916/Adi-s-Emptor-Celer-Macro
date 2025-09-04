#Include Functions.ahk
#Include Alignment.ahk
i := 0

AutoBuy() {
    global toggle, settings, i

    SetTimer AutoBuy, 0 
    Sleep 1000

    if (i = 0){
        alignment(settings["AlignmentMode"])
        i++
    }
    
    BuyInShopSEED(26, settings["Amount"])
    BuyInShopGEAR(18, settings["Amount"])
    BuyInShopEGGS(6, settings["Amount"])
    
    if toggle{
        SetTimer AutoBuy, 3000
    } else {
        ToolTip()
    }
        
}

BuyInShopSEED(items, amount) {
    ToolTip "Buying SEEDS"
    SetTimer () => ToolTip(), -5000

    TPtoSEEDS()
    ScrollDownMax(26)    

    Tap("\")
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
    Tap("\") 
    RandSleep(1000, 1200) 

}

BuyInShopGEAR(items, amount) {
    ToolTip "Buying GEARS"
    SetTimer () => ToolTip(), -5000

    TPtoGEARS()
    ScrollDownMax(18)    

    Tap("\")
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
    Tap("\") 
    RandSleep(1000, 1200)
}

BuyInShopEGGS(items, amount) {
    ToolTip "Buying EGGS"
    SetTimer () => ToolTip(), -5000

    Loop 4 { ;go to egg shop
        Tap("S")
        Sleep 20
    }
    Tap("e")
    RandSleep(3000, 3500)
    SafeClickRelative(0.75, 0.38)
    RandSleep(3000, 3500) ;here egg shop open

    ScrollDownMax(6)

    Tap("\") 
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
        Loop 3 {
            Tap("Up")
            RandSleep()
        }
    }

    Tap("Left")
    RandSleep()
    Tap("Up")
    RandSleep()
    Loop 5{
        Tap("Right")
        RandSleep()
    }
    Tap("Down")
    RandSleep()
    Tap("Enter")
    RandSleep()
    Tap("\") 
    RandSleep(1000, 1200)
}

TPtoSEEDS() {
    Tap("\") 
    RandSleep()
    Tap("Up")
    RandSleep()
    Tap("Enter")
    RandSleep(1000, 1200)
    Tap("e") 
    RandSleep(3000, 3500)
    Tap("\") 
    RandSleep()
}

TPtoGEARS() {
    Tap("1") 
    RandSleep()
    SafeClickRelative(0.5, 0.5)
    RandSleep(1000, 1200)
    Tap("e") 
    RandSleep(3000, 3500)
}

ScrollDownMax(scrolls) {
    Tap("\")
    RandSleep()
    Tap("Up")
    RandSleep()
    count := scrolls + 1
    Loop count {
        Tap("Down")
        RandSleep()
    }
    Tap("\")
    RandSleep()
}