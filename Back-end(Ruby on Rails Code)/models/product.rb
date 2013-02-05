class Product < ActiveRecord::Base

  has_attached_file       :photo
  has_attached_file       :logo
  has_attached_file       :related_item
  has_attached_file       :map

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :badges
  has_many                :product_traits, dependent: :destroy
  has_many                :traits, through: :product_traits
  has_many                :variants, dependent: :destroy

  accepts_nested_attributes_for :product_traits, reject_if: lambda { |a| a[:value].blank? && a['_destroy'].blank? }, allow_destroy: true

  validates_presence_of             :name
  validates_uniqueness_of           :name
  validates_numericality_of         :order, allow_nil: true
  validates_attachment_content_type :photo,         content_type: [ 'image/jpeg', 'image/gif', 'image/png' ]
  validates_attachment_size         :photo,         less_than: 500.kilobytes
  validates_attachment_content_type :logo,          content_type: [ 'image/jpeg', 'image/gif', 'image/png' ]
  validates_attachment_size         :logo,          less_than: 200.kilobytes
  validates_attachment_content_type :related_item,  content_type: [ 'image/jpeg', 'image/gif', 'image/png' ]
  validates_attachment_size         :related_item,  less_than: 200.kilobytes
  validates_attachment_content_type :map,           content_type: [ 'image/jpeg', 'image/gif', 'image/png' ]
  validates_attachment_size         :map,           less_than: 200.kilobytes

  scope :with_variants, joins(:variants).group('products.id')

  def new_product_traits
    Trait.all - self.traits
  end

  def self.for_select
    Product.with_variants.map { |p| p.name }
  end

end



