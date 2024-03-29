module TimeHen
   class TimeCollection

      DEFAULT_FACT_AGGREGATIONS = [:count]
      attr_reader :collection_name, :collection_timestamp_attr, :fact_names,
         :time_chunk_max, :time_chunk_min, :time_chunks, :owner 

      def initialize(params)
         @owner = params[:owner]
         @collection_name = params[:collection_name].to_sym
         @collection_timestamp_attr = params[:collection_timestamp_attr].to_sym

         @fact_names = []
         @facts = []
         
         params[:fact_names].each do |arr|
            if arr.is_a?(Array)
               @fact_names << arr 

               ## add default fact aggregations
               DEFAULT_FACT_AGGREGATIONS.each do |dfname|
                  @fact_names << [arr[0], dfname]
               end
            end
         end





         opts = params[:fact_options]

         @time_chunks = TimeHelpers.time_chunks(
               (opts[:time_chunk_min] || TimeHelpers::MIN_CHUNK),
               (opts[:time_chunk_max] || TimeHelpers::MAX_CHUNK)
             )

         @time_chunk_min = @time_chunks.first
         @time_chunk_max = @time_chunks.last


      end 

      def fact_count
         @facts.count
      end


      # expects @owner to have been set
      # command: for each fact_name and time_chunk, create and #define! new TimeFact
      def set_time_facts!

         @fact_names.each do |arr|
            fact_foo, fact_agg = arr 

            @time_chunks.each do |chunk|
               fact = TimeFact.new(
                           @owner, 
                           @collection_name, 
                           fact_agg, 
                           fact_foo, 
                           @collection_timestamp_attr,
                           chunk
                        )

               fact.define!
               puts fact.name 
               @facts << fact 
            end 
         end

         nil
      end
            
      private



   end
end

