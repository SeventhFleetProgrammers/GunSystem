return {
    CanAim = true,
    Zoom = 60,
    Zoom2 = 60,
    GunName = script.Parent.Name,
    Type = 'Gun',
    EnableHUD = true,

    Ammo = 30,
    MaxAmmo = 30,
    TotalAmmo = 1000,

    Firerate = 600,
    Firestyle = 'Semi Automatic', -- Allowed types: Semi Automatic, Burstfire, Automatic, Pump Action, Bolt Action

    LimbDamage = { 35, 40 },
    TorsoDamage = { 57, 62 },
    HeadshotDamage = { 150, 150 },
    DamageFalloff = 1,

    MinimumDamage = 5,
    ADSTime = 1,
    CrossHair = false,
    CrossHairOffset = 0,

    CameraRecoil = {
        Up = { 12, 15 },
        Left = { 7, 10 },
        Right = { 6, 9 },
        Tilt = { 10, 15 }
    },

    GunRecoil = {
        Up = { 20, 25 },
        Left = { 15, 20 },
        Right = { 15, 20 },
        Tilt = { 10, 20 }
    },

    AimRecoilReduction = 4,
    AimSpreadReduction = 1,

    MinRecoilPower = .5,
    MaxRecoilPower = 1.5,
    RecoilPowerStepAmount = .1,

    MinSpread = .75,
    MaxSpread = 100,
    AimInaccuracyStepAmount = .75,
    AimInaccuracyDecrease = .25,
    WalkSpeedMultiplier = 0,

    EnableZeroing = true,
    MaxZero = 500,
    ZeroIncrement = 50,
    CurrentZero = 0,

    BulletType = '7.81 Blaster Bolt',
    MuzzleVelocity = 1500, -- m/s
    BulletDrop = .1,
    Tracer = true,
    BulletFlare = true,
    TracerColor = Color3.fromRGB(170, 0, 0),
    RandomTracer = { Enabled = true, Chance = 80 },

    TracerEveryXShots = 1,
}