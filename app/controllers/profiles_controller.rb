class ProfilesController < ApplicationController
  def show
    @profile = User.find(params[:id])
  end

  def follow
    @profile = User.find(params[:id])
    follow_body = { "follower_id" => current_user.id, "followee_id" => @profile.id }
    @follow = Follow.new(follow_body)

    respond_to do |format|
      if @follow.save
        format.turbo_stream
      else
        format.html { redirect_back fallback_location: @profile, alert: "Could not follow" }
      end
    end
  end

  def unfollow
    @profile = User.find(params[:id])
    follower_id = @profile.followers.find(current_user.id)

    @follow = Follow.find_by follower_id: follower_id

    @follow.destroy
  end
end
