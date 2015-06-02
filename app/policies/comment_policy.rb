class CommentPolicy < ApplicationPolicy

  # why did the assignment specify that I define new and create methods when I could just use the methods provided in ApplicationPolicy 
  def create?
    user.present?
  end

  def new?
    create?
  end

end