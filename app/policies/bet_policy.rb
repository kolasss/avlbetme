class BetPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    true
  end

  def create?
    new?
  end

  def edit?
     user.admin? || record.has_user?(user)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def stop?
    edit?
  end

  def finish?
    stop?
  end

  def cancel?
    edit?
  end
end
