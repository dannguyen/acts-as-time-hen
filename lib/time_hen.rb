require "time_hen/version"
require 'time_hen/base'
require 'time_hen/aggregate_methods'
require 'time_hen/query_builder'
require 'time_hen/time_helpers'

require 'chronic'

module TimeHen



end


if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send :include, TimeHen::Base
end


=begin 
      def act_as_time_hen
         raise "don't do this"
          include TimeHen::Base
         
#         include TimeHen:QueryBuilder
#         include TimeHen:AggregateMethods
#         yield @defaults_config if block_given?

         return true
      end



=end 