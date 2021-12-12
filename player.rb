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
  def make_move(blocks_now)
    dx = Input.x
    dy = Input.y
    if dx!=0
      self.update_dir(dx,0)
    elsif dy!=0
      self.update_dir(0,dy)
    end
    self.update(dx*4,0)
    blocks_now.each do |x|
      if [6,0].include?(x.type)
        if self === x
          self.update(-dx*4,0)
          break
        end
      end
    end
    self.update(0,dy*4)
    blocks_now.each do |x|
      if [6,0].include?(x.type)
        if self === x
          self.update(0,-dy*4)
          break
        end
      end
    end
  end
end