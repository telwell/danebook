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
* Database Technologies:
*  SQLite3
*  PostgreSQL
*  ActiveRecord
* Complex Associations: 
*  Polymorphic Associations (Comments, Likes)
*  Self-referential Associations (Users)
* Mailers:
*  Sendgrid
*  Delayed Jobs
* Testing: 
*  RSpec
*  Factory Testing (Using `factory_girl`)
*  Controller Testing
*  Model Testing
*  Integration Testing (Using `capybara`)
*  Mailer Testing
*  View Testing
* Amazon S3 (with `paperclip`)

# Key Features
This project covers a very wide breadth. But, here are the some of the highlights to have a look at both on the app itself, and in the code: 

**User Authentication**
Usually using a gem like `Devise` would be the solution for user authentication. But, in order to learn the way that `Devise` and similar gems work I decided to build my user authentication from scratch. How this works is shown in the `sessions_controller`, `application_controller`, and `application_helper`. Essentially, though, I utilize the `bcrypt` gem to save a user token to a cookie. If I can authenticate that cookie then the user will be logged in, otherwise the user will not be. Building this from the ground up was a great excercise in using and interacting with session/cookie information, keeping things object-oriented (for instance, by separting sessions into their own controller), and using the built-in rails authentication helper methods.

**Complex Associations**
