require 'active_record'

class Person < ActiveRecord::Base

  belongs_to :mother, :class_name => 'Person'
  belongs_to :father, :class_name => 'Person'

  def grandparents
    grandparentals = []

    if !mother.mother.nil?
      grandparentals << mother.mother
    end

    if !mother.father.nil?
      grandparentals << mother.father
    end

    if !father.father.nil?
      grandparentals << father.father
    end

    if !father.mother.nil?
      grandparentals << father.mother
    end

    grandparentals
  end

  def ancestors
    grandparentals = []
    aPerson = self
    while !aPerson.mother.nil? do
      grandparentals << aPerson.mother
      aPerson = aPerson.mother
    end

    # while !aPerson.father.nil? do
    #   grandparentals << aPerson.father
    #   aPerson = aPerson.father
    # end
    grandparentals
  end

end
