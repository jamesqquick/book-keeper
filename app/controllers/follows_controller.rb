class FollowsController < ApplicationController 
    
  before_action :follow_params, only: [:create, :destroy]
  
  def create
    @follow = User.find(params[:follow][:follable_id])
    current_user.follow(@follow)
    flash[:success] = "Followed #{@follow.username}"
    redirect_to friends_path
  end
  
  def destroy
    @stop_following = User.find(params[:follow][:follable_id])
    current_user.stop_following(@stop_following)
    flash[:success] = "Unfollowed #{@stop_following.username}"
    redirect_to friends_path
  end
  private
  
    def follow_params
      params.require(:follow).permit(:follable_id)
    end
    
end