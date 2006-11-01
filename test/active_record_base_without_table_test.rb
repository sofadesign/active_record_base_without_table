require File.dirname(__FILE__) + '/abstract_unit'

class Person < ActiveRecord::BaseWithoutTable
  column :name, :string
  column :lucky_number, :integer, 4
  
  validates_presence_of :name
end

class ActiveRecordBaseWithoutTableTest < Test::Unit::TestCase
  def test_default_value
    assert_equal 4, Person.new.lucky_number
  end
  
  def test_validation
    p = Person.new
    
    assert !p.save
    assert p.errors[:name]
    
    assert p.update_attributes(:name => 'Name')
  end
  
  def test_typecast
    assert_equal 1, Person.new(:lucky_number => "1").lucky_number
  end
end
