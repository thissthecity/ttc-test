local animation = {
    dict = 'amb@prop_human_bum_bin@idle_a',
    anim = 'idle_a',
    inSpeed = 6.0,
    outSpeed = -6.0,
    duration = 5000,
    flag = 1,
    rate = 0,
    x = 0,
    y = 0,
    z = 0
}

local function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(1)
    end
end

RegisterCommand('startanim', function(source, args, rawCommand)
    local anim = animation
    if args[1] then
        anim.dict = args[1]
    end
    if args[2] then
        anim.anim = args[2]
    end
    print(string.format('Executando {dict = "%s", animacao = "%s"}', args[1], args[2]))
    local ped = PlayerPedId()
    LoadAnim(anim.dict)
    TaskPlayAnim(ped, anim.dict, anim.anim, anim.inSpeed, anim.outSpeed, anim.duration, anim.flag, anim.rate, anim.x, anim.y, anim.z)
end)

RegisterCommand('stopanim', function(source, args, rawCommand)
    ClearPedTasks(PlayerPedId())
end)