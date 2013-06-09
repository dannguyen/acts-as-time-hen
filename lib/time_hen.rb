require "time_hen/version"
require 'time_hen/base'
require 'time_hen/time_collection'
require 'time_hen/time_fact'

require 'time_hen/aggregate_methods'
require 'time_hen/query_builder'
require 'time_hen/time_helpers'

#require 'active_support/core_ext/numeric'

require 'chronic'

Dir.glob(File.join( File.dirname(__FILE__), 'vendor', '**', '*.rb')).each do |rbfile|
   require_relative rbfile 
end



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