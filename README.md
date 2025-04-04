# 🚔 QB-Core Pepper Spray Script 🌶️💨

## 📜 Description
This is a **FiveM** script for **QB-Core** that allows players to use a **pepper spray** (`weapon_pepperspray`). The spray is activated when the player **holds the left mouse button** while aiming and stops when they release the button. The spray applies **visual effects** and temporarily disables the affected target by making them **stumble and cough**. 🤧

![DALL·E 2025-03-25 00 39 03 - A realistic digital illustration of a police officer in a FiveM game setting holding a pepper spray canister, actively spraying a visible mist toward ](https://github.com/user-attachments/assets/23d166c6-32ec-40d2-9fe3-1320b438b5a4)


## ✨ Features
✅ **Hold left-click** while aiming to continuously spray.
✅ Releases a **visible spray effect** while in use.
✅ Affected players **cough and stumble** for a few seconds.
✅ **Cooldown system** to prevent spam.
✅ Configurable to allow only specific jobs (e.g., police). 🚓

## 📥 Installation
1. **Download** the script and place it inside your FiveM server's `resources` folder. 📂
2. **Add** `ensure qb-pepperspray` to your `server.cfg`. ⚙️
3. **Ensure dependencies are installed:**
   - ✅ **QB-Core**
   - ✅ **A weapon model for pepper spray (`weapon_pepperspray`) is already included with the script. No additional downloads are needed.**

## 🛠️ Configuration
- Edit the `server.lua` to define **who can use the spray** (e.g., only police). 👮‍♂️
- Adjust `COOLDOWN_TIME` in `server.lua` to modify the cooldown between sprays. ⏳
- Modify `SPRAY_RANGE` in `client.lua` to change the range of the spray effect. 📏

## 🎮 Controls
🎯 **Hold Right Mouse Button** (Aim) + **Hold Left Mouse Button** to Spray.
🛑 **Release Left Mouse Button** to stop spraying.

![image](https://github.com/user-attachments/assets/9e4a1774-e883-467d-9179-967c18b77d1a)


## 🔗 Dependencies
- 🏗️ **QB-Core Framework**
- 🔫 **A weapon model for `weapon_pepperspray`**

## 🆘 Support
For support or questions, join my **Discord**: https://discord.gg/vtu4B7tAvA 💬

## 👏 Credits
- 🛠️ Script developed by [Your Name].
- 🔥 Inspired by real-world non-lethal policing tools.

## 📜 License
This script is provided as-is. You are free to modify and use it for **personal or server** use, but redistribution without permission is not allowed. 🚫

