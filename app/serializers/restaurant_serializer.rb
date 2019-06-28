# app/serializers/restaurant_serializer.rb
class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :price_type
  has_many :menu_items, if: -> { scope && scope[:action] == :show }

  attribute :address do
    { name: object.address, latitud: object.latitud, longitud: object.longitud }
  end
  attribute :image_url do
    object.image.attached? ? Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true) : ''
  end
end
