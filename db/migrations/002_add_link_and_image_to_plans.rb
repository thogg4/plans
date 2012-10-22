class AddLinkAndImageToPlans < ActiveRecord::Migration
  def change
    change_table :plans do |t|
      t.string :link
      t.string :image
    end
  end
end
