class Badge < ActiveRecord::Base

  has_attached_file :image
  has_and_belongs_to_many :products

  validates_presence_of             :name
  validates_uniqueness_of           :name
  validates_attachment_presence     :image
  validates_attachment_content_type :image, :content_type => [ 'image/jpeg', 'image/gif', 'image/png' ]
  validates_attachment_size         :image, less_than: 200.kilobytes
  validates_numericality_of         :order, allow_nil: true

end
