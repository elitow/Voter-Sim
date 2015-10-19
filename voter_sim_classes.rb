module VoterSimClasses

  class Voter
    attr_accessor :voter_name, :voter_political_view
    def initialize(voter_name, voter_political_view)
      @voter_name = voter_name
      @voter_political_view = voter_political_view
    end
  end


  class Politician
    attr_accessor :politician_name, :politician_party
    def initialize(politician_name, politician_party)
      @politician_name = politician_name
      @politician_party = politician_party
    end
  end

end
