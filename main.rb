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
  
  player = Player.new(250, 300, player_img)

  enemies = []
  10.times do
    enemies << Enemy.new(rand(800), rand(600), enemy_img)
  end
  
  blocks = []
  15.times do |i|
    25.times do |j|
      case $field[i][j]
      when 1 then 
        blocks << Block.new(j*48,i*48,asphalt_img,1)
      when 0 then 
        blocks << Block.new(j*48,i*48,tile_img,0)
      when 2 then 
        blocks << Block.new(j*48,i*48,asphalt_img,2)
      when 6 then 
        blocks << Block.new(j*48,i*48,woodbox_img,6)
      else
        
      end
    end
  end

  Window.loop do
    #Sprite.update(enemies)
    #Sprite.draw(enemies)
    Sprite.draw(blocks)
    
    dx = Input.x*2
    dy = Input.y*2
    player.update(dx,0)
    blocks.each do |x|
      if [6,0].include?(x.type)
        if player === x
          player.update(-dx,0)
          break
        end
      end
    end
    player.update(0,dy)
    blocks.each do |x|
      if [6,0].include?(x.type)
        if player === x
          player.update(0,-dy)
          break
        end
      end
    end
    player.draw

  end
end