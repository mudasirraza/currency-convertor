class CreateQueSchedulerSchema < ActiveRecord::Migration[6.1]
  def change
    Que::Scheduler::Migrations.migrate!(version: Que::Scheduler::Migrations::MAX_VERSION)
  end
end
