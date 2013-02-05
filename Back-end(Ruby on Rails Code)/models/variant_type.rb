class VariantType < ActiveRecord::Base

  has_many  :variants

  validates_presence_of     :name
  validates_uniqueness_of   :name

  def self.for_select
    [['n/a', nil]] + VariantType.all.map { |vt| [vt.name, vt.id] }
  end

end
