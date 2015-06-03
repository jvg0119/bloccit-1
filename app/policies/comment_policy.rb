class CommentPolicy < ApplicationPolicy

  def destroy?
    user.present? && (record.user == user || user.admin? || user.moderator?)
  end

  # why did the assignment specify that I define new and create methods when I could just use the methods provided in ApplicationPolicy 
  def create?
    user.present?
  end

  def new?
    create?
  end
end