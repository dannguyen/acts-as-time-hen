require 'chronic'
module TimeHen

   module TimeHelpers

      extend self 


      TIME_PERIOD_CHUNKS = [:hour, :day, :month, :year]
      MAX_CHUNK = TIME_PERIOD_CHUNKS.last

      CANONICAL_TIMECHUNKS = [:year, :month, :day, :hour]

      def time_chunks(min_chunk, max_chunk=MAX_CHUNK )
         _min = TIME_PERIOD_CHUNKS.index min_chunk
         _max = TIME_PERIOD_CHUNKS.index max_chunk

         raise ArgumentError if _max < _min

         return TIME_PERIOD_CHUNKS[_min.._max]
      end


   FIGURE OUT CHRONIC WAY TO ADD A UNIT OF TIME..."2012-01-01" + 5.days      


      # returns range
      def in_year(yr)
         yr_1 = yr.to_i
         yr_2 = yr_1 + 1

         return (Time.new yr_1)...Time.new(yr_2)
      end


      # expects: "2012-01"
      def in_month(yr_mth)
         yr,mth = (yr_mth).split('-').map{|s| s.to_i}
         mth2 = mth + 1

         return [ Time.new(yr, mth), Time.new(yr_2) - 1 ]
      end



      private 

      def twixt(time_1, time_2)
      end

      # timestring is something like: "2012" or "2012-01" or "2015-03-12 03:09"
      def to_mytime(timestring)
         args = timestring.split(/:| |-/)
         return Time.new *args
      end



   end
end