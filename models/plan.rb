class Plan < ActiveRecord::Base

  sifter :plan_contains do |string|
    title.matches("%#{string}%") | supplies.matches("%#{string}%") | cutlist.matches("%#{string}%") | instructions.matches("%#{string}%") | steps.matches("%#{string}%")
  end

  def self.search(s)
    where{ sift :plan_contains, s}
  end
end
