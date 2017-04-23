class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :update_scores, :add_round]
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
    @game = Game.new(game_params)
    num_rounds = params['game']['rounds'].to_i

    if (@game.save)
      update_players(params)
      num_rounds.times do |round|
        @game.players.each do |player|
          Score.create(round: round+1, player: player, game: @game, score: 0)
        end
      end
    end

    respond_with(@game)
  end

  def update
    @game.update(game_params)
    update_players(params)

    # Look for any missing scores
    player_ids = @game.players.map(&:id)
    @game.rounds.each do |round_arr|
      round, scores = round_arr
      player_ids.each do |player_id|
        if(!scores.map(&:player_id).include?(player_id))
          Score.create(game: @game, player_id: player_id, score: 0, round: round)
        end
      end
    end

    respond_with(@game)
  end

  def update_scores
    @form_scores = params['game']['scores']
    @score_ids = @form_scores.is_a?(Hash) ? @form_scores.keys : @form_scores

    scores = Score.where(id: @score_ids)
    @players = scores.map(&:player).uniq
    scores.each do |score|
      @value = @form_scores.is_a?(Hash) ? @form_scores[score.id.to_s] : params['score']
      score.score = @value.to_f
      score.save
    end
  end

  def add_round
    @round = params['next-round'] || 1
    @players = @game.players
    @players.each do |player|
      Score.create(game: @game, player: player, score: 0, round: @round)
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

    def update_players(params)
      players = params['game']['players']
      @game.players = Player.where(id: players)
    end
end
