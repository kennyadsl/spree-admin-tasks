# AdminTasks are Tasks for admin users. ToDo Notes, either for oneself or others
# They can have an object attached (Order/Product)
# They just have a short text, the actual task, a due_at due date and a boolean for done?

class AdminTask < ActiveRecord::Base
  belongs_to :user   # the one to whom this is assigned
  belongs_to :source, :polymorphic => true    # the object that needs "doing" ie order, product..


  validates :task, :presence => true
  validates :due_at, :presence => true

end
