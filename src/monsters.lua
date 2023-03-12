require "src.move_slime"

nb_monsters = {0, 1, 0, 0, 0, 0, 0}

function get_quad(image, width, height, duration)
    local quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
    return quads
end

function init_monster(id, x, y)
    local img = love.graphics.newImage(string.format("sprites/%s.png", id))
    monster = {}
    monster.id = "slime"
    monster.pos = {x, y}
    monster.anim = newAnimation(love.graphics.newImage(string.format("sprites/%s.png", id)), 8, 8, 6)
    monster.quad1 = love.graphics.newQuad(0, 0, 8, 8, img:getDimensions())
    monster.quad2 = love.graphics.newQuad(8, 0, 8, 8, img:getDimensions())
    return monster
end

function get_monster(map_id)
    local monster_temp = {}

    if map_id == 2 then
        monster_temp = {init_monster("slime", 16, 7)}
    end
    -- if (map_id == 3) then
    --     return {{"pot", 1, 1},
    --             {"slime", 1, 2}}
    -- end
    -- if (map_id == 4) then
    --     return {{"pot", 1, 1},
    --             {"slime", 1, 2}}
    -- end
    return monster_temp
end

function monsters_load()
    monster = get_monster(2)
    for i = 1, nb_monsters[map_nb] do
        print(monster[i].id)
    end
end

function monsters_move()
    for i = 1, nb_monsters[map_nb] do
        if (monster[i].id == "slime") then
            move_slime(monster[i])
        end
    end
end

function monsters_update()
    for i = 1, nb_monsters[map_nb] do
        monster[i].anim.currentTime = monster[i].anim.currentTime + dt
        if monster[i].anim.currentTime >= monster[i].anim.duration then
            monster[i].animcurrentTime = monster[i].anim.currentTime - monster[i].anim.duration
        end
    end
end

function monsters_draw()
    for i = 1, nb_monsters[map_nb] do
        local spriteNum = math.floor(monster[i].anim.currentTime / monster[i].anim.duration * 2) + 1
        print(tostring(spriteNum))
        if spriteNum % 2 == 1 then
            love.graphics.draw(monster[i].anim.spriteSheet, monster[i].quad1, monster[i].pos[1] * 64, monster[i].pos[2] * 64, 0, 8)
        end
        if spriteNum % 2 == 0 then
            love.graphics.draw(monster[i].anim.spriteSheet, monster[i].quad2, monster[i].pos[1] * 64, monster[i].pos[2] * 64, 0, 8)
        end

    end
end