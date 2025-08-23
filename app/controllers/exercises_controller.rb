class ExercisesController < ApplicationController
  def index
    @exercises = policy_scope(Exercise)
    @exercises = Exercise.all.order(:name)
  end
end
