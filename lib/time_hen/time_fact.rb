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
      # method defined: sum_of_word_count_for_tweets_in_year(time_str)
      def define!    

         a = atts_binding_hash

         time_foo_sym = "#{a[:aggregation]}_of_#{a[:collection_foo]}_for_#{a[:collection_name]}_in_#{a[:time_chunk]}".to_sym 

         puts "Timefoosym: #{time_foo_sym}\n"

         a[:owner].define_method(time_foo_sym) do |time_str|
            # time_range, e.g. #in_year, #in_month, #in_hour
            time_range = TimeHelpers.send("in_#{a[:time_chunk]}", time_str )

            self.send( a[:collection_name] ).              # e.g. tweets 
                        where(a[:timestamp_attr] => time_range).    # e.g. created_at: 2013-01-01...2014-01-01
                        send(a[:aggregation], a[:collection_foo])               # e.g. :sum, :word_count
      
         end         
      end


      private 
      
      def atts_binding_hash 
         [:owner, :collection_name, :aggregation, :collection_foo, :timestamp_attr, :time_chunk].inject({}) do |hsh, foo|
            hsh[foo] = instance_eval("@#{foo}")
            hsh
         end
      end



   end
end

