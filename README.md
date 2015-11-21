# TrevBook:

Implimentation by [Trevor Elwell](http://trevorelwell.me)<br>
[TrevBook on Heroku](http://trevbook.heroku.com)

# Intro:
**Guest login:**<br>
**Email:** me@trevorelwell.com<br>
**Password:** password<br>

TrevBook is a project that covers a very wide scope, designed to solidify understanding of many core concepts within Ruby on Rails applications. In short, though, the goal of TrevBook was to figure out how to impliment many of the key features that regular Facebook has and build them into my own Ruby on Rails application. Here are some of the core technologies and concepts used: 

# Core Technologies & Concepts:
* Ruby on Rails
* JavaScript
* jQuery
* HTML
* CSS
* Bootstrap
* Sass
* Heroku
* Database Technologies:
  * SQLite3
  * PostgreSQL
  * ActiveRecord
* Complex Associations: 
  * Polymorphic Associations (Comments, Likes)
  * Self-referential Associations (Users)
* Mailers:
  * Sendgrid
  * Delayed Jobs
* Testing: 
  * RSpec
  * Factory Testing (Using `factory_girl`)
  * Controller Testing
  * Model Testing
  * Integration Testing (Using `capybara`)
  * Mailer Testing
  * View Testing
* Amazon S3 (with `paperclip`)

# Key Features:
This project covers a very wide breadth. But, here are the some of the highlights to have a look at both on the app itself, and in the code: 

**User Authentication:**

Usually using a gem like `Devise` would be the solution for user authentication. But, in order to learn the way that `Devise` and similar gems work I decided to build my user authentication from scratch. How this works is shown in the `sessions_controller`, `application_controller`, and `application_helper`. Essentially, though, I utilize the `bcrypt` gem to save a user token to a cookie. If I can authenticate that cookie then the user will be logged in, otherwise the user will not be. Building this from the ground up was a great excercise in using and interacting with session/cookie information, keeping things object-oriented (for instance, by separting sessions into their own controller), and using the built-in rails authentication helper methods.

**Complex Associations:**

Models like `Likes` and `Comments` are complicated because they aren't just associated with one other model. For instance, you can `Like` a post, or a photo and you can `Comment` on a post or a photo as well. This makes the associations a bit more difficult coneceptually, but through utilizint *polymorphic associations* things start to make a bit more sense. Have a look at `Like.rb`, `Comment.rb`, and the `Likeable.rb` concern to see more about how these polymorphic associations work on TrevBook.


**Photos:**

Photos are a very important part of TrevBook. Not only does each user have the ability to upload photos but each user can have an avatar and background image as well. In order to best tackle this challenge, I decided to use the `paperclip` gem along with Amazon S3 to host my images. I also created a new `Photo` model which has all of the information relating to the image from `paperclip`. Then, whenever I need to reference a `photo` from, for instance, a `User`, I only need to reference the `Photo.id` and I'm able to find the image itself! Along with that, you can upload images directly from your computer or via URL as well.

**Testing:**

Ensuring that TrevBook stays up and running a key priority of mine. Because of this I think it's important to include tests in my application, to be alerted if anything breaks through the course of development. I utilize a few gems (`capybara` and `factory_girl`, namely) to assist me in my testing. At the end of the day I have 80+ tests that help keey TrevBook safe and functioning.

# Final Thoughts:
There are many other features of TrevBook (searching for users, liking/commenting on various other models, mailers, etc.) but the key features above are the meat of it. It was a great project which really solidified my understanding of many key-concepts. If you have any suggestions, bug finds, or otherwise please let me know at [me@trevorelwell.com](mailto:me@trevorelwell.com). Thanks for using TrevBook!

**-Trevor**