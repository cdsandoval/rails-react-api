# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :order_items
  accepts_nested_attributes_for :order_items

  after_save :calculate_price, unless: ->(order) { order.total_price? }

  private

  def calculate_price
    order_items_list = order_items.includes(:menu_item)
    result = order_items_list.reduce(0) do |sum, order_item|
      sum + order_item.menu_item.price * order_item.quantity
    end
    update(total_price: result)
  end
end
