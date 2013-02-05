class Trait < ActiveRecord::Base

  has_many :traits
  has_many :products, through: :product_traits

  validates_presence_of     :name
  validates_uniqueness_of   :name
  validates_numericality_of :order, allow_nil: true

end
