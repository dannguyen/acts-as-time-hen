module TimeHen

   module TimeHelpers

      extend self 


      TIME_PERIOD_CHUNKS = [:hour, :day, :month, :year]
      MIN_CHUNK = TIME_PERIOD_CHUNKS.first
      MAX_CHUNK = TIME_PERIOD_CHUNKS.last

      CANONICAL_TIMECHUNKS = [
         [:year, /^\d{4}/, ->(t){ t + 1 }],
         [:month, /^\d{4}-\d{2}/, ->(t){ ((t + 1) % 13) + 1 } ],
         [:day, /^\d{4}-\d{2}-\d{2}/, ->(t){ t + (60*60*24)} ],
         [:hour, /^\d{4}-\d{2}-\d{2} \d{2}/, ->(t){ t + (60*60)} ]
      ]

      def time_chunks(min_chunk, max_chunk=MAX_CHUNK )
         _min = TIME_PERIOD_CHUNKS.index min_chunk
         _max = TIME_PERIOD_CHUNKS.index max_chunk

         raise ArgumentError if _max < _min

         return TIME_PERIOD_CHUNKS[_min.._max]
      end



   
      def in_time_interval(timeval, time_chunk_sym)
         
         # e.g. :day => 2
         time_place_idx = CANONICAL_TIMECHUNKS.index{|a| a[0] == time_chunk_sym }
         # e.g. :day => /^\d{4}-\d{2}-\d{2}/
         time_place_regex = CANONICAL_TIMECHUNKS[time_place_idx][1]
         time_place_increment = CANONICAL_TIMECHUNKS[time_place_idx][2]

         timestr = timeval.to_s
         raise ArgumentError, 
                  "#{time_chunk_sym} must have pattern: #{time_place_regex}"  if timestr !~ time_place_regex
         

         timeparts = timestr.split(/:| |-/)[0..time_place_idx].map{|t| t.to_i}

         t1 = DateTime.new(*timeparts)

         t2 = case time_chunk_sym
         when :year
            DateTime.new(timeparts[0] + 1)
         when :month 
            t1 >> 1
         when :day 
            t1 + 1 
         when :hour 
            t1 + 1/60.0
         end

         return t1...t2
      end



      CANONICAL_TIMECHUNKS.map{|a| a[0]}.each do |t|
         define_method("in_#{t}".to_sym) do |timestr|
            in_time_interval(timestr, t)
         end
      end

      private 

      def twixt(time_1, time_2)
      end

      # timestring is something like: "2012" or "2012-01" or "2015-03-12 03:09"
#      def to_mytime(timestring)
#         args = timestring.split(/:| |-/)
#         return Time.new *args
#      end



   end
end