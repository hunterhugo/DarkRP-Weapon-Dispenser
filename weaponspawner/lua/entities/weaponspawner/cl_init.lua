include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

surface.CreateFont("MaPolice", {
	font = "Pacifio",
	size = 24,
	weight = 500,
})

surface.CreateFont("MaPoliceClose", {
	font = "Pacifio",
	size = 16,
	weight = 500,
})


net.Receive("panel", function()

	local WeaponPrice = net.ReadTable()
	local ActivePanel = net.ReadBool()

	if ActivePanel then
		local DFrame = vgui.Create("DFrame")
		
		DFrame:SetSize(500, 500)
		DFrame:Center()
		DFrame:SetTitle("")
		DFrame:ShowCloseButton(false)

		DFrame.Paint = function(panel, w, h)
		    surface.SetDrawColor(Color(28, 40, 51))
		    surface.DrawRect(0, 0, w, h)
		end

		DFrame:SetDraggable(false)

		local pos = 10
		for k, v in pairs(WeaponPrice) do

			local DLabel = vgui.Create("DLabel", DFrame)
			DLabel:SetPos(40, pos)
			DLabel:SetSize(500, 25)
			DLabel:SetText("")
			function DLabel:Paint(w, h)
				draw.SimpleText(k, "MaPolice", w / 5, h / 2, Color( 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			local DButton = vgui.Create( "DButton", DFrame)
			DButton:SetText("")
			DButton:SetSize(200, 25)
			DButton:SetPos(250, pos)
			function DButton:Paint( w, h )
			    draw.RoundedBox( 10, 0, 0, w, h, Color(23, 58, 90) )
			    draw.SimpleText("buy " .. v .. "€", "MaPolice", w / 2, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			function DButton:DoClick()
				net.Start("weapon")
					net.WriteBool(true)
					net.WriteString(k)
				net.SendToServer()
			end

			pos = pos + 50

		end

		local close = vgui.Create("DLabel", DFrame)
		close:SetPos(10, 475)
		close:SetSize(500, 25)
		close:SetText("")
		function close:Paint(w, h)
			draw.SimpleText("press SPACE to close the panel", "MaPoliceClose", w/5, h/2, Color( 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		DFrame:MakePopup()
		DFrame.Think = function(self)
			if input.IsKeyDown(KEY_SPACE) then
				self:Close()
			end
		end

	end
end)