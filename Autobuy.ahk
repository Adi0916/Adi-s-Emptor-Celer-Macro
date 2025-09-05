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
    
    BuyInShopSEED(settings["Amount"])
    BuyInShopGEAR(settings["Amount"])
    BuyInShopEGGS(settings["Amount"])
    
    if toggle{
        SetTimer AutoBuy, 3000
    } else {
        ToolTip()
    }
        
}

BuyInShopSEED(amount) {
    global settings
    items := LoadItems()
    
    seedItems := items.Has("SEEDS") ? items["SEEDS"] : []
    
    reversedSeeds := []
    Loop seedItems.Length {
        i := seedItems.Length - A_Index + 1
        reversedSeeds.Push(seedItems[i])
    }
    
    ToolTip "Buying SEEDS"
    SetTimer () => ToolTip(), -5000

    TPtoSEEDS()
    ScrollDownMax(26)    

    Tap("\")
    RandSleep()
    Tap("Up")
    RandSleep()

    for index, Name in reversedSeeds{
        if (settings[Name] = 1){
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
        } else {
            Tap("Up")
            RandSleep()
        }
    }

    Tap("Enter")
    RandSleep()
    Tap("\") 
    RandSleep(1000, 1200) 

}

BuyInShopGEAR(amount) {
    global settings
    items := LoadItems()
    
    gearItems := items.Has("GEARS") ? items["GEARS"] : []
    
    reversedGears := []
    Loop gearItems.Length {
        i := gearItems.Length - A_Index + 1
        reversedGears.Push(gearItems[i])
    }
    
    ToolTip "Buying GEARS"
    SetTimer () => ToolTip(), -5000

    TPtoGEARS()
    ScrollDownMax(18)    

    Tap("\")
    RandSleep()
    Tap("Up")
    RandSleep()

    for index, Name in reversedGears{
        if (settings[Name] = 1){
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
        } else {
            Tap("Up")
            RandSleep()
        }
        
    }

    Tap("Enter")
    RandSleep()
    Tap("\") 
    RandSleep(1000, 1200)
}

BuyInShopEGGS(amount) {
    global settings
    items := LoadItems()
    
    eggItems := items.Has("EGGS") ? items["EGGS"] : []
    
    reversedEggs := []
    Loop eggItems.Length {
        i := eggItems.Length - A_Index + 1
        reversedEggs.Push(eggItems[i])
    }
    
    ToolTip "Buying EGGS"
    SetTimer () => ToolTip(), -5000

    GOtoEGGS()

    ScrollDownMax(6)

    Tap("\") 
    RandSleep()
    Tap("Up")
    RandSleep()

    for index, Name in reversedEggs {
        if (settings[Name] = 1){
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
        } else {
            Loop 2 {
                Tap("Up")
                RandSleep()
            }
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

TPtoEGGS() {
    Tap("1") 
    RandSleep()
    SafeClickRelative(0.5, 0.5)
    RandSleep(1000, 1200)
    GOtoEGGS()
}

GOtoEGGS() {
    Loop 4 {
        Tap("S")
        Sleep 20
    }
    Tap("e")
    RandSleep(3000, 3500)
    SafeClickRelative(0.75, 0.38)
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