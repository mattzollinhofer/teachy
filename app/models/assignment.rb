class Assignment < ActiveRecord::Base
  default_scope { order(order: :asc)  }

  has_many :class_assignments, dependent: :destroy
  belongs_to :unit, inverse_of: :assignments
  after_initialize :default_order

  def default_order
    return nil if unit.blank?
    return order if order.present?

    self.order = unit.assignments.length + 1
  end

  def class_periods
    unit.course.class_periods
  end

  def points_possible
    self[:points_possible] || 0
  end

  def stars_possible
    self[:stars_possible] || 0
  end

  validates :order, :name, presence: true
  #TODO move to student_class
  #validates :time_zone_id,
  #          allow_blank: true,
  #          inclusion: {
  #            in: ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.identifier }
  #          }

  #def late?
  #  !complete? && due_at < Date.today
  #end

  #def complete?
  #  completed_at.present?
  #end
end
