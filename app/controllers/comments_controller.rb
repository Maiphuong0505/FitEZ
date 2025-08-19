class CommentsController < ApplicationController
  def create
    @workout_session = WorkoutSession.find(params[:workout_session_id])
    @comment = Comment.new(comment_params)
    @comment.workout_session = @workout_session
    @comment.user = current_user
    authorize @comment
    if @comment.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append("comment-section", partial: "comments/comment", locals: { comment: @comment })
        end
        format.html { redirect_to workout_session_path(@workout_session), notice: "Comment added successfully" }
      end
    else
      render 'workout_sessions/show', locals: { workout_session: @workout_session, comment: @comment }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    # the merge part ensures that when you create a new comment, it is automatically associated with the correct user
    params.require(:comment).permit(:content, :workout_session_id).merge(user: current_user)
  end
end
