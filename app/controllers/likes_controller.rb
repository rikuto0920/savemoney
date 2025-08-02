class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @student = Student.find(params[:student_id])
    current_user.likes.create(student: @student)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  def destroy
    @student = Student.find(params[:student_id])
    like = current_user.likes.find_by(student_id: @student.id)
    like.destroy if like

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back(fallback_location: root_path) }
    end
  end
end
