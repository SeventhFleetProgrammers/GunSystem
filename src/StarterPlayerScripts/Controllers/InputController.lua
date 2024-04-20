local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ContextActionService = game:GetService('ContextActionService')
local UserInputService = game:GetService('UserInputService')
local Knit = require(ReplicatedStorage.Packages.Knit)

local InputController = Knit.CreateController({
    Name = 'InputController',
    Keybinds = {
        Fire = { Controller = 'GunController', Key = Enum.UserInputType.MouseButton1, CreateButton = false },
        Aim = { Controller = 'GunController', Key = Enum.UserInputType.MouseButton2, CreateButton = false },
        Sprint = { Controller = 'GunController', Key = Enum.KeyCode.LeftShift, CreateButton = false }
    },

    MouseSensitivity = 50,
    Controllers = { },
})

function InputController:KnitStart()
   local controllerNames = { }

   for _,keybind in self.Keybinds do
        if not table.find(controllerNames, keybind.Controller) then
            table.insert(controllerNames, keybind.Controller)
            self.Controllers[keybind.Controller] = Knit.GetController(keybind.Controller)
        end
   end

   self:RegisterKeybinds()
end

function InputController:RegisterKeybinds(): nil
    for keybindName,keybind in self.Keybinds do
        ContextActionService:BindAction(keybindName, function (action: string, userInputState: Enum.UserInputState, input: InputObject)
            self:ProcessKeybind(action, userInputState, input)
        end, keybind.CreateButton, keybind.Key)
    end
end


function InputController:ProcessKeybind(action: string, userInputState: Enum.UserInputState, input: InputObject): nil
    local controller = self.Controllers[self.Keybinds[action].Controller]
    controller:ProcessKeybind(action, userInputState, input)
end


function InputController:SetMouseSensitivity(sensitivity: number): nil
    UserInputService.MouseDeltaSensitivity = sensitivity
end


return InputController