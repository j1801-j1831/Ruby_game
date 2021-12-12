# coding: utf-8

class Player < Sprite
  def initialize( x=0, y=0, image=nil )
    super
    @dirx=0 #向き
    @diry=1
    @hp=3
    #self.collision = [x, y, x+48, y+48]
  end
  def update(dx,dy)
    self.x += dx
    self.y += dy
    #self.collision = [self.x, self.y, self.x+48, self.y+48]
  end
  def update_dir(dx,dy)
    @dirx=dx
    @diry=dy
  end
  def xx
    return self.x
  end
  def yy
    return self.y
  end
  def dirx
    return @dirx
  end
  def diry
    return @diry
  end
  def returnhp
    return @hp
  end
  def decrease_hp
    @hp-=1
  end
end