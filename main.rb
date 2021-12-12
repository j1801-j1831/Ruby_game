# coding: utf-8
require 'dxopal'
include DXOpal

require_remote 'player.rb'
require_remote 'enemy.rb'
require_remote 'block.rb'
require_remote 'stage1.rb'

Image.register(:player, 'images/sq.png') 
Image.register(:enemy, 'images/enemy.png') 

Image.register(:brick, 'images/Renga.png') 
Image.register(:tile, 'images/tile.png') 
Image.register(:asphalt, 'images/asufaruto.png') 
Image.register(:wood, 'images/wood.png') 
Image.register(:woodbox, 'images/woodbox.png') 

Image.register(:sq, 'images/sq.png') 

Window.load_resources do
  Window.width  = 1200
  Window.height = 720

  player_img = Image[:player]
  player_img.set_color_key([0, 0, 0])

  enemy_img = Image[:enemy]
  enemy_img.set_color_key([0, 0, 0])
  
  brick_img = Image[:brick]
  brick_img.set_color_key([0, 0, 0])
  tile_img = Image[:tile]
  tile_img.set_color_key([0, 0, 0])
  asphalt_img = Image[:asphalt]
  asphalt_img.set_color_key([0, 0, 0])
  wood_img = Image[:wood]
  wood_img.set_color_key([0, 0, 0])
  woodbox_img = Image[:woodbox]
  woodbox_img.set_color_key([0, 0, 0])
  
  sq_img = Image[:sq]
  sq_img.set_color_key([0, 0, 0])
  
  player = Player.new(400, 500, player_img)

  enemies = []
  10.times do
    enemies << Enemy.new(rand(800), rand(600), enemy_img)
  end
  
  blocks = []
  blocks2 = []
  15.times do |i|
    25.times do |j|
      case $field[i][j]
      when 1 then
        blocks << Block.new(j*48,i*48,asphalt_img)
        blocks2 << Block.new(j*48,i*48,asphalt_img)
      when 0 then 
        blocks << Block.new(j*48,i*48,tile_img)
        blocks2 << Block.new(j*48,i*48,tile_img)
      when 2 then 
        blocks << Block.new(j*48,i*48,asphalt_img)
        blocks2 << Block.new(j*48,i*48,asphalt_img)
      when 6 then 
        blocks << Block.new(j*48,i*48,woodbox_img)
        blocks2 << Block.new(j*48,i*48,woodbox_img)
      else
        
      end
    end
  end

  Window.loop do
    #Sprite.update(enemies)
    #Sprite.draw(enemies)
    Sprite.draw(blocks)
    
    player.update
    player.draw

    # 当たり判定
    Sprite.check(player, enemies)
  end
end