// ======= Copyright (c) 2003-2011, Unknown Worlds Entertainment, Inc. All rights reserved. =======
//
// lua\GUIBulletDisplay.lua
//
// Created by: Max McGuire (max@unknownworlds.com)
//
// Displays the current number of bullets and clips for the ammo counter on a bullet weapon
//
// ========= For more information, visit us at http://www.unknownworlds.com =====================

Script.Load("lua/GUIScript.lua")
Script.Load("lua/Utility.lua")

class 'GUILMGBulletDisplay' (GUIScript)

function GUILMGBulletDisplay:Initialize()

    self.weaponClip     = 0
    self.weaponAmmo     = 0
    self.weaponClipSize = 50
    
    self.onDraw = 0
    self.onHolster = 0

    self.background = GUIManager:CreateGraphicItem()
    self.background:SetSize( Vector(256, 512, 0) )
    self.background:SetPosition( Vector(0, 0, 0))    
    self.background:SetTexture("ui/rifledisplay.dds")
    self.background:SetIsVisible(true)

    // Slightly larger copy of the text for a glow effect
    self.ammoTextBg = GUIManager:CreateTextItem()
    self.ammoTextBg:SetFontName("fonts/MicrogrammaDMedExt_large.fnt")
    self.ammoTextBg:SetFontIsBold(true)
    self.ammoTextBg:SetFontSize(145)
    self.ammoTextBg:SetTextAlignmentX(GUIItem.Align_Center)
    self.ammoTextBg:SetTextAlignmentY(GUIItem.Align_Center)
    self.ammoTextBg:SetPosition(Vector(135, 80, 0))
    self.ammoTextBg:SetColor(Color(1, 1, 1, 0.25))

    // Text displaying the amount of ammo in the clip
    self.ammoText = GUIManager:CreateTextItem()
	self.ammoText:SetFontName("fonts/MicrogrammaDMedExt_large.fnt")
    self.ammoText:SetFontIsBold(true)
    self.ammoText:SetFontSize(135)
    self.ammoText:SetTextAlignmentX(GUIItem.Align_Center)
    self.ammoText:SetTextAlignmentY(GUIItem.Align_Center)
    self.ammoText:SetPosition(Vector(135, 80, 0))
	self.ammoText:SetColor(Color(1, 0, 0, 1))
	
	// Text displaying the amount of ammo in the reserve
    self.reserveText = GUIManager:CreateTextItem()
    self.reserveText:SetFontName("fonts/MicrogrammaDMedExt_medium.fnt")
    self.reserveText:SetFontIsBold(true)
    self.reserveText:SetFontSize(50)
    self.reserveText:SetTextAlignmentX(GUIItem.Align_Center)
    self.reserveText:SetTextAlignmentY(GUIItem.Align_Center)
    self.reserveText:SetPosition(Vector(130, 185, 0))
    
/*
    self.flashInOverlay = GUIManager:CreateGraphicItem()
    self.flashInOverlay:SetSize( Vector(256, 512, 0) )
    self.flashInOverlay:SetPosition( Vector(0, 0, 0))    
    self.flashInOverlay:SetColor(Color(1,1,1,0.7))
*/
    
    // Force an update so our initial state is correct.
    self:Update(0)

end

function GUILMGBulletDisplay:InitFlashInOverLay()

end

function GUILMGBulletDisplay:Update(deltaTime)

    PROFILE("GUIBulletDisplay:Update")
    
    // Update the ammo counter.
    local ammoFormat = string.format("%02d", self.weaponClip) 
    self.ammoText:SetText( ammoFormat )
    self.ammoTextBg:SetText( ammoFormat )
	
	local reserveFormat = string.format("%02d", self.weaponAmmo) 
	self.reserveText:SetText( reserveFormat )

end

function GUILMGBulletDisplay:SetClip(weaponClip)
    self.weaponClip = weaponClip
end

function GUILMGBulletDisplay:SetClipSize(weaponClipSize)
    self.weaponClipSize = weaponClipSize
end

function GUILMGBulletDisplay:SetAmmo(weaponAmmo)
    self.weaponAmmo = weaponAmmo
end