module TimeHen
   class TimeFact

      def initialize(owner, collection_name, aggregation, collection_foo, timestamp_attr, time_chunk)
         @owner = owner 
         @collection_name = collection_name
         @aggregation = aggregation
         @collection_foo = collection_foo 
         @timestamp_attr = timestamp_attr
         @time_chunk = time_chunk 
      end


      # command: modifies the @owner to have a new fact
      def define!    
         time_foo_sym = "#{agg_type}_of_#{fact_name}_for_#{collection_name}_in_#{time_chunk}".to_sym 
         @owner.define_method(time_foo_sym) do |time_str|
            # time_range, e.g. #in_year, #in_month, #in_hour
            time_range = TimeHelpers.send("in_#{@time_chunk}", time_str )

            self.send( @collection_name ).              # e.g. tweets 
                        where(@timestamp_attr => time_range).    # e.g. created_at: 2013-01-01...2014-01-01
                        send(@aggregation, @collection_foo)               # e.g. :sum, :word_count
         end
            # method defined: sum_of_word_count_for_tweets_in_year(time_str)
      end

   end
end

