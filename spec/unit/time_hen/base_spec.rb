require 'spec_helper'

describe TimeHen::Base, skip: false  do

      before(:each) do 
         BaseAuthor = Author.dup
      end

      after(:each) do 
         Author = BaseAuthor
      end

      context "Mixin" do 
         before(:each) do 
            @author = Author.create name: 'Jack'
         end

         describe "fun" do 
            it "acts like a time hen" do 
               @author.class.should == Author
               @author.class.hen_foo.should == "foo!"

               expect(@author.i_foo).to eq "instance foo"
            end
         end
      end #/mixin







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

      context 'auto-generated #sum methods' do 
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

      context 'auto-generated #count methods provided by default', skip: true do 
         describe '#count_for_books_in_TIME' do 
            it '#in_year' do 
               expect( @author.sum_of_count_for_books_in_year("2012") ).to eq 2
            end
            
            it '#in_month' do 
               expect( @author.sum_of_count_for_books_in_month("2012-01") ).to eq 1
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