class OrderItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :variant

  before_validation do
    unless self.variant
      return
    end 
    if self.variant.variant_type
      self.variant_name = variant.variant_type.name
    end
    self.product_name = variant.product.name
    self.variant_sku = variant.sku
    self.price_per_unit = variant.retail_cad
    self.tax_per_unit = variant.retail_cad * 0
  end

  validates_presence_of     :order, :variant, :variant_sku
  validates_numericality_of :price_per_unit, :tax_per_unit
  validates_numericality_of :quantity, greater_than: 0
  validates_uniqueness_of   :variant_id, scope: :order_id, message: 'already exists for this order. Please edit order item to change quantity of this item'

  def json_with_variant_and_order
    to_json(:include => { 
      :variant => {
         :include => {
           :product => {:only => [:name, :id]} 
          }
       },
       :order =>{ :only => [:id] }
    })
  end

  def json_with_errors
    to_json(:methods => :errors )
  end

end
