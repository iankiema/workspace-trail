class Package < ApplicationRecord
  has_many :reservations

  before_create :slugify

  def slugify
    self.slug = name.parameterize
  end
end
