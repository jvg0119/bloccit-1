class TopicPolicy < ApplicationPolicy
  
  def index?
    true
  end

  def show?
    record.public? || user.present?
  end

  def create?
    user.present? && user.admin?
  end

  def update?
    create?
  end

end