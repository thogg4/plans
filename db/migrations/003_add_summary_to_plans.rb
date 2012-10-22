class AddSummaryToPlans < ActiveRecord::Migration
  def change
    change_table :plans do |t|
      t.text :summary
    end
  end
end
