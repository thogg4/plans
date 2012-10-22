class AddSourceLinkToPlans < ActiveRecord::Migration
  def change
    change_table :plans do |t|
      t.string :source_link
    end
  end
end
