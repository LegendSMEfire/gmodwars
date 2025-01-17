AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = true
ENT.AutomaticFrameAdvance = true

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "BuildingIndex")
	self:NetworkVar("Bool", 0, "Working")
end

if ( SERVER ) then

function ENT:Initialize()
	self:SetBuildingIndex(0)
	self:SetModel("models/error.mdl")
	self:DropToFloor()

	self:SetWorking(false)
end

function ENT:Think()
	local phys = self:GetPhysicsObject()
	if ( IsValid(phys) ) then
		phys:EnableMotion(false)
	end

	local buildingData = gmodwars.buildings.Get(self:GetBuildingIndex())
	if not ( gmodwars.buildings.Get(self:GetBuildingIndex()) ) then
		return
	end

	if ( self:GetWorking() and buildingData.workSequence ) then
		self:SetSequence(buildingData.workSequence)
	else
		self:SetSequence(buildingData.idleSequence)
	end
end

end