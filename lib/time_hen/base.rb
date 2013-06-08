module TimeHen
   module Base

      def self.included(klass)
         klass.extend ClassMethods
      end

      
      module ClassMethods

         def hen_foo
            "foo!"
         end



         def set_time_collection(ar_collection_name, timestamp_attr, time_facts, fact_opts={})
            # delegate to set_time_collection_fact
            # each fact, do set_time_collection_fact fact, collection, 

            # each fact is a 2-element array: [:words, :sum]
            time_facts.each do |tf_arr|
               fact_name, agg_type = tf_arr 

               set_time_collection_fact( ar_collection_name, 
                     agg_type,
                     fact_name, 
                     timestamp_attr, 
                     fact_opts )
            end

         end


         # defines
         # : {agg_type}_of_{fact_name}_for_{collection_name}_in_{time_period}
         def set_time_collection_fact(collection_name, agg_type, fact_name, timestamp_attr, fact_opts={})

            time_chunk_min = fact_opts[:time_chunk_min] || :day
            time_chunk_max = fact_opts[:time_chunk_max] || :year
            time_chunks = TimeHelpers.time_chunks time_chunk_min, time_chunk_max

            time_chunks.each do |time_period_chunk|

               time_foo_sym = "#{agg_type}_of_#{fact_name}_for_#{collection_name}_in_#{time_period_chunk}".to_sym 
               define_method(time_foo_sym) do |time_str|
                  time_range = TimeHelpers.send("in_#{time_period_chunk}", time_str )
                  self.send( collection_name ).              # e.g. tweets 
                     where(timestamp_attr => time_range).    # e.g. created_at: 2013-01-01...2014-01-01
                     send(agg_type, fact_name)               # e.g. :sum, :word_count
               end

               # method defined: sum_of_word_count_for_tweets_in_year(time_str)
            end 

            # create methods...?

            # build out timespan of dynamic methods
            # get_range_from( :day, :year )
            # =>  define_method :lalalal do |args|

            #        self.calculate_foo_of_baz_across_epoch_using_time_att fact_name, collection, :year, :time_att
            #   fact_name_OF_collection_in_:year_timehen
            #   fact_name_OF_collection_in_:month_timehen
            #   fact_name_OF_collection_in_:day_timehen
            #   
         end
      end 


      def i_foo
         "instance foo"
      end

   end
end


