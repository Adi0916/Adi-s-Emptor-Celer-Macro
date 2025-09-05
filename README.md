# Emptor v3 (Macro)

## Overview

This AutoHotkey macro automates buying items in the Roblox game **Grow a Garden**.  
It allows you to configure the number of confirmations per item and choose the automation speed.

⚠️ **Disclaimer**  
This macro is a community-made tool for automation in Roblox.  
Use it at your own risk. It is not affiliated with or endorsed by Roblox Corporation.

---

## Features

- Automates purchases of SEEDS, GEARS, EGGS, COSMETICS   
- Configurable number of bought items  
- Adjustable speed (Normal / Fast / Hyper / Insane)  
- Automatic handling of special case in the GEAR shop (16th item)  
- Randomized input to simulate human-like behavior
- Auto-open mode, gui lunches on macro startup
- Auto alignment
- Macro auto-loads settings
- Select items to buy from the shop
- Easy toggle ON/OFF  

---

## How to Install

1. Install [AutoHotkey v2](https://www.autohotkey.com/) from the official site.  
2. Download this repository or clone it (you can also go to releases and download it from there) 
3. Double click the macro file: **`Emptor.ahk`**  

## Controls

- **F6** → Closes the macro, useful for emergencies
- **F7** → Open GUI menu
- **F8** → Toggle automation ON/OFF
- **Esc** → Exit the macro  

A tooltip will indicate when the macro is active.  

---

## Preparation (Character & Inventory)

- Turn on **UI navigation** in Roblox settings.  
- Make sure **UI navigation is disabled in the main game** before starting the macro (`\` toggles it – if enabled, a white highlight appears).  
- Your inventory must contain **the wrench** in the 1st slot and other slots from 2-0 (2,3,4,5,6,7,8,9,0) has to have an item.
- Make sure that your "Camera Mode" in the settings is set to "Default (Classic)"
- Turn ON the auto-alignment in the GUI
- Make sure that every shop has closed items (only if u buy only one item from that shop)
- Example setup is shown in this video: (this sunday)

---

## Notes

- The macro automatically scrolls through the shops and confirms each purchase.  
- For the **GEAR shop**, the 16th item skips the "Left" click to avoid issues.  
- Movements and clicks include slight randomness for human-like behavior.  

---

## License

This project is licensed under the [MIT License](LICENSE).  
