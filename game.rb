require 'gosu'

require_relative 'z_order'

require_relative 'star'
require_relative 'spaceship'

class Game < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'game'

    @bg = Gosu::Image.new 'media/space.png', tileable: true

    @star_motion = Gosu::Image.load_tiles 'media/star.png', 25, 25
    @stars = []

    @ship = Spaceship.new
    @ship.warp 320, 240

    @font = Gosu::Font.new 20
  end

  def update
    rand(100) < 4 && @stars.size < 12 && @stars.push(Star.new(@star_motion))

    Gosu.button_down?(Gosu::KB_LEFT) && @ship.turn_left
    Gosu.button_down?(Gosu::KB_RIGHT) && @ship.turn_right
    Gosu.button_down?(Gosu::KB_UP) && @ship.accelerate
    @ship.move
    @ship.collect_stars(@stars)
  end

  def draw
    @bg.draw 0, 0, ZOrder::BG
    @stars.each(&:draw)
    @ship.draw
    @font.draw_text @ship.score.to_s, 10, 10, ZOrder::UI
  end

  def button_down(id)
    case id
    when Gosu::KB_ESCAPE then close
    else super
    end
  end
end

Game.new.show
