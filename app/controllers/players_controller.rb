class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy, :player_info]
  before_action :authenticate_user!

  respond_to :html, :js

  def set_players
    @players = Player.where(user: current_user)
  end

  def player_info
    @game = Game.where(id: params[:game]).first
    @scores = @player.scores.where(game: @game).order(:round)
  end

  def index
    set_players
    respond_with(@players)
  end

  def show
    respond_with(@player)
  end

  def new
    @player = Player.new
    respond_with(@player)
  end

  def edit
  end

  def create
    @player = Player.new(player_params)
    @player.save
    set_players
    respond_with(@player)
  end

  def update
    @player.update(player_params)
    respond_with(@player)
  end

  def destroy
    @player.destroy
    respond_with(@player)
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:user_id, :name)
    end
end
