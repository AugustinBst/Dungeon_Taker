local love = require 'love'
function player_load()

    life = 3
    pot = love.graphics.newImage("sprites/pot.png")

    player_pose = {
        {13, 9},
        {10, 7},
        {7, 10},
        {7, 7},
        {5, 11},
        {0, 8},
        {14, 14},
        {7, 7},
        {1, 8},
        {15, 14}
    }

    sprites_pose = {
    }

    sprites = {}
    player = newAnimation(love.graphics.newImage("sprites/player.png"), 8, 8, 6)
    table.insert(sprites, player)
    read_map()

end

function player_update()
    for i = 1, #sprites do
        sprites[i].currentTime = sprites[i].currentTime + dt
        if sprites[i].currentTime >= sprites[i].duration then
            sprites[i].currentTime = sprites[i].currentTime - sprites[i].duration
        end
    end
end

function player_draw()
    for i = 2, #sprites do
        local spriteNum = math.floor(sprites[i].currentTime / sprites[i].duration * #sprites[i].quads) + 1
        love.graphics.draw(sprites[i].spriteSheet, sprites[i].quads[spriteNum], sprites_pose[i - 1][1] * 64, sprites_pose[i - 1][2] * 64, 0, 8)
    end

    local spriteNum = math.floor(sprites[1].currentTime / sprites[1].duration * #sprites[1].quads) + 1
    love.graphics.draw(sprites[1].spriteSheet, sprites[1].quads[spriteNum], player_pose[map_nb][1] * 64, player_pose[map_nb][2] * 64, 0, 8)

    love.graphics.draw(pot, 28 * 64, 1 * 64, 0, 8)
    love.graphics.print(life, 27 * 64 + 30, 1 * 64, 0, 3, 4)
end

function move_player( key )

    if key == "up" then
        if map_list[map_nb][player_pose[map_nb][2]][player_pose[map_nb][1] + 1] ~= "wall" then
            player_pose[map_nb][2] = player_pose[map_nb][2] - 1
            update_map()
        end
    end
    if key == "right" then
        if map_list[map_nb][player_pose[map_nb][2] + 1][player_pose[map_nb][1] + 2] ~= "wall" then
            player_pose[map_nb][1] = player_pose[map_nb][1] + 1
            update_map()
        end
    end
    if key == "down" then
        if map_list[map_nb][player_pose[map_nb][2] + 2][player_pose[map_nb][1] + 1] ~= "wall" then
            player_pose[map_nb][2] = player_pose[map_nb][2] + 1
            update_map()
        end
    end
    if key == "left" then
        if map_list[map_nb][player_pose[map_nb][2] + 1][player_pose[map_nb][1]] ~= "wall" then
            player_pose[map_nb][1] = player_pose[map_nb][1] - 1
            update_map()
        end
    end
end


function move_player_in_tab( direction )
    
    return true
end

function newAnimation(image, width, height, duration)
    local sprites = {}
    sprites.spriteSheet = image;
    sprites.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(sprites.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    sprites.duration = duration or 1
    sprites.currentTime = 0

    return sprites
end

-- function spikes_gestion()
--     for y = 1, #map_list[map_nb] do
--         for x = 1, #map_list[map_nb][y] do
--             if map_list[map_nb][y][x] == "spk2" then
--                 map_list[map_nb][y][x] = "spk0"
--                 goto continue
--             end
--             if map_list[map_nb][y][x] == "spk1" then
--                 map_list[map_nb][y][x] = "spk2"
--             end
--             if map_list[map_nb][y][x] == "spk0" then
--                 map_list[map_nb][y][x] = "spk1"
--             end
--             ::continue::
--         end
--     end
-- end
