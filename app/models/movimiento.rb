class Movimiento
  attr_accessor :fecha, :recaudacion	
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end
end