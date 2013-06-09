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


end