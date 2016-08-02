class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  has_many :order_items

  default_scope { where(active: true) }

  mount_uploader :picture, PictureUploader

  validates :brand_id, presence: true
  validates :category_id, presence: true
  validates :description, presence: true, length: { maximum: 140 }
  validate  :picture_size

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
