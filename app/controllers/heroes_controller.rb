class HeroesController < ApplicationController
  before_action :set_hero, only: [:show, :edit, :update, :destroy]

  # GET /heroes
  def index
  end

  # GET /heroes/1
  def show
  end

  # GET /heroes/new
  def new
    @hero = Hero.new
  end

  # GET /heroes/1/edit
  def edit
  end

  # POST /heroes
  def create
    screen_name = params[:hero][:handle]

    if (screen_name[0] == "@")
      screen_name[0] = ""
    end

    @user = Hero.find_by(handle: session['user'])
    @hero = Hero.find_or_create_by({ handle: params[:hero][:handle] }) do |hero|
      hero.handle = params[:hero][:handle]
      hero.hp = 1
      hero.sword = false
    end

    @hero.hp += 1
    @user.hp -= 1

    if @hero.save && @user.save
      render js: "Q.state.set('hp', #{ @user.hp });"
    end
  end

  # PATCH/PUT /heroes/1
  def update
    if @hero.update(hero_params)
      redirect_to @hero, notice: 'Hero was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /heroes/1
  def destroy
    @hero.destroy
    redirect_to heroes_url, notice: 'Hero was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hero
      @hero = Hero.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hero_params
      params.require(:hero).permit(:handle, :hp, :room, :sword)
    end
end
