class BodyStatsController < ApplicationController
  def create
    @body_stat = BodyStat.new(listing_params)
    raise
  end

  private
  def listing_params
    params.require(:body_stat).permit(:timestamp, :weight, :body_fat, :muscle_mass, :user_id)
  end
end
