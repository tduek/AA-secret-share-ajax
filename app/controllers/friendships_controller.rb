class FriendshipsController < ApplicationController
  before_filter :require_current_user!

  def create
    @friendship = Friendship.new(params[:friendship])
    @friendship.out_friend_id = current_user.id
    @friendship.save!

    redirect_to users_url
  end
end
