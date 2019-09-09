require 'gosu'

require_relative 'z_order'

require_relative 'star'
require_relative 'player'

class Tutorial < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'tutorial game'

    @bg = Gosu::Image.new 'media/space.png', tileable: true

    @star_motion = Gosu::Image.load_tiles 'media/star.png', 25, 25
    @stars = []

    @player = Player.new
    @player.warp 320, 240
  end

  def update
    rand(100) < 4 && @stars.size < 4 && @stars.push(Star.new(@star_motion))

    Gosu.button_down?(Gosu::KB_LEFT) && @player.turn_left
    Gosu.button_down?(Gosu::KB_RIGHT) && @player.turn_right
    Gosu.button_down?(Gosu::KB_UP) && @player.accelerate
    @player.move
  end

  def draw
    @bg.draw 0, 0, ZOrder::BG
    @stars.each(&:draw)
    @player.draw
  end

  def button_down(id)
    case id
    when Gosu::KB_ESCAPE then close
    else super
    end
  end
end

Tutorial.new.show
