# How to start daemons with helpers

Some descriptors need to be closed, especially when using debconf (or send `db_stop` command before running the daemon)

      start() {
        # Run the program!
        # centos
        if [ -f "/etc/init.d/functions" ] ; then
          . /etc/init.d/functions
          daemon --pidfile $pidfile ${name} run ${process_name} >> /var/log/${name}/${process_name}-PROCESS_NUM.log 2>&1 &
          echo $! > $pidfile
        else
          start-stop-daemon --background --make-pidfile --pidfile $pidfile --start --startas /bin/bash -- -c "exec ${name} run ${process_name} >> /var/log/${name}/${process_name}-PROCESS_NUM.log 2>&1"
        fi

        echo "${full_process_name} started."
        return 0
      }
