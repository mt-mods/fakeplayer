
mtt.register("fakeplayer.create smoketests", function(callback)
    local player = fakeplayer.create({ name = "myplayer" })
    assert(player)
    assert(player:get_pos())
    assert(player:get_player_name() == "myplayer")
    callback()
end)