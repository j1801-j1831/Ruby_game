# coding: utf-8
require 'dxopal'
include DXOpal

require_remote 'player.rb'
require_remote 'enemy.rb'
require_remote 'block.rb'
require_remote 'shot.rb'
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
  
  player = Player.new(240, 240, player_img)

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
  
  shots = []

  Window.loop do
    #Sprite.update(enemies)
    #Sprite.draw(enemies)
    Sprite.draw(blocks)
    
    if Input.key_push?( K_SPACE )
      shots << Shot.new(player.xx,player.yy,sq_img,player.dirx*8,player.diry*8)
    end
    shots.each do |x|
      x.update
    end
    Sprite.draw(shots)
    
    dx = Input.x
    dy = Input.y
    if dx!=0
      player.update_dir(dx,0)
    elsif dy!=0
      player.update_dir(0,dy)
    end
    player.update(dx*4,0)
    blocks.each do |x|
      if [6,0].include?(x.type)
        if player === x
          player.update(-dx*4,0)
          break
        end
      end
    end
    player.update(0,dy*4)
    blocks.each do |x|
      if [6,0].include?(x.type)
        if player === x
          player.update(0,-dy*4)
          break
        end
      end
    end
    player.draw

  end
end