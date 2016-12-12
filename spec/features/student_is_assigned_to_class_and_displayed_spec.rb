feature 'Student is added to class and then displayed to the gradebook' do
  include ClassPeriodHelper

  scenario 'successfully' do
    student = FactoryGirl.create(:student, first_name: 'foo', last_name: 'bar')
    course = FactoryGirl.create(:course_with_units_and_assignments)
    class_period = FactoryGirl.create(:class_period_with_teachers, course: course)
    login_as(class_period.teachers.first, scope: :user)

    visit class_periods_path
    expect(page).to have_css '.class-period a', text: "#{class_period.course.name}"

    click_on 'manage students'
    select student.display_name, from: 'class_period_student_ids'
    click_on 'Update Class period'

    expect(page).to have_select('class_period[student_ids][]', selected: "#{student.display_name}")
    class_assignments = ClassAssignment.where(student_class: StudentClass.find_by(student: student))
    class_assignments.first.points_earned = 4
    class_assignments.first.save!
    class_assignments.second.points_earned = 7
    class_assignments.second.save!


    visit gradebook_path class_period
    course.assignments.each do |assignment|
      expect(page).to have_css '.gradebook th.assignments-header', text: assignment.name
    end
    #save_and_open_page
    expect(page).to have_css '.student input.points_earned[value="4"]'
    expect(page).to have_css '.student input.points_earned[value="7"]'

  end
end