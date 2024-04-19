local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Knit = require(ReplicatedStorage.Packages.Knit)

local GunService = Knit.CreateService({
    Name = 'GunService',
    Client = { }
})


function GunService:BulletRequest()

end


return GunService