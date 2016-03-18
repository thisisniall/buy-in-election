class CandidatesController < ApplicationController
  def index
  	@candidates = Candidates.all
  end

  def show
  	@candidate = Candidate.find(params[:id])
  	@user = current_user
    @dem = Dem::Client.new.get_data
    @rep = Rep::Client.new.get_data
    @transaction = Transaction.new
  end

  def edit
  	@candidate = Candidates.find(params[:id])
  end

  def update
  	@candidate = Candidates.update(candidate_params)
  	@candidate.save
  	redirect_to candidates_path(@candidate)
  end


  # this function defines an array to hold each of the candidates data,
  # it then loops through for the number of rows in the table and puts each datapoint into the
  # an array thats then pushed to the candidates data array
  # def get_data
  #   @democrats = []
  #   for i in 0..3 do
  #     cand = Array.new
  #     for x in 0..6 do
  #       cand.push(doc.search('TR')[i].children.children[x].text)
  #     end
  #     @democrats.push(cand)
  #   end
  # end

  private

  def candidate_params
  	params.require(:candidate).permit(:name, :party, :total_shares, :iowa_average, :twitter_pos, :twitter_neg, :twitter_tot)
  end
end
