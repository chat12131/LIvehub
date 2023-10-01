class MembersController < ApplicationController
  def index
    @members = Member.where(artist_id: params[:artist_id])
    render json: @members
  end
end
