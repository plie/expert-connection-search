# README

Ruby 2.5.5



Just FYI:
1.  I have never before implemented many of the features required in this challenge, including the web scraper and the self-reflective, bi-directional self-join model. I had to learn from scratch as I worked.

2.  I implemented my own short link engine, as I am very familiar with how to build it and could throw it up in no time



Please note, in the interest of not taking too much time, I have not done everything I'd like to do. 

For further consideration:
1.  It was not totally clarified in the requirements, but it is implied that the algorithm needs to handle a potentially unlimited number of members in the path to the user. The example just shows one degree of separation.
It wasn't until I was nearly finish that I realized what you are likely wanting to see is search algorithm much like this example: https://github.com/brianstorti/ruby-graph-algorithms/blob/master/breadth_first_search/breadth_first_search.rb, where he beautifully shows using a Breadth First Search algorithm. This is very efficient and powerful and I would definitely implement something very similar if I were to invest more time. It is simple and clean.

2.  I also would implement a way to save "friend_ids" in the database for each user, in order to greatly speed up the app and drastically reduce the hits to the database, which currently are simply unacceptable. I would also have an "after_create" callback on the "Friends" model to update this data for both users who just mutually matched.

3.  I started the process of implementing a totally different pattern for saving the "heading" data and decided I simply didn't have the time. However, using a relational db appears to be far more efficient.

4.  My app links the path of introduction to the actual user who is the connection. While useful, it does not yet provide the topic heading that matched nor the name of the user, as shown in your example.






This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
