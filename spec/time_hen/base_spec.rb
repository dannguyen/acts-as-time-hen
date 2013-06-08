require 'spec_helper'

describe TimeHen::Base, skip: true  do

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










   context "specifying a time collection", skip: true do

      before(:each) do 
         class Author 
            set_time_collection( :books, :published_at, [
                  [:word_count, :sum]
               ],{
                  time_chunk_min: :week,
                  time_chunk_max: :year
               }
            )
         end                  

         @author = Author.create
         @author.books << Book.create( title: "A", word_count: 50, published_at: "2012-01-01")
         @author.books << Book.create( title: "B", word_count: 77, published_at: "2012-02-01")
         @author.books << Book.create( title: "C", word_count: 99, published_at: "2013-02-01")
      end

      describe "aggregation types" do 
         it "can calculate a :sum" do 
#            expect(@author.books.sum(:word_count)).to eq 226
            expect( @author.sum_of_word_count_for_books_in_year("2012") ).to eq 127
            expect( @author.sum_of_word_count_for_books_in_month("2012-02") ).to eq 50
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