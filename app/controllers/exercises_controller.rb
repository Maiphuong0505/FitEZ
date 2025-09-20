class ExercisesController < ApplicationController
  def index
    @exercises = policy_scope(Exercise)
    if params[:query].present?
      @exercises = Exercise.search_by_all_attributes(params[:query]).reorder(:name)
      # PgSearch applies its own ordering, which is by rank. That will take precedence unless we override it explicitly
      # To override PgSearch sorting, use #reorder instead of #order
    else
      @exercises = Exercise.all.order(:name)
    end
  end
end
