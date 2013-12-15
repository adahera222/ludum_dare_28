class WelcomeController < ApplicationController

  def index
    @heroes = Hero.where("hp > 3").sort_by { |h| -h.hp }

  end
end
