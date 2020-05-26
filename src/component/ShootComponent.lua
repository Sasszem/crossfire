local function ShootComponent(bullet, shootCooldown, shootSound)
    return {
        bullet = bullet,
        shootCooldown = shootCooldown,
        refireRate = shootCooldown,
        shootSound = shootSound,
    }
end

return ShootComponent