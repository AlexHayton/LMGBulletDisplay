Script.Load("lua/GUIScript.lua")
Script.Load("lua/Utility.lua")
Script.Load("lua/GUIDial.lua")

class 'GUILMGDisplay' (GUIScript)

local kAmmoColors = { Color(0.8, 0, 0), Color(0.8, 0.5, 0), Color(0.7, 0.7, 0.7) }
local kNumberAmmoColors = table.maxn(kAmmoColors)

function GUILMGDisplay:Initialize()

    GUI.SetSize( 256, 256 )

    self.weaponClip     = 0
    self.weaponAmmo     = 0
    self.weaponClipSize = 10
    
    self.onDraw = 0
    self.onHolster = 0

    self.background = GUIManager:CreateGraphicItem()
    self.background:SetSize( Vector(256, 512, 0) )
    self.background:SetPosition( Vector(0, 0, 0))    
    self.background:SetTexture("ui/LMGDisplay.dds")
	self.background:SetColor(Color(1, 1, 1, 0.1))
    self.background:SetIsVisible(true)

    // Slightly larger copy of the text for a glow effect
    self.ammoTextBg = GUIManager:CreateTextItem()
    self.ammoTextBg:SetFontName("fonts/MicrogrammaDMedExt_large.fnt")
    self.ammoTextBg:SetFontIsBold(true)
    self.ammoTextBg:SetFontSize(75)
    self.ammoTextBg:SetTextAlignmentX(GUIItem.Align_Center)
    self.ammoTextBg:SetTextAlignmentY(GUIItem.Align_Center)
    self.ammoTextBg:SetPosition(Vector(135, 125, 0))
    self.ammoTextBg:SetColor(Color(1, 1, 1, 0.25))

    // Text displaying the amount of ammo in the clip
    self.ammoText = GUIManager:CreateTextItem()
    self.ammoText:SetFontName("fonts/MicrogrammaDMedExt_large.fnt")
    self.ammoText:SetFontIsBold(true)
    self.ammoText:SetFontSize(70)
    self.ammoText:SetTextAlignmentX(GUIItem.Align_Center)
    self.ammoText:SetTextAlignmentY(GUIItem.Align_Center)
    self.ammoText:SetPosition(Vector(135, 125, 0))
	
	// Text displaying the amount of ammo in the clip
    self.reserveText = GUIManager:CreateTextItem()
    self.reserveText:SetFontName("fonts/MicrogrammaDMedExt_large.fnt")
    self.reserveText:SetFontIsBold(true)
    self.reserveText:SetFontSize(30)
    self.reserveText:SetTextAlignmentX(GUIItem.Align_Center)
    self.reserveText:SetTextAlignmentY(GUIItem.Align_Center)
    self.reserveText:SetPosition(Vector(135, 300, 0))
    
    // Force an update so our initial state is correct.
    self:Update(0)
    
    // Set the clip size
	bulletDisplay:SetClipSize(50)

end

function GUILMGDisplay:Uninitialize()

    if self.ammoDial then
        self.ammoDial:Uninitialize()
        self.ammoDial = nil
    end
    
end

function GUILMGDisplay:InitFlashInOverLay()

end

function GUILMGDisplay:Update(deltaTime)

    PROFILE("GUIBulletDisplay:Update")
    
    this:SetClip(weaponClip)
    this:SetAmmo(weaponAmmo)
    
    // Update the ammo counter.
    local ammoFormat = string.format("%02d", self.weaponClip) 
    self.ammoText:SetText( ammoFormat )
    self.ammoTextBg:SetText( ammoFormat )
	
	local reserveFormat = string.format("%02d", self.weaponAmmo) 
	self.reserveText:SetText( reserveFormat )

end

function GUILMGDisplay:SetClip(weaponClip)
    self.weaponClip = weaponClip
end

function GUILMGDisplay:SetClipSize(weaponClipSize)
    self.weaponClipSize = weaponClipSize
end

function GUILMGDisplay:SetAmmo(weaponAmmo)
    self.weaponAmmo = weaponAmmo
end

// Global state that can be externally set to adjust the display.
weaponClip     = 0
weaponAmmo     = 0

bulletDisplay  = nil

/**
 * Called by the player to update the components.
 */
function Update(deltaTime)

    bulletDisplay:SetClip(weaponClip)
    bulletDisplay:SetAmmo(weaponAmmo)
    bulletDisplay:Update(deltaTime)
    
end

/**
 * Initializes the player components.
 */
function Initialize()

    GUI.SetSize( 256, 256 )

    bulletDisplay = GUILMGDisplay()
    bulletDisplay:Initialize()
    bulletDisplay:SetClipSize(10)

end

Initialize()