# coding: utf-8

class CameraMove
  move=[]
  up=0
  down=1
  right=2
  left=3
  move[0]=0
  def move(player)
    if move[up]==1
      player.x=Window.width/2
      player.y=Window.height - player.image.height
      blocks_now=blocks2
      move[up]=0
    elsif move[down]==1
      player.x=Window.width/2
      player.y=0
      blocks_now=blocks
      move[down]=0
    elsif move[right]==1
      player.x=250
      player.y=330
      blocks_now=blocks
      move[right]=0
    elsif move[left]==1
      player.x=250
      player.y=300
      blocks_now=blocks
      move[left]=0
    end
  end
  
  def checkvec(player)
    if player.y <= 0 #上移動
      move[up]=1
    elsif player.y >= Window.height - player.image.height #下移動
      move[down]=1
    elsif player.x >= Window.width - player.image.width #右移動
      move[right]=1
    elsif player.x <= 0 #左移動
      move[left]=1
    end
  end
end