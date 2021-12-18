# coding: utf-8

class Enemy < Sprite
  def initialize( x=0, y=0, image=nil, images=nil)
    super
    self.image=images[0]
    @images=images
    @grid_x=x/48
    @grid_y=y/48
    @moving_times=0
    @dx=0
    @dy=0
    @image_interval=0
    #self.collision = [x, y, x+48, y+48]
  end
  def xx
    return self.x
  end
  def yy
    return self.y
  end
  def dx
    return @dx
  end
  def dy
    return @dy
  end
  def moving(dx,dy)
    speed=2
    @moving_times=48/speed
    @dx=dx*speed
    @dy=dy*speed
    @grid_x+=dx
    @grid_y+=dy
  end
  def ismoving
    if @moving_times > 0
      return true
    else
      return false
    end
  end
  def update
    if @moving_times > 0
      @moving_times-=1
      @image_interval=(@image_interval+1)%20
      self.x+=@dx
      self.y+=@dy
      if @dx<0
        self.image=@images[0+(@image_interval<10?0:1)]
      elsif @dx>0
        self.image=@images[2+(@image_interval<10?0:1)]
      elsif @dy<0
        self.image=@images[4+(@image_interval<10?0:1)]
      elsif @dy>0
        self.image=@images[6+(@image_interval<10?0:1)]
      end
    end
  end
  def make_move(field,enemies_field)
    if self.ismoving == false
      r=rand(4)
      if r==0
        if @grid_x+1 >= Width
          next
        end
        if [1,2].include?(field[@grid_y][@grid_x+1]) && enemies_field[@grid_y][@grid_x+1] == 0
          enemies_field[@grid_y][@grid_x] = 0
          enemies_field[@grid_y][@grid_x+1] = 1
          self.moving(1,0)
        end
      elsif r==1
        if @grid_x-1 < 0
          next
        end
        if [1,2].include?(field[@grid_y][@grid_x-1]) && enemies_field[@grid_y][@grid_x-1] == 0
          enemies_field[@grid_y][@grid_x] = 0
          enemies_field[@grid_y][@grid_x-1] = 1
          self.moving(-1,0)
        end
      elsif r==2
        if @grid_y+1 >= Height
          next
        end
        if [1,2].include?(field[@grid_y+1][@grid_x]) && enemies_field[@grid_y+1][@grid_x] == 0
          enemies_field[@grid_y][@grid_x] = 0
          enemies_field[@grid_y+1][@grid_x] = 1
          self.moving(0,1)
        end
      else
        if @grid_y-1 < 0
          next
        end
        if [1,2].include?(field[@grid_y-1][@grid_x]) && enemies_field[@grid_y-1][@grid_x] == 0
          enemies_field[@grid_y][@grid_x] = 0
          enemies_field[@grid_y-1][@grid_x] = 1
          self.moving(0,-1)
        end
      end
    end
  end
end