class Order < ActiveRecord::Base


  belongs_to :user
  has_many :order_items,  dependent: :destroy
  has_many :addresses,    dependent: :destroy

  before_validation(on: :create) do
    self.pay_status =   Order.pay_statuses.first
    self.order_status =  Order.order_statuses.first
    self.ship_method =  Order.ship_methods.first
    self.pay_type =  Order.pay_types.first
  end

  after_create  :create_addresses, :unless => :guest_order?

  def self.pay_statuses
    %w(Invoiced Paid)
  end

  def self.order_statuses
   ['Order Received', 'Order Processing', 'Shipped', 'Picked Up', 'Ready to Ship', 'Ready for Pickup']
  end

  def self.ship_methods
    %w(delivery pickup)
  end

  def self.pay_types
    ['Cash', 'Debit', 'Visa', 'Mastercard', 'Cheque', 'Beanstream Canada', 'Beanstream US', 'Paypal']
  end

  validates_presence_of   :user, :unless => :guest_order?
  validates_inclusion_of  :pay_status,   :in => Order.pay_statuses,   :message => "invalid must be one of (#{Order.pay_statuses.join(",")})"
  validates_inclusion_of  :order_status, :in => Order.order_statuses, :message => "invalid must be one of (#{Order.order_statuses.join(",")})"
  validates_inclusion_of  :ship_method,  :in => Order.ship_methods,   :message => "invalid must be one of (#{Order.ship_methods.join(",")})"
  validates_inclusion_of  :pay_type,     :in => Order.pay_types,      :message => "invalid must be one of (#{Order.pay_types.join(",")})"


  def user_email_for_display
    return user.email unless guest_order?
    if shipping_or_billing
      return "Guest(#{shipping_or_billing.name_and_company_for_display})".html_safe
    end
    "Guest(No Address)"
  end

  def total
    (self.order_items.map { |oi| oi.quantity * (oi.price_per_unit + oi.tax_per_unit) }.inject { |sum, oi| sum + oi }) || 0
  end

  def shipping_or_billing
    if addresses.shipping.present?
      addresses.shipping.first
    elsif addresses.billing.present?
      addresses.billing.first
    end
  end

  def create_addresses
    if self.user.addresses.shipping.present?
      shipping_address = self.user.addresses.shipping.first.dup
      shipping_address.update_attributes(user: nil, order: self)
    end
    if self.user.addresses.billing.present?
      billing_address = self.user.addresses.shipping.first.dup
      billing_address.update_attributes(user: nil, order: self)
    end
  end
end


