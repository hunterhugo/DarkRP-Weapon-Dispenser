# DarkRP-Weapon-Dispenser
Weapon Dispenser for Garry's Mod DarkRP when they are no Gun Dealer
# **Installation GUIDE**
put the `weaponspawner` folder in the `addons` folder
# presentation video
[YouTube](https://youtu.be/VSXbq7C6LXg)
# Configuration file
*`config.lua`* Folder path: `addons\weaponspawner\lua\entities\weaponspawner\config.lua`
```
local config = {}

config.WeaponPrice = {
		["m9k_m4a1"] = 1000,
		["m9k_ammo_ar2"] = 100,
} --Table of entities

config.Job = TEAM_GUN --Team of the gun seller

config.Model = "models/props_wasteland/controlroom_storagecloset001a.mdl" --model of the dispenser

config.CreateTimer = 3 --appearance time

return config
```
