local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Knit = require(ReplicatedStorage.Packages.Knit)

local SourceFolder = script.Parent
Knit.AddControllers(SourceFolder.Controllers)


Knit.Start():andThen(function()
    print('Knit Client started.')
end):catch(warn)