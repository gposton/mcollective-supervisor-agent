module MCollective
  module Util
    module Service
      class SupervisorService<Base
        def stop
          %x{supervisorctl stop #{@service}}
          sleep 1
          state
        end

        def start
          %x{supervisorctl start #{@service}}
          sleep 1
          state
        end

        def restart
          %x{supervisorctl restart #{@service}}
          sleep 1
          status
        end

        def status
          state[:status]
        end

        def state
          msg = %x{supervisorctl status #{@service}}
          {:status => msg.split("\s")[1].downcase, :msg => msg}
        end
      end
    end
  end
end
