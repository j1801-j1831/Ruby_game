# coding: utf-8
require 'dxopal'
include DXOpal

require_remote 'player.rb'
require_remote 'enemy.rb'
require_remote 'block.rb'
require_remote 'shot.rb'
require_remote 'stage1.rb'
require_remote 'stage2.rb'
require_remote 'stage3.rb'
require_remote 'stage4.rb'

Image.register(:player0, 'images/player_move.png') 
Image.register(:player1, 'images/player_stop.png') 
Image.register(:player2, 'images/player_move_flip.png') 
Image.register(:player3, 'images/player_stop_flip.png') 
Image.register(:player4, 'images/player_back.png') 
Image.register(:player5, 'images/player_back_flip.png') 
Image.register(:player6, 'images/front_player1_touka.png') 
Image.register(:player7, 'images/front_player1_touka_flip.png') 

Image.register(:enemy0, 'images/dorobo_walk_small.png') 
Image.register(:enemy1, 'images/dorobo_stop_small.png') 
Image.register(:enemy2, 'images/dorobo_walk_small_flip.png') 
Image.register(:enemy3, 'images/dorobo_stop_small_flip.png') 
Image.register(:enemy4, 'images/dorobo_back_left_small.png') 
Image.register(:enemy5, 'images/dorobo_back_right_small.png') 
Image.register(:enemy6, 'images/dorobo_front_left_small.png') 
Image.register(:enemy7, 'images/dorobo_front_right_small.png') 

Image.register(:brick, 'images/Renga.png') 
Image.register(:tile, 'images/tile.png') 
Image.register(:asphalt, 'images/asufaruto.png') 
Image.register(:wood, 'images/wood.png') 
Image.register(:woodbox, 'images/woodbox_2.png') 

Image.register(:heart, 'images/HP.png')
Image.register(:heartB, 'images/HP_black.png')

Image.register(:bullet0, 'images/TNT_left.png') 
Image.register(:bullet1, 'images/TNT_right.png') 
Image.register(:bullet2, 'images/TNT_up.png')
Image.register(:bullet3, 'images/TNT_down.png')

Image.register(:sq, 'images/sq.png') 

Window.load_resources do
  Window.width  = 1200
  Window.height = 720
  
  Height = 15
  Width = 25

  player_imgs = [Image[:player0],Image[:player1],Image[:player2],Image[:player3],Image[:player4],Image[:player5],Image[:player6],Image[:player7]]
  player_imgs.each do |x|
    x.set_color_key([0, 0, 0])
  end

  enemy_imgs = [Image[:enemy0],Image[:enemy1],Image[:enemy2],Image[:enemy3],Image[:enemy4],Image[:enemy5],Image[:enemy6],Image[:enemy7]]
  enemy_imgs.each do |x|
    x.set_color_key([0, 0, 0])
  end
  
  bullet_imgs = [Image[:bullet0],Image[:bullet1],Image[:bullet2],Image[:bullet3]]
  enemy_imgs.each do |x|
    x.set_color_key([0, 0, 0])
  end
  
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
  
  heart_img = Image[:heart]
  heart_img.set_color_key([0, 0, 0])
  heartB_img = Image[:heartB]
  heartB_img.set_color_key([0, 0, 0])
  
  sq_img = Image[:sq]
  sq_img.set_color_key([0, 0, 0])
  
  player = Player.new(240, 240, player_imgs[0], player_imgs)
  
  fields = []
  fields << $field1
  fields << $field2
  fields << $field3
  fields << $field4
  
  now_stage = 0
  
  enemies_field=Array.new(4).map{Array.new(Height).map{Array.new(Width,0)}}
  enemies = [[],[],[],[]]
  4.times do |i|
    30.times do
      while true do
        x=rand(Width)
        y=rand(Height)
        if ![1,2].include?(fields[i][y][x])
          next
        end
        if enemies_field[i][y][x] != 0
          next
        end
        enemies_field[i][y][x]=1
        enemies[i] << Enemy.new(x*48, y*48, enemy_imgs[0], enemy_imgs)
        break
      end
    end
  end
  
  blocks = [[],[],[],[]]
  4.times do |i|
    15.times do |y|
      25.times do |x|
        case fields[i][y][x]
        when 1 then
          blocks[i] << Block.new(x*48,y*48,asphalt_img,1)
        when 0 then 
          blocks[i] << Block.new(x*48,y*48,tile_img,0)
        when 2 then 
          blocks[i] << Block.new(x*48,y*48,asphalt_img,2)
        when 3 then 
          blocks[i] << Block.new(x*48,y*48,brick_img,3)
        when 6 then 
          blocks[i] << Block.new(x*48,y*48,woodbox_img,6)
        else
        end
      end
    end
  end
  
  shots = []
  enemy_shots = []
  
  move=[0,0,0,0]

  up=0
  down=1
  right=2
  left=3
  move[0]=0
  
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
    
    if move[up]==1 && now_stage == 0 #stage1から2(上移動)
      player.x=Window.width/2
      player.y=Window.height - player.image.height
      now_stage=1
      move[up]=0
    elsif move[up]==1 && now_stage == 3 #stage4からstage3
      player.x=Window.width/2
      player.y=Window.height - player.image.height
      now_stage=2
      move[up]=0
    elsif move[down]==1 && now_stage == 1 #stage2から1
      player.x=Window.width/2
      player.y=0
      now_stage=0
      move[down]=0
    elsif move[down]==1 && now_stage == 2 #stage3から4
      player.x=Window.width/2
      player.y=0
      now_stage=3
      move[down]=0
    elsif move[right]==1 && now_stage == 1 #stage2から3
      player.x=0
      player.y=Window.height/2
      now_stage=2
      move[right]=0
    elsif move[right]==1 && now_stage == 0 #stage1から4
      player.x=0
      player.y=Window.height/2
      now_stage=3
      move[right]=0
    elsif move[left]==1 && now_stage == 2#stage3から2
      player.x=Window.width - player.image.width
      player.y=Window.height/2
      now_stage=1
      move[left]=0
    elsif move[left]==1 && now_stage == 3#stage4から1
      player.x=Window.width - player.image.width
      player.y=Window.height/2
      now_stage=0
      move[left]=0
    end
    
    Sprite.draw(blocks[now_stage])
    
    hearts=Array.new(3)
    hearts[0] = Sprite.new(0,0,heartB_img)
    hearts[1] = Sprite.new(32,0,heartB_img)
    hearts[2] = Sprite.new(64,0,heartB_img)
    
    player.returnhp.times do |i|
      hearts[i] = Sprite.new(32*i,0,heart_img)
    end
    
    Sprite.draw(hearts)
    
    if Input.key_push?( K_SPACE ) && shots.size < 2
      idx=0
      if player.dirx < 0
        idx=0
      elsif player.dirx > 0
        idx=1
      elsif player.diry < 0
        idx=2
      elsif player.diry > 0
        idx=3
      end
      shots << Shot.new(player.xx,player.yy,bullet_imgs[idx],player.dirx*8,player.diry*8)
    end
    del_shots=[]
    shots.each_with_index do |x, i|
      x.update
      enemies[now_stage].each do |y|
        if x===y
          x.vanish
          y.vanish
          break
        end
      end
      if x.vanished?
        del_shots << i
      end
    end
    del_shots.each do |i|
      shots.delete_at(i)
    end
    
    enemies[now_stage].each do |x|
      if x.vanished?
        next
      end
      if rand(100) == 0
        x.make_move(fields[now_stage],enemies_field[now_stage])
      end
      if rand(100) == 0
        idx=-1
        if x.dx < 0
          idx=0
        elsif x.dx > 0
          idx=1
        elsif x.dy < 0
          idx=2
        elsif x.dy > 0
          idx=3
        end
        if idx==-1
          next
        end
        enemy_shots << Shot.new(x.xx,x.yy,bullet_imgs[idx],x.dx*2,x.dy*2)
      end
    end
    enemy_del_shots=[]
    enemy_shots.each_with_index do |x, i|
      x.update
      if x===player
        player.decrease_hp
        x.vanish
      end
      if x.vanished?
        enemy_del_shots << i
      end
    end
    enemy_del_shots.each do |i|
      enemy_shots.delete_at(i)
    end
    
    player.make_move(blocks[now_stage])
    
    Sprite.update(enemies[now_stage])
    
    #Sprite.draw(blocks)
    Sprite.draw(enemies[now_stage])
    Sprite.draw(enemy_shots)
    Sprite.draw(shots)
    player.draw
  end
end