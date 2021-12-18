# coding: utf-8

class Player < Sprite
  def initialize( x=0, y=0, image=nil, images=nil)
    super
    self.image=images[0]
    @images=images
    @dirx=0 #向き
    @diry=1
    @image_interval=0
    @hp=3
    #self.collision = [x, y, x+48, y+48]
  end
  def update(dx,dy)
    if dx!=0||dy!=0
      self.x += dx
      self.y += dy
      @image_interval=(@image_interval+1)%10
      if @dirx<0
        self.image=@images[0+(@image_interval<5?0:1)]
      elsif @dirx>0
        self.image=@images[2+(@image_interval<5?0:1)]
      elsif @diry<0
        self.image=@images[4+(@image_interval<5?0:1)]
      elsif @diry>0
        self.image=@images[6+(@image_interval<5?0:1)]
      end
      #self.collision = [self.x, self.y, self.x+48, self.y+48]
    end
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