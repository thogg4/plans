class CreatePlans < ActiveRecord::Migration
  def up
    create_table :plans do |t|
      t.string :title
      t.text :supplies
      t.text :cutlist
      t.text :instructions
      t.text :steps
      t.string :link
      t.string :image
      t.text :summary
      t.string :source_link
    end
  end

  def down
    drop_table :plans
  end
end
