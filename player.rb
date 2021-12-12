# coding: utf-8

class Player < Sprite
  def initialize( x=0, y=0, image=nil )
    super
    #self.collision = [x, y, x+48, y+48]
  end
  def update(dx,dy)
    self.x += dx
    self.y += dy
    #self.collision = [self.x, self.y, self.x+48, self.y+48]
  end
end