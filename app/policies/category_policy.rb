class CategoryPolicy < ApplicationPolicy

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    user.present? && (user.admin? || user.superadmin?)
  end

  def update
    user.present? && (user.admin? || user.superadmin?)
  end

  def destroy?
    user.present? && (user.admin? || user.superadmin?)
  end
    
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
