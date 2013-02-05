desc 'extract_mentions'
task :extract_mentions => :environment do
  puts 'extract_mentions'
  Tweet.extract_mentions  
  puts 'end'
end


desc 'get_all_timeline'
task :get_all_timeline => :environment do
  puts 'get_all_timeline'
  Account.all.each {|a|  a.get_timeline }
  puts 'end'
end

desc 'send'
task :send_messages => :environment do
  puts 'send_messages'
  SheduledMessage.send_all
  puts 'end'
end

desc 'process_searches'
task :process_all => :environment do
  puts 'process_all'
  Search.all.each do |s|
    s.process 
  end
  puts 'end'
end

desc 'launch_senders'
task :launch_senders => :environment do
  puts 'launch_senders'
  Account.launch_senders
  puts 'end'
end

task :all => :environment do
  Rake::Task["extract_mentions"].execute
  Rake::Task["get_all_timeline"].execute
  Rake::Task["send_messages"].execute
  Rake::Task["process_all"].execute
  Rake::Task["launch_senders"].execute
end
