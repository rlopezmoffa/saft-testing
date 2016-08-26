class DateRange
  attr_accessor :from, :to
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end  

  def initialize(from, to)
  	self.from = from
  	self.to = to
  end

  def includes(date)
    if date >= self.from && date <= self.to
      return true
    end
    return false
  end

  def days
    return (self.to - self.from).to_i
  end

  
end