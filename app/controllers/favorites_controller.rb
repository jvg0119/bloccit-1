class FavoritesController < ApplicationController

  def create
    post = set_post
    favorite = current_user.favorites.build(post: post)

    authorize favorite

    if favorite.save
      flash[:notice] = "Favorited Post"
      redirect_to [post.topic, post]
    else
      flash[:error] = "Unable to favoirte post.  Please try again."
      redirect_to [post.topic, post]
    end
  end

  def destroy
    post = set_post
    favorite = current_user.favorites.find(params[:id])

    authorize favorite

    if favorite.destroy
      flash[:notice] = "Removed from favoirtes"
      redirect_to [post.topic, post]
    else
      flash[:notice] = "Unable to remove from favorites.  Please try again."
      redirect_to [post.topic, post]
    end
  end

  private

  def set_post
    post ||= Post.find(params[:post_id])
  end

end
