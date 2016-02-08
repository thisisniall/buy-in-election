class CandidatesController < ApplicationController
  def index
  	@candidates = Candidates.all
  end

  def show
  	@candidate = Candidates.find(params[:id])
  end

  def edit
  	@candidate = Candidates.find(params[:id])
  end

  def update
  	@candidate = Candidates.update(candidate_params)
  end

  private

  def candidate_params
  	params.require(:candidate).permit(:name, :party, :iowa_average, :iowa_bid, :iowa_ask, :iowa_high, :iowa_low, :twitter_pos, :twitter_neg, :twitter_tot)
  end
end
