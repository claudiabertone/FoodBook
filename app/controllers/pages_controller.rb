class PagesController < ApplicationController
  def home
    @post = current_user.posts.build if signed_in?
    @feed_items = current_user.feed.paginate(page: params[:page]) if signed_in?
    @recipes_all = Recipe.first(8)
    @recipes_suggested=Recipe.first(1)
    @recipes_day=Recipe.find(2)
    @user=User.find(1)
  end

  def about
  end

  def contact
  end

  def faq
  end
end
