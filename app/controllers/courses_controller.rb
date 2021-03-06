class CoursesController < ApplicationController
  def index
    @courses = Course.all.includes(:units)
  end

  def show
    @course = Course.find(params[:id])
    @units = @course.units.includes(:assignments)
  end

  def new
    @course = Course.new
  end

  def create
    Course.create!(course_params)
    redirect_to courses_path
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      redirect_to courses_path
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course)
          .permit(:name, :year)
  end

end
