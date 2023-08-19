class Category < ApplicationRecord

  after_save :after_saved_method
  before_save :before_saved_method
  before_destroy :before_destroy_method
  after_update :after_update_method
  def after_saved_method
    p'after_saved_method çalıştı'
  end

  def before_saved_method
    p'before_saced_method çalıştı'
  end

  def after_update_method
    p 'after_update çalıştı'
  end

  def before_destroy_method
    p'before_destroy çalıştı'
  end

end
