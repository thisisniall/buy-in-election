desc "This task is called by the Heroku scheduler to update the Candidates current prices"
task :update_candidates => :environment do
  puts "Updating feed..."
  Candidate.update_candidates
  puts "done."
end