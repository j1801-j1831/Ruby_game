# coding: utf-8

class Block < Sprite
  def initialize( x=0, y=0, image=nil, type=-1 )
    super
    @type=type;
    #self.collision = [x, y, x+48, y+48]
  end
  def type
    return @type
  end
end