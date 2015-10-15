require 'active_record'
require 'rspec'

require '../app/models/person'

database_configuration = YAML::load(File.open('../config/database.yml'))
config = database_configuration['test']
ActiveRecord::Base.establish_connection(config)

RSpec.configure do |config|
   config.after(:each) do
     Person.all.each { |people| people.destroy}
   end
end

describe Person do

  it "has a first name" do
    aPerson = Person.new
    aPerson.first_name = "Maura"
    aPerson.save
    expect(aPerson.first_name).to eq "Maura"
  end

  it "has a last name" do
    aPerson = Person.new
    aPerson.last_name = "Isles"
    aPerson.save
    expect(aPerson.last_name).to eq "Isles"
  end

  it "has a mother (maybe)" do
    momPerson = Person.new
    momPerson.first_name = "Hope"
    momPerson.last_name = "Martin"
    momPerson.save
    aPerson = Person.new
    aPerson.first_name = "Maura"
    aPerson.last_name = "Isles"
    aPerson.mother = momPerson
    aPerson.save

    expect(aPerson.mother).to eq momPerson
    expect(momPerson.mother).to eq nil
  end

  it "has a father (maybe)" do
    aPerson = Person.new
    aPerson.first_name = "Jane"
    aPerson.last_name = "Rizzoli"
    aPerson.save

    dadPerson = Person.new
    dadPerson.first_name = "Frank"
    dadPerson.last_name = "Rizzoli"
    dadPerson.save

    aPerson.father = dadPerson
    aPerson.save

    expect(aPerson.father).to eq dadPerson
    expect(dadPerson.father).to eq nil
  end

  # it "has maternal grandparents" do
  #   grandMomPerson = Person.new
  #   grandMomPerson.first_name = "Kasey"
  #   grandMomPerson.last_name = "Hope"
  #   grandMomPerson.save
  #
  #   grandDadPerson = Person.new
  #   grandDadPerson.first_name = "Patrick"
  #   grandDadPerson.last_name = "Doyle"
  #   grandDadPerson.save
  #
  #   momPerson = Person.new
  #   momPerson.first_name = "Hope"
  #   momPerson.last_name = "Martin"
  #   momPerson.mother = grandMomPerson
  #   momPerson.father = grandDadPerson
  #   momPerson.save
  #
  #   aPerson = Person.new
  #   aPerson.first_name = "Maura"
  #   aPerson.last_name = "Isles"
  #   aPerson.mother = momPerson
  #   aPerson.save
  #
  #   expect(aPerson.grandparents).to match_array [grandDadPerson, grandMomPerson]
  # end

  it "has grandparents" do
    grandMomPerson = Person.new
    grandMomPerson.first_name = "Kasey"
    grandMomPerson.last_name = "Hope"
    grandMomPerson.save

    grandMaPerson = Person.new
    grandMaPerson.first_name = "Angela"
    grandMaPerson.last_name = "Carter"
    grandMaPerson.save

    grandDadPerson = Person.new
    grandDadPerson.first_name = "Patrick"
    grandDadPerson.last_name = "Doyle"
    grandDadPerson.save

    # grandPaPerson = Person.new
    # grandPaPerson.first_name = "Jimmy"
    # grandPaPerson.last_name = "Forst"
    # grandPaPerson.save

    momPerson = Person.new
    momPerson.first_name = "Hope"
    momPerson.last_name = "Martin"
    momPerson.mother = grandMomPerson
    momPerson.father = grandDadPerson
    momPerson.save

    dadPerson = Person.new
    dadPerson.first_name = "Ethan"
    dadPerson.last_name = "Ryan"
    dadPerson.mother = grandMaPerson
    # dadPerson.father = grandPaPerson
    dadPerson.save

    aPerson = Person.new
    aPerson.first_name = "Maura"
    aPerson.last_name = "Isles"
    aPerson.mother = momPerson
    aPerson.father = dadPerson
    aPerson.save

    expect(aPerson.grandparents).to be_a Array
    expect(aPerson.grandparents).to match_array [grandDadPerson, grandMomPerson, grandMaPerson]
  end

  it "has ancestors" do
    grandMomPerson = Person.new
    grandMomPerson.first_name = "Kasey"
    grandMomPerson.last_name = "Hope"
    grandMomPerson.save

    grandMaPerson = Person.new
    grandMaPerson.first_name = "Angela"
    grandMaPerson.last_name = "Carter"
    grandMaPerson.save

    grandDadPerson = Person.new
    grandDadPerson.first_name = "Patrick"
    grandDadPerson.last_name = "Doyle"
    grandDadPerson.save

    # grandPaPerson = Person.new
    # grandPaPerson.first_name = "Jimmy"
    # grandPaPerson.last_name = "Forst"
    # grandPaPerson.save

    momPerson = Person.new
    momPerson.first_name = "Hope"
    momPerson.last_name = "Martin"
    momPerson.mother = grandMomPerson
    momPerson.father = grandDadPerson
    momPerson.save

    dadPerson = Person.new
    dadPerson.first_name = "Ethan"
    dadPerson.last_name = "Ryan"
    dadPerson.mother = grandMaPerson
    # dadPerson.father = grandPaPerson
    dadPerson.save

    aPerson = Person.new
    aPerson.first_name = "Maura"
    aPerson.last_name = "Isles"
    aPerson.mother = momPerson
    aPerson.father = dadPerson
    aPerson.save

    expect(aPerson.ancestors).to be_a Array
    expect(aPerson.ancestors).to match_array [momPerson, grandMomPerson]
  end


end
