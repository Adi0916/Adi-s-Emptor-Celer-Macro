# Emptor v2.2 (Macro)

## Overview

This AutoHotkey macro automates buying items in the **SEEDS** and **GEARS** shops in the Roblox game **Grow a Garden**.  
It allows you to configure the number of confirmations per item and choose the automation speed.

⚠️ **Disclaimer**  
This macro is a community-made tool for automation in Roblox.  
Use it at your own risk. It is not affiliated with or endorsed by Roblox Corporation.

---

## Features

- Automates purchases in both SEEDS and GEARS shops  
- Configurable confirmations per item  
- Adjustable speed (Normal / Fast)  
- Automatic handling of special case in the GEAR shop (16th item)  
- Randomized input to simulate human-like behavior
- Save settings to a file
- Easy toggle ON/OFF  

---

## How to Use

1. Install [AutoHotkey v2](https://www.autohotkey.com/) from the official site.  
2. Download this repository or clone it.  
3. Double click the macro file: **`Emptor v2.1.ahk`**  
4. A GUI window will appear where you can configure settings.  

### You can set:
- **Amount** → number of confirmations for each item  
- **Speed**  
  - **Normal** (default) → `RandMinGlobal = 200`, `RandMaxGlobal = 250`  
  - **Fast** → `RandMinGlobal = 100`, `RandMaxGlobal = 150`  

---

## Controls

- **F7** → Open GUI to edit data  
- **F8** → Toggle automation ON/OFF  
- **Esc** → Exit the macro  

A tooltip will indicate when the macro is active.  

---

## Preparation (Character & Inventory)

- Turn on **UI navigation** in Roblox settings.  
- Make sure **UI navigation is disabled in the main game** before starting the macro (`\` toggles it – if enabled, a white highlight appears).  
- Your inventory must contain **the wrench** in the 1st slot and one other item in the hotbar. 
- Ensure both the **GEAR** and **SEED** shop NPCs are interactable with the **E key**.  
- Example setup is shown in this video: [https://youtu.be/eqKjukbAhNM](https://youtu.be/eqKjukbAhNM)  

---

## Notes

- The macro automatically scrolls through the shops and confirms each purchase.  
- For the **GEAR shop**, the 16th item skips the "Left" click to avoid issues.  
- Movements and clicks include slight randomness for human-like behavior.  

---

## License

This project is licensed under the [MIT License](LICENSE).  
