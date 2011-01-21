class CreateAdminTasks < ActiveRecord::Migration
  def self.up
    create_table "admin_tasks", :force => true  do |t|
      t.integer "source_id"
      t.string "source_type"
      t.string "task"
      t.integer "user_id"
      t.boolean  "done" , :default => false
      t.datetime "due_at"
      t.timestamps
    end
  end

  def self.down
    drop_table :admin_tasks
  end
end
