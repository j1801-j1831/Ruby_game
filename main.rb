# coding: utf-8
require 'dxopal'
include DXOpal

require_remote 'player.rb'
require_remote 'enemy.rb'
require_remote 'block.rb'
require_remote 'shot.rb'
require_remote 'stage1.rb'
require_remote 'stage2.rb'

Image.register(:player, 'images/sq.png') 
Image.register(:enemy, 'images/enemy.png') 

Image.register(:brick, 'images/Renga.png') 
Image.register(:tile, 'images/tile.png') 
Image.register(:asphalt, 'images/asufaruto.png') 
Image.register(:wood, 'images/wood.png') 
Image.register(:woodbox, 'images/woodbox.png') 

Image.register(:sq, 'images/sq.png') 

Height = 15
Width = 25

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
  
  enemies_field=Array.new(Height).map{Array.new(Width,0)}
  enemies = []
  10.times do
    while true do
      x=rand(Width)
      y=rand(Height)
      if $field[y][x] != 1
        next
      end
      if enemies_field[y][x] != 0
        next
      end
      enemies_field[y][x]=1
      enemies << Enemy.new(x*48, y*48, enemy_img)
      break
    end
  end
  
  blocks = []
  blocks2 = []
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
      
      case $field2[i][j]
      when 1 then
        blocks2 << Block.new(j*48,i*48,asphalt_img,1)
      when 0 then
        blocks2 << Block.new(j*48,i*48,tile_img,0)
      when 2 then
        blocks2 << Block.new(j*48,i*48,asphalt_img,2)
      when 6 then
        blocks2 << Block.new(j*48,i*48,woodbox_img,6)
      else
      end
      
    end
  end
  
  shots = []

  move=[]
  up=0
  down=1
  right=2
  left=3
  move[0]=0
  blocks_now=blocks
  Window.loop do
    #Sprite.update(enemies)
    #Sprite.draw(enemies)
    if player.y <= 0 #上移動
      move[up]=1
    elsif player.y >= Window.height - player.image.height #下移動
      move[down]=1
    elsif player.x >= Window.width - player.image.width #右移動
      move[right]=1
    elsif player.x <= 0 #左移動
      move[left]=1
    end
    
    if move[up]==1
      player.x=Window.width/2
      player.y=Window.height - player.image.height
      blocks_now=blocks2
      move[up]=0
    elsif move[down]==1
      player.x=Window.width/2
      player.y=0
      blocks_now=blocks
      move[down]=0
    elsif move[right]==1
      player.x=250
      player.y=330
      blocks_now=blocks
      move[right]=0
    elsif move[left]==1
      player.x=250
      player.y=300
      blocks_now=blocks
      move[left]=0
    end
    
    if blocks_now==blocks
      Sprite.draw(blocks)
    elsif blocks_now==blocks2
      Sprite.draw(blocks2)
    end
    
    if Input.key_push?( K_SPACE ) && shots.size < 2
      shots << Shot.new(player.xx,player.yy,sq_img,player.dirx*8,player.diry*8)
    end
    del_shots=[]
    shots.each_with_index do |x, i|
      x.update
      if x.vanished?
        del_shots << i
      end
    end
    del_shots.each do |i|
      shots.delete_at(i)
    end
    
    
    dx = Input.x
    dy = Input.y
    if dx!=0
      player.update_dir(dx,0)
    elsif dy!=0
      player.update_dir(0,dy)
    end
    player.update(dx*4,0)
    blocks_now.each do |x|
      if [6,0].include?(x.type)
        if player === x
          player.update(-dx*4,0)
          break
        end
      end
    end
    player.update(0,dy*4)
    blocks_now.each do |x|
      if [6,0].include?(x.type)
        if player === x
          player.update(0,-dy*4)
          break
        end
      end
    end
    
    Sprite.update(enemies)
    
    #Sprite.draw(blocks)
    Sprite.draw(enemies)
    Sprite.draw(shots)
    player.draw
  end
end