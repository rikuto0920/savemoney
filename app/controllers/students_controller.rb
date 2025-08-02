class StudentsController < ApplicationController
 before_action :authenticate_user!, only: [:new, :create]    
    
def index
  @tags = Tag.all
  @students = Student.all

  # キーワード検索
  if params[:search].present?
    keyword = "%#{params[:search]}%"
    @students = @students.where("students.name LIKE ? OR daigaku LIKE ?", keyword, keyword)
  end

  # タグ検索
  if params[:tag_ids].present?
    selected_tag_ids = params[:tag_ids].select { |_k, v| v == "1" }.keys
    if selected_tag_ids.any?
      @students = @students.joins(:tags).where(tags: { id: selected_tag_ids }).distinct
    end
  end
end
  
  def new
    @student = Student.new
  end
  
  def create
    student = Student.new(student_params)
    student.user_id = current_user.id
    if student.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @student = Student.find(params[:id])
    @comments = @student.comments
    @comment = Comment.new
  end
  
  def edit
    @student = Student.find(params[:id])
  end
  
  def update
    student = Student.find(params[:id])
    if student.update(student_params)
      redirect_to :action => "show", :id => student.id
    else
      redirect_to :action => "new"
    end
  end
 
  def destroy
  student = Student.find(params[:id])
  if student.user_id == current_user.id
    student.destroy
    redirect_to action: :index
  else
    redirect_to action: :index, alert: "削除できません"
  end
end 
 
  private
  def student_params
    params.require(:student).permit(:name, :daigaku, :point, :image,:body, tag_ids: [])
  end
end