class CreatePlans < ActiveRecord::Migration
  def up
    say 'creating table'
    create_table :plans do |t|
      t.string :title
      t.text :supplies
      t.text :cutlist
      t.text :instructions
      t.text :steps
    end
    say 'table created'
  end

  def down
    drop_table :plans
  end
end
