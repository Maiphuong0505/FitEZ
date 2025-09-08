class ExercisesController < ApplicationController
  def index
    @exercises = policy_scope(Exercise)
    if params[:query].present?
      @exercises = Exercise.search_by_all_attributes(params[:query]).order(:name)
    else
      @exercises = Exercise.all.order(:name)
    end
  end
end
