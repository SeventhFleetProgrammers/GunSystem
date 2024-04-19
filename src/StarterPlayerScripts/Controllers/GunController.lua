local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService('UserInputService')
local Knit = require(ReplicatedStorage.Packages.Knit)


local GunController = Knit.CreateController({
    Name = 'GunController',

    CurrentGun = nil,
    Character = nil,
    Humanoid = nil
})


function GunController:KnitStart()
    self:Respawned()
    self:ConnectEvents()
end


function GunController:ConnectEvents()
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


function GunController:Respawned(character: Model?)
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


function GunController:InputBegan(input: InputObject, processed: boolean)

end


function GunController:CharacterDescendantAdded(descendant: Instance)
    if not descendant:IsA('Tool') or not descendant:HasTag('Weapon') then 
        return 
    end

end


return GunController