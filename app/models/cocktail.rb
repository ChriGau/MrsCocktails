class Cocktail < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  # photos upload via Cloudinary and attachinary
  has_attachments :photos, maximum: 2
end
