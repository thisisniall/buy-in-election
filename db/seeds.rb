# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Candidate.create(name: "Hillary Clinton", party: 0, total_shares: 0)
# Candidate.create(name: "Bernie Sanders", party: 0, total_shares: 0)
# Candidate.create(name: "Dem_ROF", party: 0, total_shares: 0)
# Candidate.create(name: "Ben Carson", party: 1, total_shares: 0)
# Candidate.create(name: "Ted Cruz", party: 1, total_shares: 0)
# Candidate.create(name: "Marco Rubio", party: 1, total_shares: 0)
# Candidate.create(name: "Donald Trump", party: 1, total_shares: 0)
# Candidate.create(name: "Rep_ROF", party: 1, total_shares: 0)
# ​
# Candidate.d_get_data
# Candidate.r_get_data

# this is for the initial database setup
Candidate.create([{ name: 'Hillary Clinton', party: 0, total_shares: 0 }, {name: "Bernie Sanders", party: 0, total_shares: 0}, {name: "Dem_ROF", party: 0, total_shares: 0}, {name: "Ben Carson", party: 1, total_shares: 0}, {name: "Ted Cruz", party: 1, total_shares: 0}, {name: "Marco Rubio", party: 1, total_shares: 0}, {name: "Donald Trump", party: 1, total_shares: 0}, {name: "Rep_ROF", party: 1, total_shares: 0}])