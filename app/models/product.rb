class Product < ApplicationRecord
  after_create :send_notification
  has_one_attached :product_image

  def send_notification
    p'Mail sended to all user for new product'
    byebug
  end
end
