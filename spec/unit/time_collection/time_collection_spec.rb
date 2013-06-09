require 'spec_helper'

describe TimeCollection do 

   before(:each) do 


       @time_coll_params = {
               collection_name: "widgets",
               collection_timestamp_attr: :made_at,
               fact_names: [[:price, :sum]], 
               fact_options: {  time_chunk_min: :day,
                               time_chunk_max: :year
                            } 
            }
      @time_collection =  TimeCollection.new(@time_coll_params)
      
   end

   context 'initialization and attributes' do 
      it 'should expose #collection_name attribute' do 
         # to_sym is performed automatically
         expect(@time_collection.collection_name).to eq :widgets 
      end

      it 'should expose #collection_timestamp_attr attribute' do 
         expect(@time_collection.collection_timestamp_attr).to eq :made_at 
      end

      it 'should expose #fact_names attribute' do 
         expect(@time_collection.fact_names.first).to eq [:price, :sum] 
      end

      it 'should have #fact_count 0 before set_time_facts!' do 
         expect(@time_collection.fact_count).to eq 0
      end

      it "should have no #owner if not passed in params" do 
         expect(@time_collection.owner).to be nil

      end

      context 'enumerating time chunks' do 
         it 'should expose #time_chunk_min attribute' do 
            expect(@time_collection.time_chunk_min).to eq :day
         end

         it 'should expose #time_chunk_max attribute' do 
            expect(@time_collection.time_chunk_max).to eq :year
         end

         it 'should expose #time_chunks method' do 
            expect(@time_collection.time_chunks).to eq [:day, :month, :year]
         end
      end

      
   end


   context 'class modification' do 
      before(:each) do 
         class SpecPerson; end
         SpecPerson.send :include, TimeHen::Base
         @time_collection = TimeCollection.new( @time_coll_params.merge owner: SpecPerson)
      end  

      it 'should have an :owner' do  
         expect(@time_collection.owner).to eq SpecPerson
      end


   end

end