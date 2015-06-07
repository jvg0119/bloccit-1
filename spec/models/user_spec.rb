require 'rails_helper'

describe User do
  
  include TestFactories

  describe "#favorited(post)" do

    before do
      @post = associated_post
      @post_2 = associated_post
      @user = authenticated_user
    end

    it "returns 'nil' if the user has not favorited the post" do
      expect( @user.favorited( @post ) ).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      favorite = Favorite.create(user: @user, post: @post)
      expect( @user.favorited( @post ) ).to eq(favorite)
    end

    it "returns `nil` if the user has favorited another post" do
      favorite = Favorite.create(user: @user, post: @post)
      expect( @user.favorited( @post_2 ) ).to be_nil
    end
  end
end