class Job < ApplicationRecord
  validates :sub_heading, length: { maximum: 100 }, allow_blank: true

  def benefit_list
    benefits.to_s.split(/[\n,]+/).map(&:strip).reject(&:blank?)
  end
end
