class ProductTrait < ActiveRecord::Base

  belongs_to  :product
  belongs_to  :trait

  validates_presence_of     :product
  validates_presence_of     :trait
  validates_numericality_of :value, allow_nil: true
  validates_format_of       :value, with: /^(\d\.(0|5)|10.0)$/, message: 'must be between 0.0 to 10.0 stepping by .5'

  def self.valid_values
    (0..10).step(0.5)
  end

end
