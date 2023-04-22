AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
local config = include("config.lua")

function ENT:Initialize()

	self:SetModel(config.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end

end

util.AddNetworkString("panel")
util.AddNetworkString("weapon")

local IsCreatingWeapon = false
local PrintedMessage = false

function ENT:Use( activator )

	local Job = true

	for _, pl in pairs(player.GetAll()) do
		if pl:Team() == config.Job then
			Job = false
		end
	end

	if Job then

		net.Start("panel")
			net.WriteTable(config.WeaponPrice)
			net.WriteBool(true)
		net.Send(activator)

		net.Receive("weapon", function()

			local CreateWeapon = net.ReadBool()
			local Weapon = net.ReadString()	

			if IsCreatingWeapon == false and CreateWeapon == true then

				local PlayerMoney = activator:getDarkRPVar("money")

				if PlayerMoney >= config.WeaponPrice[Weapon] then

					IsCreatingWeapon = true
					
					timer.Simple(config.CreateTimer, function()
						local ent = ents.Create( Weapon )
						ent:SetPos( self:GetPos() + Vector(0, 0, 25) )
						ent:Spawn()
						IsCreatingWeapon = false
						--game.ConsoleCommand("darkrp setmoney '" .. activator:Nick() .. "' " .. (PlayerMoney - config.WeaponPrice[Weapon]))
						activator:addMoney(config.WeaponPrice[Weapon] * -1)
		
					end)
				else

					activator:ChatPrint("You don't have enough money.")

				end
			end
		end)

	else
		if PrintedMessage ~= true then
			activator:ChatPrint("A gun seller is connected")
			PrintedMessage = true
			timer.Simple(1, function()
				PrintedMessage = false
			end)
		end
	end

end