class CandidatesController < ApplicationController
  def index
  	@candidates = Candidates.all
  end

  def show
  	@candidate = Candidate.find(params[:id])
  	@user = current_user
    @dem = Iowa::Client.new.dem['results']['collection1']
    @rep = Iowa::Client.new.rep['results']['collection1']
  end

  def edit
  	@candidate = Candidates.find(params[:id])
  end

  def update
  	@candidate = Candidates.update(candidate_params)
  	@candidate.save
  	redirect_to candidates_path(@candidate)
  end

  private

  def candidate_params
  	params.require(:candidate).permit(:name, :party, :total_shares, :iowa_average, :twitter_pos, :twitter_neg, :twitter_tot)
  end
end
