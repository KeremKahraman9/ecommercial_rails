if !@product.blank?
  json.product do
    json.name @product.name
    json.description @product.description
    json.quantity @product.quantity
    json.price @product.price

    json.category @product.category

    if @product.product_image.present? && @product.product_image.filename.present?
      json.product_image rails_blob_url(@product.product_image)
    end
    
  end
else
  json.product do
    json.name @entity.name
    json.description @entity.description
    json.quantity @entity.quantity
    json.price @entity.price

    json.category @entity.category

    if @entity.product_image.present? && @entity.product_image.filename.present?
      json.product_image rails_blob_url(@entity.product_image)
    end
    
    json.message "cacheden geldi, (show.json.jbuilder)"
  end
end