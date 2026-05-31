class UserPolicy < ApplicationPolicy
  def index?
    user.manager? || user.admin?
  end

  def show?
    user.manager? || user.admin?
  end

  def update?
    user.manager? || user.admin?
  end

  def destroy?
    user.manager? || user.admin?
  end
end
