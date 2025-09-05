#Include Functions.ahk
#Include Alignment.ahk
i := 0

AutoBuy() {
    global toggle, settings, i
    seedItems := items.Has("SEEDS") ? items["SEEDS"] : []
    gearItems := items.Has("GEARS") ? items["GEARS"] : []
    eggItems := items.Has("EGGS") ? items["EGGS"] : []

    SetTimer AutoBuy, 0
    Sleep 1000

    if (i = 0) {
        alignment(settings["AlignmentMode"])
        i++
    }
    
    ; Sprawdź czy którykolwiek z seedItems ma wartość 1
    anySeed := false
    for item in seedItems {
        if (settings[item] = 1) {
            anySeed := true
            break
        }
    }
    
    if (anySeed) {
        BuyInShopSEED(settings["Amount"])
    }

    GearsOccured := false
    ; Sprawdź czy którykolwiek z gearItems ma wartość 1
    for item in gearItems {
        if (settings[item] = 1) {
            BuyInShopGEAR(settings["Amount"])
            GearsOccured := true
            break
        }
    }

    ; Sprawdź czy którykolwiek z eggItems ma wartość 1
    anyEgg := false
    for item in eggItems {
        if (settings[item] = 1) {
            anyEgg := true
            break
        }
    }

    if (anyEgg && !GearsOccured) {
        TPtoEGGS()
        BuyInShopEGGS(settings["Amount"])
    }
    
    if (anyEgg && GearsOccured) {
        GOtoEGGS()
        BuyInShopEGGS(settings["Amount"])
    }

    if (settings["Buy All"] = 1) {
        TPtoCOSMETICS()
        BuyInShopCOSMETICS(settings["Amount"])
    }
    
    if (toggle) {
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

    TPtoSEEDS()
    ScrollDownMax(26)    

    Tap("\")
    RandSleep()
    Tap("Up")
    RandSleep()

    itemsToBuy := 0
    for index, Name in reversedSeeds {
        if (settings[Name] = 1) {
            itemsToBuy++
        }
    }
    
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
            
            if (itemsToBuy = 1) {
                Tap("Up")
                RandSleep()
                Tap("Enter")
                RandSleep()
                Tap("Up")
                RandSleep()    
            } else{
                Loop 2 {
                    Tap("Up")
                    RandSleep()
                }
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
    Tooltip()
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

    TPtoGEARS()
    ScrollDownMax(18)    

    Tap("\")
    RandSleep()
    Tap("Up")
    RandSleep()

    itemsToBuy := 0
    for index, Name in reversedGears {
        if (settings[Name] = 1) {
            itemsToBuy++
        }
    }

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
            
            if (itemsToBuy = 1) {
                Tap("Up")
                RandSleep()
                Tap("Enter")
                RandSleep()
                Tap("Up")
                RandSleep()    
            } else{
                Loop 2 {
                    Tap("Up")
                    RandSleep()
                }
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
    Tooltip()
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

    ScrollDownMax(6)

    Tap("\") 
    RandSleep()
    Tap("Up")
    RandSleep()

    itemsToBuy := 0
    for index, Name in reversedEggs {
        if (settings[Name] = 1) {
            itemsToBuy++
        }
    }

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
            
            if (itemsToBuy = 1) {
                Tap("Up")
                RandSleep()
                Tap("Enter")
                RandSleep()
                Loop 2 {
                    Tap("Up")
                    RandSleep()  
                }
            } else{
                Loop 3 {
                    Tap("Up")
                    RandSleep()
                }
            }

        } else {
            Loop 2 {
                Tap("Up")
                RandSleep()
            }
        }
    }
    
    Loop 2{
        Tap("Right")
        RandSleep()
    }    
    Tap("Down")
    RandSleep()
    Tap("Enter")
    RandSleep()
    Tap("\") 
    RandSleep(1000, 1200)
    Tooltip()
}

BuyInShopCOSMETICS(amount){
    global settings
    
    ToolTip "Buying COSMETICS"

    Loop amount{
        SafeClickRelative(0.2,0.58)
        RandSleep()
        SafeClickRelative(0.45,0.58)
        RandSleep()
        SafeClickRelative(0.67,0.58)
        RandSleep()
        SafeClickRelative(0.23,0.77)
        RandSleep()
        SafeClickRelative(0.33,0.77)
        RandSleep()
        SafeClickRelative(0.43,0.77)
        RandSleep()
        SafeClickRelative(0.53,0.77)
        RandSleep()
        SafeClickRelative(0.67,0.77)
        RandSleep()
        SafeClickRelative(0.75,0.77)
        RandSleep()
    }

    Tap("\") 
    RandSleep()       
    Tap("Left")
    RandSleep()
    Tap("Up")
    RandSleep() 
    Loop 6{
        Tap("Right")
        RandSleep() 
    }
    Tap("Enter")
    RandSleep()
    Tap("\") 
    RandSleep(1000, 1200)
    Tooltip()
    
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
    RandSleep(1500, 2750)
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
    RandSleep(100,200)
    Loop 10 {
        Tap("S")
        Sleep 20
    }
    RandSleep(100,200)
    Tap("e")
    RandSleep(3000, 3500)
    SafeClickRelative(0.75, 0.38)
    RandSleep(3000, 3500)
}

TPtoCOSMETICS(){
    Tap("1") 
    RandSleep()
    SafeClickRelative(0.5, 0.5)
    RandSleep(1000, 1200)
    GOtoCOSMETICS()
}

GOtoCOSMETICS() {
    RandSleep(100,200)
    Loop 7 {
        Tap("W")
        Sleep 20
    }
    RandSleep(100,200)
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