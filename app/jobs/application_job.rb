class ApplicationJob < Que::Job
  @queue_name = 'default'
end
