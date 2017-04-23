class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html, :js

  def round_info
    @game = Game.where(id: params[:game]).first
    @round = params[:round]
    @scores = Score.where(game: @game, round: @round).order(:player_id).includes(:player)

    respond_to do |format|
      format.js { render 'players/player_info'}
    end
  end

  def index
    @scores = Score.all
    respond_with(@scores)
  end

  def show
    respond_with(@score)
  end

  def new
    @score = Score.new
    respond_with(@score)
  end

  def edit
  end

  def create
    @score = Score.new(score_params)
    @score.save
    respond_with(@score)
  end

  def update
    @score.update(score_params)
    respond_with(@score)
  end

  def destroy
    @score.destroy
    respond_with(@score)
  end

  private
    def set_score
      @score = Score.find(params[:id])
    end

    def score_params
      params.require(:score).permit(:round, :player_id, :game_id, :score)
    end
end
