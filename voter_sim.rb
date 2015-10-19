puts <<-EOP
************************************************************
************************************************************
************************************************************
********                                            ********
********         Welcome  Wyncode Voters            ********
********                                            ********
************************************************************
************************************************************
************************************************************
EOP

require "./voter_sim_classes"
include VoterSimClasses

#These two arrays keep track of the Voter and Politician instances.
@voters = []
@politicians = []

#The following instance variables keep track of the number of votes for each
#candidate
@dem_votes = 0
@rep_votes = 0

#Method used to exit the program.
def bye
  puts "BYEEEEE!"
end

#Method used for acquiring votes for democrats.
def dem_votes
  @dem_votes = @dem_votes + 1
end

#Method used for acquiring votes for republicans.
def rep_votes
  @rep_votes = @rep_votes + 1
end

#Method that is used for tallying up the vote and declaring
#the winner.
def tally
  @dem_votes + @rep_votes
  p "Democrat votes:#{@dem_votes} Republican votes: #{@rep_votes}"
  if @dem_votes > @rep_votes
    puts "The democrats win the election!!!!!!"
    main_menu
  elsif @rep_votes > @dem_votes
    puts "The republicans win the election!!!!!"
    main_menu
  else
    puts "It's recount time!!!!"
    vote
  end
end

#Initialization of the voting process.
def vote
#Politicians vote for their own party.
  @politicians.each do |x|
   if x.politician_party == "Democrat"
     dem_votes
   elsif x.politician_party == "Republican"
     rep_votes
   end
 end

#Determines corresponding political view to political party based on random
#selection.
  @voters.each do |x|
    roll = rand(100)
  case x.voter_political_view
  when "Tea Party"
    if roll <= 10
      dem_votes
    else
      rep_votes
    end

  when "Conservative"
    if roll <= 25
      dem_votes
    else
      rep_votes
    end
  when "Neutral"
    if roll <= 50
      dem_votes
    else
      rep_votes
    end
  when "Liberal"
    if roll <=25
      rep_votes
    else
      dem_votes
    end
  when "Socialist"
    if roll <=10
      rep_votes
    else
      dem_votes
    end
  end#This ends the case
end#This ends the do
tally
main_menu
end#ends vote

#Allows user to update Politican and Voter instances.
def update
  #Updates a Voter instance.
  puts "Would you like to update a (p)olitician or
  a (v)oter?"
  update_person = gets.chomp.capitalize
  if update_person == "V"
    puts "What is the name of the voter you want to
    update?"
    old_name = gets.chomp.capitalize
    @voters.each do |voter|
    if old_name == voter.voter_name
    puts "#{old_name} was matched to our records!"
    puts "What would you like to update?
    (N)ame
    (P)olitical view"
    update_this = gets.chomp.capitalize
      if update_this == "N"
      puts "Please enter the voter's new name."
      new_name = gets.chomp.capitalize
        voter.voter_name = new_name
        puts "#{old_name}'s name has been changed to #{new_name}."
        main_menu

      #This is updating the Voter's political view
      elsif update_this == "P"
      puts <<-EOP
      "What is #{old_name}'s new political view?
      (L)iberal
      (C)onservative
      (T)ea Party
      (S)ocialist
      (N)eutral"
      EOP
      new_political_view = gets.chomp.capitalize
        voter.voter_political_view = new_political_view
        case new_political_view
        when "L"
          updated_political_view = "Liberal"
        when "C"
          updated_political_view = "Conservative"
        when "T"
          updated_political_view = "Tea Party"
        when "S"
          updated_political_view = "Socialist"
        else
          updated_political_view = "Neutral"
        end
        puts "#{old_name}'s political view has been changed to #{updated_political_view}."
        main_menu
      end

    else
      puts "Sorry, that name doesn't exist in our records"
    end
  end

  #Updates a Politician instance
  elsif update_person == "P"
    puts "What is the name of the politician you want to
    update?"
    pol_name = gets.chomp.capitalize
     @politicians.each do |politician|
      if pol_name == politician.politician_name
      puts "#{pol_name} was matched to our records!"
      puts "Please enter the #{pol_name}'s new party:
      (D)emocrat
      (R)epublican"
      party_update = gets.chomp.capitalize
      politician.politician_party = party_update
      if party_update == "D"
        updated_party = "Democrat"
      elsif party_update == "R"
        updated_party = "Republican"
      end
      puts "#{pol_name}'s party has been change to
      #{updated_party}"
      main_menu

      else
        puts "Sorry, that name doesn't exist in our records."
      main_menu
      end
  end
  end#Ends the update_person
end#Ends update

#Creates a list of Politicians and Voters along with their political views.
def list
  puts "List politicians and voters"
  @voters.each do |x|
    print "Voters:" + " "
    print  x.voter_name + " "
    puts x.voter_political_view
  end
    @politicians.each do |x|
      print "Politician:"  + " "
      print x.politician_name + " "
      puts x.politician_party
    end
  puts "..............................."
  main_menu
end

#Method for creating Voter instances
def create_voter
puts "Please enter a voter's name."
voter_name = gets.chomp.capitalize
puts <<-EOP
"What is #{voter_name}'s political view?
(L)iberal
(C)onservative
(T)ea Party
(S)ocialist
(N)eutral"
EOP
voter_political_view= gets.chomp.capitalize

  case voter_political_view
    when 'L'
      politics = "Liberal"
    when "C"
      politics = "Conservative"
    when "T"
      politics = "Tea Party"
    when "S"
      politics = "Socialist"
    else
      politics = "Neutral"
  end
new_voter = Voter.new(voter_name, politics)
p "#{voter_name} has been added to the voters list."
@voters << new_voter
main_menu
end

#Method for creating Politician instances.
def create_politician
  puts "Please enter politican's name."
  politician_name = gets.chomp.capitalize
  puts <<-EOP
  "What is politician's party affiliation?
  (D)emocrat
  (R)epublican"
   EOP
  politician_party = gets.chomp.capitalize
  case politician_party
    when "D"
      party = "Democrat"
    when "R"
      party = "Republican"
    else
      puts "Invalid input. Please try again"
      create_politician
  end
 new_politician = Politician.new(politician_name, party)
 p "#{politician_name} has been added to the politicians list."
 @politicians << new_politician
 main_menu
end

#Method for user to input if they want to create a Politician or Voter instance.
def create
    puts "Would you like to create a (P)olitician or (V)oter?"
    create_answer = gets.chomp.capitalize
  case create_answer
  when "P"
    puts "..............................."
    create_politician
  when "V"
    puts "..............................."
    create_voter
  else
    puts "Invalid answer. Please resubmit your answer. "
    create
  end
end

#Method creating the main_menu to be referenced throughout program.
def main_menu
  puts <<-EOP
  "What would you like to do?"
  (C)reate
  (L)ist
  (U)pdate
  (V)ote
  (E)xit
  EOP
  answers = gets.chomp.capitalize
  case answers
  when 'C'
    create
  when 'L'
    puts "..............................."
    list
  when 'U'
    puts "..............................."
    update
  when 'V'
    puts "..............................."
    vote
  when 'E'
    bye
  else
    puts "Invalid answer. Please resubmit your answer. "
    main_menu
  end
end
main_menu
