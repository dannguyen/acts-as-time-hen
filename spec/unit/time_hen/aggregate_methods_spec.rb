require 'spec_helper'

describe TimeHen::Base, skip: false do


   context "specifying a time collection" do

      before(:each) do 
         @time_col_hsh = {
               collection_name: :books,
               collection_timestamp_attr: :published_at,
               fact_names: [[:word_count, :sum]], 
               fact_options: { time_chunk_min: :day,
                             time_chunk_max: :year}
            }

         Author.set_time_collection( @time_col_hsh )

         @author = Author.create
         @author.books << Book.create( title: "A", word_count: 50, published_at: "2012-01-01")
         @author.books << Book.create( title: "B", word_count: 77, published_at: "2012-02-01")
         @author.books << Book.create( title: "C", word_count: 99, published_at: "2013-02-01")
      end

      context 'invalid methods based on configuration' do 
         context 'time_chunks out of range' do 
            it 'should not have #in_hour'do 
               expect{ @author.sum_of_word_count_for_books_in_hour("2012-12-12 01:10:55") }.to raise_error NoMethodError
            end
         end

         context 'undefined collection names' do 
            it 'should not have #manuscripts' do 
               expect{ @author.sum_of_word_count_for_manuscripts_in_year(2012) }.to raise_error NoMethodError
            end
         end

         context 'undefined collection foo' do 
            it 'should not have #upvotes' do 
               expect{ @author.sum_of_upvotes_for_manuscripts_in_year(2012) }.to raise_error NoMethodError
            end
         end

      end


      context 'auto-generated time_fact methods' do 
         context '#sum' do 
            describe '#sum_of_word_count_for_books_in_TIME' do 
               it '#in_year' do 
                  expect( @author.sum_of_word_count_for_books_in_year("2012") ).to eq 127
               end
               
               it '#in_month' do 
                  expect( @author.sum_of_word_count_for_books_in_month("2012-01") ).to eq 50
                  expect( @author.sum_of_word_count_for_books_in_month("2012-02") ).to eq 77
               end         
            end
         end

         context '#count' do 
            describe '#count_of_books_in_TIME' do 
               it '#in_year' do 
                  expect( @author.count_of_books_in_year("2012") ).to eq 2
               end
               
               it '#in_month' do 
                  expect( @author.count_of_books_in_month("2012-01") ).to eq 1
               end  
            end
         end

         context '#collection' do 
            context 'when the method is a non-collection' do
               describe '#collection_of_titles_for_books' do 
                  it '#in_year' do 
                     expect( @author.collection_of_books_in_year("2012") ).to eq( {'A'=>1, 'B'=>1})
                  end

                  it '#in_month' do 
                     expect( @author.collection_of_books_in_month("2012-02") ).to eq( {'B'=>1})
                  end
               end
            end  
         end

          context '#list', skip: true  do 
            context 'when the method is a non-collection' do
               describe '#list_of_titles_for_books' do 
                  it '#in_year' do 
                     expect( @author.list_of_books_in_year("2012") ).to eq ['A', 'B']
                  end

                  it '#in_month' do 
                     expect( @author.list_of_books_in_month("2012-02") ).to eq ['B']
                  end
               end
            end 
         end
         


      end



      describe "skip this", skip: true do 
         it "can calculate a :count"
         it "can calculate a :rate"
         it "can calculate a :list"
         it "can calculate a :collection"
      end


      context "configuring facts", skip: true do 
         describe "time span configuration" do 
            it "should not respond to a day aggregation if :week is the min_time_chunk"
            it "should not respond to a week aggregation if :day is the max_time_chunk"
         end

         describe "attr_timestamp configuration" do 
            it "should raise a TimeHenConfigurationError if attr_timestamp not defined"
            it "should calculate an aggregation based on that attr_timestamp"
         end
      end


   end #specifying a time_collection


end