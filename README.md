# Just A Break App

### Introduction

  Just a break is a volunteer management application for the non-profit organization Just A Break, which allows businesses to donate gifts to cancer facilities, which in turn distribute gifts to cancer patients and caregivers. The app allows users to keep track of what businesses have been contacted and what gifts are available for facilities to distribute.

### Dependency List

#### Software Versions

* Ruby 2.2.3
* Rails 4.2.5
* Postgresql 9.4.5
* AngularJS 1.5.3

#### Notable Gems

* gem 'pg', '~> 0.15' - A ruby interface for PostgreSQL
* gem 'jbuilder', '~> 2.0' - A gem that allows the user to work with API's
* dotenv-rails - A gem that allows a developer to store information that doesn't get pushed up to Github.
* gem 'devise', '~> 3.5.6' - A ruby gem for authentication
* gem 'rspec-rails', '3.4.2' - A ruby gem that allows a user to create tests for the application
* gem 'factory_girl_rails', '~> 4.4.1' - Used in tandem with RSpec to create factories for tests.
* gem 'faker', '~> 1.4.3' - Used to create fake data for testing purposes.
* gem 'puma', '~> 3.3.0' - A concurrent web server for Ruby

### Admins, Coordinators, and Volunteers

#### Admins 
An admin has full access to the application, and are the only people that can created new admins. They have full CRUD rights over
* Users
* Facilities
* Businesses
* Gifts
* Comments

#### Coordinators
A coordinator has full access to the application, but cannot create new admins. They have full CRUD rights over
* Users
* Facilities
* Businesses
* Gifts
* Comments

#### Volunteers
A volunteer can view
* Facilities
* Businesses
* Gifts
* Comments (within facilities and businesses only)

A volunteer can create and edit
* Businesses
* Gifts
* Their own comments

### Install Features

After cloning this repo in your terminal, run
```terminal
bundle
```

#### Database Configuration

In the terminal after navigating to the application folder, you can create the database with
```terminal
rake db:create
```
To migrate the fields of the database run
```terminal
rake db:migrate
```
To seed the database with data run
```terminal
rake db:seed
```

### Starting The Application

Inside the application folder in the terminal run
```terminal
rails s
```
to start the server. Go to localhost:3000 in your browser to see the application.

### Test Suite 
To run tests, in the terminal run
```terminal
bundle exec rspec
```
### Heroku
The app is deployed to heroku on three servers
* qa
* demo
* prod

