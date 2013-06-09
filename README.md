# TimeHen

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'acts-as-time-hen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts-as-time-hen

## Usage


# Acts as Time Hen

An Extraction:


module TimeHen

TimeEgg


## The contract between parent object (Time Hen) and collection

### The collection object must
* have an attribute with what is specified under attr_timestamp:
* must respond to each of the facts OR each of its members must respond to the call

* And each of the fact_types expect that the responding methods return:
      sum: number
      list: an array
      collection: a key_store with values as numbers
      count: integer, TimeEgg simply sends :size message to collection
      rate: N/A, TimeEgg calculates rate by dividing collection size by epoch size
      average: A number that represents a fractional value; TimeEgg stores collection size as a denominator
      

### The TimeHen object must
* return a collection object for every specified collection
* must know the attr_timestamp value for its child
* must have a has_many relationship to the collection
* must specify the time_chunk sizes

Every factual query can be broken down as the following:

{reciever}.{fact_type}_of_{child object method}_for_{child_collection}_in_{some_time_period}_timehen(*args)

entity.sum_of_word_count_for_tweets_in_past_7_days_timehen 
   equates to:
   entity.tweets.
      where(timestamp > Time.now - 7.days)
      sum(:&word_count)
   
   
   
def TimeHen.generate_epochs

end

def TimeHen.calculate_foo_over_epoch(t1, t2, reciever, egg_foo, agg_foo, timestamp_att)

   collection = reciever.send egg_foo
   time_filtered_collection = collection.where(timestamp_att between t1, t2)
   
   # aggregate or manually calculate
   time_filtered_collection.send agg_foo
end





Defined in Entity
but 

Entity      
   collections:
      tweets: # expects Entity has_many tweets to be defined
         attr_timestamp: :created_at
         time_chunk_min: :day
         time_chunk_max: :year
         facts:
            word_count: sum   # sum_of_word_count
            web_links_: list # list_of_web_links
            tweets: rate # rate_of_tweets, assumes that "tweets" is a collection
            replies: rate # rate_of_replies, replies must be defined
            replies_with_a_laugh: list # rate_of_replies_with_a_laugh ;; replies of laugh must be defined, must return a collection

      web_pages:
         facts:
            word_count: 
      

         
Company
   collections:
      entities:
         inherited: :tweets,
            except: []
            prefix: false
            
      tweets:
         inherit: from: entities, except: :web_links_
            
            



TimeEgg.where x_dimension_id: 'Delta', time_epoch: 'year', 


t.timestamp = :created_at
t.min_time_chunk = :days || MIN_TIME_CHUNK
t.max_time_chunk = :years || MAX_TIME_CHUNK
 

tweets.tm_word_count 
tweets.tm_entities
tweets.tm_rate





## Use cases

### Sum character count for tweets in the year 2010

   tweets = Tweet.where year: 2010
   tweets.sum :&character_count
   
   e.g. Tweet.sum_of_character_count_in_year_tmetric(2010)
   
   ** database record:
      fact_name: character_count
      fact_type: sum  # redundant?
      x_dimensionable: "ALL"
      x_dimensionable_id: "ALL"
      time_key: '2010'
      time_epoch: 'year'
      time_zone: GMT 
      divisor: nil
      time_start: 2010-01-01 00:00:00
      time_end: 2010-12-31 00:00:00
      num_value: 999827323
      hash_value: nil   
   
### Sum character count, Tweets, all time
   Tweet.all.sum(character_count)
   
   => Tweet.sum_of_character_count_tmetric
   
   ** database record:
      fact_name: character_count
      fact_type: sum
      x_dimensionable: "ALL"
      x_dimensionable_id: "ALL"
      time_key: 'ALL'
      time_epoch: 'days' 
      divisor: nil
      time_start: (earliest record)
      time_end: (latest_record)
      num_value: 999827323
      text_value: nil
      
### Rate of tweets, all time
   tweets = Tweet.all 
   tweets.count / (tweets.latest_date - tweets.earliest_date)
   
   => Tweet.rate_of_tweets_tmetric
   
   ** database record:
      fact_name: tweets
      fact_type: rate
      x_dimensionable: "ALL"
      x_dimensionable_id: "ALL"
      time_key: 'ALL'
      time_epoch: 'days' 
      divisor: nil
      time_start: (earliest record)
      time_end: (latest_record)
      num_value: 0.3456
      hash_value: nil
   
   
   
   
### Linked to websites from tweets by Ev Williams on January 2012

   User.find('ev').tweets
      .where(timestamp: "2012-12")
      .website_links
   

   => User.find('ev').list_of_website_links_within_tmetric("2012-12")
   
   ** database record
      fact_name: website_links
      fact_type: list
      x_dimension: "User"
      x_dimension_id: "ev"
      time_key: "2012-12"
      time_epoch: 'month'
      divisor: nil
      time_start: 2012-12-01
      time_end: 2012-12-31
      num_value: 0
      hash_value: {value: [google.com, yahoo.com, twitter.com]}
      
 
### List of monthly sums of tweet word count for the year 2008 for the user Ev Williams

   # TK TK t
   User.find('ev').sum_of_word_count_for_tweets_in_year("2008").by_month.


### Average cussword per tweets by Dan Nguyen in 2009

   t = User.find('dancow').tweets.cusswords


      
   
   
   

   
   
###
