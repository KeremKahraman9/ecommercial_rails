class Product < ApplicationRecord
  after_create :send_notification
  has_one_attached :product_image
  belongs_to :category
  
  validates :name, presence: true, length:{minimum:2, maximum:15}
  validates :description, presence: true, length:{minimum:100, maximum:250}
  validates :quantity, presence: true, numericality: {grater_than_or_equals: 0, less_than: 100}
  validates :price, presence: true, numericality:{grater_than: 0}
  validate  :name_start_with_a

  after_save :delete_product_after_30days
  
  def delete_product_after_30days
    ProductJob.set(wait: 1.minutes).perform_later(self)
  end

  def name_start_with_a
    if !self.name.start_with?('A')
      errors.add(:name, "should start with A letter")
    end
  end

  def send_notification
    p'Mail sended to all user for new product'
  end
end
