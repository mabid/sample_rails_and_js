class Variant < ActiveRecord::Base

  belongs_to  :product
  belongs_to  :variant_type
  has_many    :order_items

  validates_numericality_of :variant_type_id, allow_nil: true
  validates_numericality_of :retail_cad, :retail_usd, :wholesale_cad, :wholesale_usd
  validates_presence_of     :sku
  validates_uniqueness_of   :sku
  validates_numericality_of :cost, :on_hand, :weight, :height, :width, :depth, allow_nil: true
  validates_uniqueness_of   :variant_type_id, scope: :product_id
  validate                  :validate_variant_type


  def validate_variant_type
    if self.variant_type == nil && variant = Variant.find_by_product_id(self.product_id)
      unless variant == self
        errors[:base] << 'Product must have a variant type as it has other variants'
      end
    end
  end


  def self.based_on_product_for_select
    Variant.all.map { |v| { id: v.id, product_id: v.product.id, product_name: v.product.name, name: (v.variant_type ? v.variant_type.name : 'No variant types to select') } }
  end

  def price
    retail_cad
  end

end
