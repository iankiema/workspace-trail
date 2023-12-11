class PackageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :image_url, :price, :slug

  has_many :reservations
end
