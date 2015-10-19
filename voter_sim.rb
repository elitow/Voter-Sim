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

@voters = []
@politicians = []
@dem_votes = 0
@rep_votes = 0

def bye
  puts "BYEEEEE!"
end

def dem_votes
  @dem_votes = @dem_votes + 1
end

def rep_votes
  @rep_votes = @rep_votes + 1
end

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


def vote
  @politicians.each do |x|
   if x.politician_party == "Democrat"
     dem_votes
   elsif x.politician_party == "Republican"
     rep_votes
   end
 end

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

def update
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
