class Category < ActiveRecord::Base

  has_ancestry orphan_strategy: :rootify
  has_and_belongs_to_many :products

  validates_presence_of     :name
  validates_uniqueness_of   :name
  validates_numericality_of :menu_order, allow_nil: true

  def self.parents_for_select
    [['None', nil]] + ancestry_options(Category.scoped.arrange(order: 'name')) {|category| "#{'-' * category.depth} #{category.name}" }
  end

  def self.ancestry_options(categories, &block)
    return ancestry_options(categories){ |category| "#{'-' * category.depth} #{category.name}" } unless block_given?
    result = []
    categories.map do |category, sub_categories|
      result << [yield(category), category.id]
      result += ancestry_options(sub_categories, &block)
    end
    result
  end

end

