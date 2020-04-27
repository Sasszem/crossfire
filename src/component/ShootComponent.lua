local function ShootComponent(bullet, shoot_cooldown)
    return {
        bullet = bullet,
        shoot_cooldown = shoot_cooldown,
        refire_rate = shoot_cooldown,
    }
end

return ShootComponent