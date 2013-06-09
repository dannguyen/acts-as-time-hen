require 'spec_helper'

describe TimeHen::TimeHelpers do


   context "time chunks" do 
      it "should accept a time chunk from min to max" do 
         expect( TimeHelpers.time_chunks :day, :year ).to eq [:day, :month, :year]
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


   context 'time periods' do 
      describe '#in_year' do 
         it "should calculate #in_year" do 
            d1 = DateTime.new 2012
            d2 = DateTime.new 2013 

            expect( TimeHelpers.in_year(2012) ).to eq( d1...d2 )
         end
      end

      describe '#in_month' do 
         it 'should calculate one month interval' do 
            expect( TimeHelpers.in_month("2012-12")).to eq DateTime.new(2012,12)...DateTime.new(2013,1)
         end

         it 'should fail if no month parameter given' do 
            expect{ TimeHelpers.in_month("2012")}.to raise_error ArgumentError
         end
      end

      describe '#in_hour' do 
         it 'should calculate one month interval' do 
            hr1 = DateTime.new(2012,12,31,23)
            hr2 = DateTime.new(2013,1)
#            expect( TimeHelpers.in_hour("2012-12-31 23:48")).to eq hr1..hr2
         end
      end

   end
end
