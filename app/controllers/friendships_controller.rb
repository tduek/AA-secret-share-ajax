class FriendshipsController < ApplicationController
  before_filter :require_current_user!

  def create
    @friendship = Friendship.new({ :in_friend_id => params[:user_id] })
    @friendship.out_friend_id = current_user.id
    @friendship.save!

    sleep(1)

    head :ok
  end

  def destroy
    @friendship = Friendship.where("out_friend_id = ? AND in_friend_id = ?", current_user.id, params[:user_id]).first
    @friendship.destroy

    sleep(1)

    head :ok
  end
end
