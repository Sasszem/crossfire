local function ShootComponent(bullet, shootCooldown)
    return {
        bullet = bullet,
        shootCooldown = shootCooldown,
        refireRate = shootCooldown,
    }
end

return ShootComponent