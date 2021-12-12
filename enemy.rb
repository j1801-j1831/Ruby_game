# coding: utf-8

class Enemy < Sprite
  def initialize( x=0, y=0, image=nil)
    super
    @moving_times=0
    #self.collision = [x, y, x+48, y+48]
  end
  def update
    
  end

  # 他のオブジェクトから衝突された際に呼ばれるメソッド
  def hit
    self.vanish
  end
end