require 'spec_helper'

describe TimeHen::TimeHelpers do


   context "time chunks" do 

      it "should accept a time chunk from min to max" do 
         expect( TimeHelpers.time_chunks :day, :year ).to eq [:day, :week, :month, :year]
      end

      it "should raise an error when max is less than min" do 
         expect{ TimeHelpers.time_chunks :year, :day }.to raise_error 
      end

      it "should allow the use of one argument" do 
         expect( TimeHelpers.time_chunks :month, :year ).to eq [:month, :year]
      end

      it "should return one element if time chunk is the same" do 
         expect( TimeHelpers.time_chunks :month, :month ).to eq [:month] 
      end

   end


   context "discrete time periods" do 
      it "should calculate :in_year" do 
         d1 = Time.new 2012
         d2 = Time.new( 2013 )

         expect( TimeHelpers.in_year(2012) ).to eq( d1...d2 )
      end
   end

end
