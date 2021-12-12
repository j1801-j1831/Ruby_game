# coding: utf-8

class Shot < Sprite
  def initialize( x=0, y=0, image=nil, dx=0, dy=0 )
    super
    @dx=dx
    @dy=dy
    #self.collision = [x, y, x+48, y+48]
  end
  def update
    self.x+=@dx
    self.y+=@dy
    if self.x<0 || self.x>Window.width || self.y<0 || self.y>Window.height
      self.vanish
    end
  end
end