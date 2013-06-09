module TimeHen
   module Base

      def self.included(klass)
         include ClassLevelInheritableAttributes
         cattr_inheritable :time_collections, :time_facts   
         klass.extend ClassMethods

      end

 
      
      module ClassMethods
         # Command: delegates to #set_time_collection
         def set_default_time_collections(ar_collection_name) 
         end

         # Command: delegates to #set_time_collection_fact for each element in :time_facts
         def set_time_collection(time_col_hsh)
            
            time_col_hsh = time_col_hsh.merge owner: self 
            
            # TODO smell
            @time_collections ||= []

            t_collection = TimeCollection.new(time_col_hsh)
            @time_collections << t_collection
            t_collection.set_time_facts!

            return t_collection 
         end

         def hen_foo
            "foo!"
         end
      end 


############
####### Instance Methods
     #################  

      def i_foo
         "instance foo"
      end



   end
end


