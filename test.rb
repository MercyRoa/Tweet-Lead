
replies = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,30]
employees = ['A','B']
threads = []
mutex = Mutex.new

employees.each do |e|
  threads << Thread.new {
    until replies.empty?
      to_send = []
      mutex.synchronize do
        to_send = replies.slice!(0..4) 
      end
      puts "#{e} --> #{to_send.to_s}"
      sleep 1
    end
  }
end

puts "    ...after new...   "
threads.each { |t| t.join }
