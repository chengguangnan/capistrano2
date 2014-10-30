load 'deploy/assets'

namespace :rails do

  task :tail, :roles => :app do
    trap("INT") { puts 'Interupted'; exit 0; }
    puts  # for an extra line break before the host name
    run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end

  desc "Remote console"
  task :console, :roles => :app do |server|
    run_interactively "bundle exec rails console #{rails_env}"
  end

  desc "Remote dbconsole"
  task :dbconsole, :roles => :app do |server|
    run_interactively "bundle exec rails dbconsole #{rails_env}"
  end

  def run_interactively(command)
    server ||= find_servers_for_task(current_task).first
    puts "    running `#{command}` as #{user}@#{server}"
    exec %Q(ssh #{user}@#{server} -t "bash --login -c 'cd #{deploy_to}/current && #{command}'")
  end
end