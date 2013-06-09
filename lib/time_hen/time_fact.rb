module TimeHen
   class TimeFact

      def initialize(owner, collection_name, aggregation, collection_foo, timestamp_attr, time_chunk)
         @owner_class = owner 
         @collection_name = collection_name
         @aggregation = aggregation
         @collection_foo = collection_foo 
         @timestamp_attr = timestamp_attr
         @time_chunk = time_chunk 
      end


      def name
         "#{@aggregation}_of_#{@collection_foo}_for_#{@collection_name}_in_#{@time_chunk}".to_sym 

      end

      # command: modifies the @owner_class to have a new fact
      # method defined: sum_of_word_count_for_tweets_in_year(time_str)
      def define!    

         __time_fact = self 
         time_foo_sym = self.name.to_sym

         @owner_class.define_method(time_foo_sym) do |time_str|
            # time_range, e.g. #in_year, #in_month, #in_hour

            # e.g. tweets 
            collection_scope = __time_fact.build_collection_scope_base(self)     

            # e.g. created_at: 2013-01-01...2014-01-01
            collection_scope = __time_fact.build_time_scope(collection_scope, time_str)

            # e.g. :sum, :word_count
            return __time_fact.calculate_aggregated_scope(collection_scope)
         end         

      end





      # TK: this is obviously a smell, to avoid the messiness of closures in the define! method
      # I might have made a huge mistake...

      # returns some_instance.send(:collection_name)
      #   where :some_instance is @owner_class.instance 
      # e.g. my_author.books



      def build_collection_scope_base(some_instance)
         some_instance.send(@collection_name).scoped
      end

      def build_time_scope(a_scope, time_str)
         time_range = TimeHelpers.send("in_#{@time_chunk}", time_str )

         a_scope.where( @timestamp_attr => time_range ).scoped 
      end

      def calculate_aggregated_scope(a_scope)
         a_scope.send( @aggregation, @collection_foo)                
      end




#      private 
      
 #     def atts_binding_hash 
 #        [:owner, :collection_name, :aggregation, :collection_foo, :timestamp_attr, :time_chunk].inject({}) do |hsh, foo|
 #           hsh[foo] = instance_eval("@#{foo}")
#
#            hsh
 #        end
 #     end




   end
end

