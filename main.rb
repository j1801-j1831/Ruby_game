# coding: utf-8
require 'dxopal'
require 'csv'
include DXOpal

require_remote 'player.rb'
require_remote 'enemy.rb'

Image.register(:player, 'images/sq.png') 
Image.register(:enemy, 'images/sq.png') 

Image.register(:brick, 'images/sq.png') 
Image.register(:tile, 'images/sq.png') 
Image.register(:asphalt, 'images/sq.png') 

field = CSV.read("field.csv")

Window.load_resources do
  Window.width  = 800
  Window.height = 600

  player_img = Image[:player]
  player_img.set_color_key([0, 0, 0])

  enemy_img = Image[:enemy]
  enemy_img.set_color_key([0, 0, 0])
  
  player = Player.new(400, 500, player_img)

  enemies = []
  10.times do
    enemies << Enemy.new(rand(800), rand(600), enemy_img)
  end

  Window.loop do
    Sprite.update(enemies)
    Sprite.draw(enemies)

    player.update
    player.draw

    # 当たり判定
    Sprite.check(player, enemies)
  end
end