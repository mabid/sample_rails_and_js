class User < ActiveRecord::Base

  acts_as_authentic do |config|
    config.require_password_confirmation = false

    # TODO - remove minimum password config option after site is launched and final migration of users has been completed
    # Note: minimum password should be removed after we go live -- set to 0 for database migration purposes
    # config.merge_validates_length_of_password_field_options({minimum: 0})
    
  end

  has_many :addresses, dependent: :destroy
  has_many :orders

  scope :matching_search, proc {|term|
    joins('LEFT OUTER JOIN addresses ON users.id=addresses.user_id').where(where_for_search, {:term => "%#{term}%"}).group('users.id')
  }

  def self.search_or_get_all(search, page)
    if search
      paginate page: page, conditions: ['email like ?', "%#{search}%"]
    else
      paginate page: page
    end
  end

  def self.search_for_order(term)
    users = User.matching_search(term)
    users.map {|u| 
      addresses = u.addresses.matching_search(term)
      label = u.email
      unless addresses.empty?
        label[0,0] = "#{addresses.first.name_company_address_for_display}, "
      end
      Hash[id: u.id, label: label]
    }
  end

  private

  def self.where_for_search
    "users.email like :term OR #{Address.where_for_search}"
  end
end
