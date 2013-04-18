local F, C, L = unpack(select(2, ...))

local r, g, b = unpack(C.class)

local last = 0
F.menuShown = false

local function onMouseUp(self)
	self:SetScript("OnUpdate", nil)
	if F.menuShown then
		ToggleFrame(DropDownList1)
		F.menuShown = false
		return
	end

	if IsAddOnLoaded("alDamageMeter") then
		DisableAddOn("alDamageMeter")
		DEFAULT_CHAT_FRAME:AddMessage("FreeUI: |cffffffffalDamageMeter disabled. Type|r /rl |cfffffffffor the changes to apply.|r", r, g, b)
	else
		EnableAddOn("alDamageMeter")
		LoadAddOn("alDamageMeter")
		if IsAddOnLoaded("alDamageMeter") then
			DEFAULT_CHAT_FRAME:AddMessage("FreeUI: |cffffffffalDamageMeter loaded.|r", r, g, b)
		else
			DEFAULT_CHAT_FRAME:AddMessage("FreeUI: |cffffffffalDamageMeter not found!|r", r, g, b)
		end
	end
end

local right = CreateFrame("Frame")
right:SetBackdrop({
	bgFile = C.media.backdrop,
	edgeFile = C.media.glow,
	edgeSize = 3,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
right:SetBackdropColor(1, 0, 0)
right:SetBackdropBorderColor(1, 0, 0)
right:SetAlpha(0)
right:SetSize(8, 8)
right:SetPoint("BOTTOMRIGHT")
right:EnableMouse(true)
right:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" then
		self:HookScript("OnUpdate", function(self, elapsed)
			last = last + elapsed
			if last > .5 then
				self:SetScript("OnUpdate", nil)
				self:SetScript("OnMouseUp", nil)
				last = 0
				if F.menuShown then
					ToggleFrame(DropDownList1)
					F.menuShown = false
				else
					F.MicroMenu()
					F.menuShown = true
				end
			end
		end)
		self:SetScript("OnMouseUp", onMouseUp)
	elseif button == "RightButton" then
		self:SetScript("OnMouseUp", nil)
		if F.menuShown then
			ToggleFrame(DropDownList1)
			F.menuShown = false
			return
		end
		if IsAddOnLoaded("DBM-Core") then
			DisableAddOn("DBM-Core")
			DEFAULT_CHAT_FRAME:AddMessage("FreeUI: |cffffffffDBM disabled. Type|r /rl |cfffffffffor the changes to apply.|r", unpack(C.class))
		else
			EnableAddOn("DBM-Core")
			LoadAddOn("DBM-Core")
			if IsAddOnLoaded("DBM-Core") then
				DEFAULT_CHAT_FRAME:AddMessage("FreeUI: |cffffffffDBM loaded.|r", r, g, b)
			else
				DEFAULT_CHAT_FRAME:AddMessage("FreeUI: |cffffffffDBM not found!|r", r, g, b)
			end
		end
	end
end)

right:SetScript("OnEnter", function(self)
	self:SetAlpha(1)
	F.CreatePulse(self)
	if not InCombatLockdown() then
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -14, 14)
		GameTooltip:AddLine("FreeUI", r, g, b)
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine("Left-click:", "Toggle alDamageMeter", r, g, b, 1, 1, 1)
		GameTooltip:AddDoubleLine("Right-click:", "Toggle DBM", r, g, b, 1, 1, 1)
		GameTooltip:AddDoubleLine("Click and hold:", "Toggle micro menu", r, g, b, 1, 1, 1)
		GameTooltip:Show()
	end
end)

right:SetScript("OnLeave", function(self)
	self:SetScript("OnUpdate", nil)
	self:SetAlpha(0)
	GameTooltip:Hide()
end)

local left = CreateFrame("Frame")
left:SetBackdrop({
	bgFile = C.media.backdrop,
	edgeFile = C.media.glow,
	edgeSize = 3,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
})
left:SetBackdropColor(.4, .6, 1)
left:SetBackdropBorderColor(.4, .6, 1)
left:SetAlpha(0)
left:SetSize(8, 8)
left:SetPoint("BOTTOMLEFT")
left:EnableMouse(true)
left:SetScript("OnMouseDown", function()
		ToggleFrame(ChatMenu)
end)

left:SetScript("OnEnter", function(self)
	self:SetAlpha(1)
	F.CreatePulse(self)
	if not InCombatLockdown() then
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 14, 14)
		GameTooltip:AddLine("FreeUI", r, g, b)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("Click to toggle chat menu", 1, 1, 1)
		GameTooltip:Show()
	end
end)

left:SetScript("OnLeave", function()
	left:SetScript("OnUpdate", nil)
	left:SetAlpha(0)
	GameTooltip:Hide()
end)