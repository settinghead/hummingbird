APP_ROOT = "/home/ubuntu/hummingbird"                   # application root

God.pid_file_directory = "#{APP_ROOT}/pids"     # directory to store PID files

God.watch do |w|
    w.name = "celeb_counter"
    w.interval = 5.seconds # default
    w.start = "env node #{APP_ROOT}/server.js"  # path to node.js server file
    w.stop = "env killall node"                 # stopping node explicitly
    w.start_grace = 10.seconds
    w.restart_grace = 10.seconds            
    w.log = "#{APP_ROOT}/log/celeb_counter.log"      # to enable logging

    w.start_if do |start|                       # start if condition is met
      start.condition(:process_running) do |c|  # check if process is running
        c.interval = 5.seconds
        c.running = false
      end
    end
end