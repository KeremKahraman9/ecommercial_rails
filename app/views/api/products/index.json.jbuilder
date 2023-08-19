json.products @products.each do |product|
  json.name product.name
  json.description product.description
  json.quantity product.quantity
  json.price product.price

  json.category product.category

  if(product.product_image.present?) && (product.product_image.filename != nil)
    json.product image rails_blob_url(product.product_image)
  end
end

json.message @message
json.success true