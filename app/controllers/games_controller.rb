class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :update_scores]
  before_action :authenticate_user!

  respond_to :html, :js

  def index
    @games = current_user.games
    respond_with(@games)
  end

  def show
    @players = @game.players
    respond_with(@game)
  end

  def new
    @game = Game.new
    respond_with(@game)
  end

  def edit
  end

  def create
    players = params['game']['players']

    @game = Game.new(game_params)

    if (@game.save)
      @game.players = Player.where(id: players)
    end

    respond_with(@game)
  end

  def update
    @game.update(game_params)
    respond_with(@game)
  end

  def update_scores
    @score_ids = params['game']['scores']
    scores = Score.where(id: @score_ids)
    @value = params['score']
    scores.each do |score|
      score.score = @value.to_f
      score.save
    end
  end

  def destroy
    @game.destroy
    respond_with(@game)
  end

  private
    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:user_id, :name)
    end
end
