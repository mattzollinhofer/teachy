class WelcomeController < ApplicationController
  def index
    send :"welcome_#{current_user.type.downcase}"
  end

  def welcome_teacher
    @welcome = TeacherWelcome.new(current_user)
    render 'welcome/teacher'
  end

  def welcome_student
    @welcome = StudentWelcome.new current_user
    render 'welcome/student'
  end

  def welcome_guest
    render 'welcome/guest'
  end
end
