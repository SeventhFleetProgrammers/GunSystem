local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerScriptService = game:GetService('ServerScriptService')
local Knit = require(ReplicatedStorage.Packages.Knit)


Knit.AddServices(ServerScriptService.Source.Services)

Knit.Start():andThen(function()
    print('Knit Server started.')
end):catch(warn)