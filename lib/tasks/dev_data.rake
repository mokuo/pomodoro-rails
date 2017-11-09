namespace :dev_data do
  desc '開発データを生成します'
  task :create, %w[user_name password] => :environment do |_task, args|
    user = User.create!(name: args.user_name, password: args.password)

    project = user.projects.create!(name: 'test project')

    task = project.tasks.create!(name: "task1", todo_on: Date.current)
    project.tasks.create!(name: "task2", todo_on: Date.current)

    2.times do |i|
      task.pomodoros.create!(box: 1)
    end

    default_project = user.projects.find_by(name: Constants::DEFAULT_PROJECT_NAME)
    default_project.tasks.create!(name: 'no project task', todo_on: Date.current)
  end
end
