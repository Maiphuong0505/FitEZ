class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      @client = current_user unless current_user.trainer?
    end
  end
end
