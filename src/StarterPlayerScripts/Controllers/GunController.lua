local ContextActionService = game:GetService('ContextActionService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService('UserInputService')
local Knit = require(ReplicatedStorage.Packages.Knit)

type GunModTable = {
    CameraRecoil: {
        Up: number,
        Left: number,
        Right: number,
        Tilt: number
    },
    GunRecoil: {
        Up: number,
        Left: number,
        Right: number,
        Tilt: number
    },
    AimRM: number,
    SpreadRM: number,
    ZoomValue: number,
    Zoom2Value: number,
    DamageModifier: number,
    MinimumDamageModifier: number,
    MinimumSpread: number,
    MaximumSpread: number,
    MinimumRecoilPower: number,
    MaximumRecoilPower: number,
    RecoilPowerStepAmount: number,
    AimInaccuracyStepAmount: number,
    AimInaccuracyDecrease: number,
    WalkSpeedMultiplier: number,
    MuzzleVelocity: number
}


local GunController = Knit.CreateController({
    Name = 'GunController',

    GunControlMode = 'FirstPerson',

    CurrentGun = nil,
    Character = nil,
    Humanoid = nil,
    Mouse = nil,

    BulletsFolder = nil,

    GunProperties = {
        CameraRecoil = {
            Up = 1,
            Left = 1,
            Right = 1,
            Tilt = 1
        },

        GunRecoil = {
            Up = 1,
            Left = 1,
            Right = 1,
            Tilt = 1
        },

        ZoomValue = 70,
        Zoom2Value = 70,
        AimRM = 1,
        SpreadRM = 1,
        DamageModifier = 1,
        MinimumDamageModifer = 1,

        MinimumSpread = 1,
        MaximumSpread = 1,
        MinimumRecoilPower = 1,
        MaximumRecoilPower = 1,
        RecoilPowerStepAmount = 1,
        AimInaccuracyStepAmount = 1,
        AimInaccuracyDecrease = 1,
        WalkSpeedMultiplier = 1,
        MuzzleVelocity = 1
    }
})


function GunController:KnitStart(): nil
    self:Respawned()

    self:ConnectEvents()
    self:RegisterKeybinds()


    self.BulletsFolder = workspace:FindFirstChild('Bullets') or Instance.new('Folder')

    self.BulletsFolder.Name = 'Bullets'
    self.BulletsFolder.Parent = workspace
end


function GunController:ConnectEvents(): nil
    UserInputService.InputBegan:Connect(function(input: InputObject, processed: boolean)
        self:InputBegan(input, processed)
    end)

    self.Character.DescendantAdded:Connect(function(descendant: Instance)
        self:CharacterDescendantAdded(descendant)
    end)

    Knit.Player.CharacterAdded:Connect(function(character: Model)
        self:Respawned(character)
    end)
end

function GunController:ApplyGunPropertiesModification(ModTable: GunModTable)
    self.GunProperties = self.GunProperties :: GunModTable-- So I actually get intellisense

    self.GunProperties.CameraRecoil.Up *= ModTable.CameraRecoil.Up
    self.GunProperties.CameraRecoil.Left *= ModTable.CameraRecoil.Left
    self.GunProperties.CameraRecoil.Right *= ModTable.CameraRecoil.Right
    self.GunProperties.CameraRecoil.Tilt *= ModTable.CameraRecoil.Tilt

    self.GunProperties.GunRecoil.Up *= ModTable.CameraRecoil.Up
    self.GunProperties.GunRecoil.Left *= ModTable.CameraRecoil.Left
    self.GunProperties.GunRecoil.Right *= ModTable.CameraRecoil.Right
    self.GunProperties.GunRecoil.Tilt *= ModTable.CameraRecoil.Tilt

    self.GunProperties.AimRN *= ModTable.AimRM
    self.GunProperties.SpreadRM *= ModTable.SpreadRM
    self.GunProperties.DamageModifier *= ModTable.DamageModifier
    self.GunProperties.MinimumDamageModifier *= ModTable.MinimumDamageModifier
    self.GunProperties.RecoilPowerStepAmount *= ModTable.RecoilPowerStepAmount
    self.GunProperties.MinimumRecoilPower *= ModTable.MinimumRecoilPower
    self.GunProperties.MaximumRecoilPower *= ModTable.MaximumRecoilPower
    self.GunProperties.RecoilPowerStepAmount *= ModTable.RecoilPowerStepAmount
    
    self.GunProperties.MinimumSpread *= ModTable.MinimumSpread
    self.GunProperties.MaximumSpread *= ModTable.MaximumSpread
    self.GunProperties.AimInaccuracyStepAmount *= ModTable.AimInaccuracyStepAmount
    self.GunProperties.AimInaccuracyDecrease *= ModTable.AimInaccuracyDecrease
    self.GunProperties.WalkSpeedMultiplier *= ModTable.WalkSpeedMultiplier
    self.GunProperties.MuzzleVelocity *= ModTable.MuzzleVelocity
end


function GunController:CreateViewModel()
    local model: Model = Instance.new('Model')

    local leftArm: BasePart = self.Character:WaitForChild('Left Arm'):Clone()
    local rightArm: BasePart = self.Character:WaitForChild('Right Arm'):Clone()

    leftArm.Parent = model
    rightArm.Parent = model


    local leftArmMorph, rightArmMorph = leftArm:FindFirstChild('Morph'), rightArm:FindFirstChild('Morph')
    if leftArmMorph and rightArmMorph then
        local morphParts = table.clone(leftArmMorph:GetDescendants())

        for i,v in rightArmMorph:GetDescendants() do 
            table.insert(morphParts, v) 
        end

        for i,v in morphParts do
            if v.Name == 'Middle' or (v.ClassName ~= 'MeshPart' and v.ClassName ~= 'BasePart') then continue end
            v.Size = Vector3.new(v.Size.X * .5, v.size.Y, v.Size.Z * .5)
        end
    end

    return model
end


function GunController:Respawned(character: Model?): nil
    if not character then
        self.Character = if Knit.Player.Character and Knit.Player.Character.Parent then
            Knit.Player.Character
        else
            Knit.Player.CharacterAdded:Wait()

    else
        self.Character = character
    end

    self.Humanoid = self.Character:WaitForChild('Humanoid')
end


function GunController:InputBegan(input: InputObject, processed: boolean): nil
    if not self.CurrentGun or (input.UserInputType ~= Enum.UserInputType.MouseButton1 or processed) then
        return
    end

    -- Add gun shooting logic here.
end


function GunController:CharacterDescendantAdded(descendant: Instance): nil
    if not descendant:IsA('Tool') or not descendant:HasTag('Weapon') then
        return
    end

    self.CurrentGun = descendant
end


function GunController:CharacterDescendantRemoved(descendant: Instance): nil
    if descendant ~= self.CurrentGun then
        return
    end

    self.CurrentGun = nil
end


function GunController:Aim()
end

function GunController:Fire()
end

return GunController