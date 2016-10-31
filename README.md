# Movie Theater App

### Models/Tables (Theaters, Auditoriums, Movies, MovieScreenings, TicketOrders)

#### Theaters 
Theaters are the main table of the app. They are associated in a has_many relationship with all other tables and hold the basic movie theater information a customer might want to know
* name
* manager
* street_address, city, state, zip

#### Auditoriums(Auditoria)
A theater consists of many auditoriums, so they belong_to a theater, and have many movies to play. Since the amount of tickets that can be sold depends on the seats available in a movie's auditorium, this table holds the editable seating_capacity field 
* name
* seating_capacity
* theater_id

#### Movies
The next major table are the movies. Movies belong_to a theater and the auditorium in which a movie can play. Placing a foreign_key for an auditorium allows the theater owner to easily change in which auditorium a movie will play. Since a movie can be shown several times a day, they have a has_many relationship with two other tables: movie screenings and ticket orders 
* title
* run_time_minutes
* ticket_price
* auditorium_id
* ticket_id

#### Movie Screenings
Movie Screenings hold the individual screening data for each movie a customer may want to see. Therefore they belong_to a movie, as well as a theater. 
* title
* run_time_minutes
* ticket_price
* auditorium_id
* ticket_id

#### Ticket Orders
Finally, once a customer has decided which movie screening they would like to buy a ticket for, they can create a new ticket order, which belongs_to a movie screening, allowing the order to have access to all relevant movie, auditorium, and theater info for the customer's ticket/receipt.
* price
* paid
* name
* email
* credit_card_number
* expiration_date
* ticket_date
* movie_screening_id

These were the 5 basic models I thought were enough to get a simple movie theater started. Once a user visits the page and chooses their theater, the theater show page contains all the movies playing and their available show times. Since the movie screenings have all the relevant date/time information and are tied to the ticket_orders table, I created some model methods to check the amount of tickets remaining for each screening, ensuring sold out screenings were marked as such and then disabled the ability to create a ticket order for a past or sold out screening. 

For ticket orders, I used a the gem 'credit_card_validations' and a jQuery.payment plugin to validate the customer credit cards and simple date validations for expiration dates. Once submitted successfully, users will receive a ticket order summary/receipt to their email, which was set up with SendGrid.

The theater show page is also the main place for the owner to check out all business details. The tabs for auditoriums lets you choose an auditorium to see all movies being played inside and their showtimes. The orders tab shows all individual orders with the earliest orders first. The final 'orders by movie' tab can be clicked to reveal all the orders for each movie playing in the theater, with movies ordered from highest to least ticket orders.

To make sure all the model methods I wrote and all controller actions affecting the database were running properly, I wrote some tests in RSpec along with Factory Girl.

### Dependency List

#### Software Versions

* Ruby 2.3.1
* Rails 5.0.0.1
* Postgresql 9.5.2

#### Notable Gems


* gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
* gem 'pg', '~> 0.18' - A gem to set up a ruby interface for PostgreSQL
* gem 'figaro' - A gem that allows a developer to store information that doesn't get pushed up to Github

* gem 'bootstrap-sass', '~> 3.3.6' - A gem to install the bootstrap css framework
* gem 'credit_card_validations' - A gem that adds a validator to check whether or not a given number actually falls within the ranges of possible numbers
* gem 'sendgrid' - A gem to set up email sending services with action mailer and the SendGrid smtp api

* gem 'rspec-rails', '~> 3.5' - A gem that allows a user to create tests for the application
* gem 'factory_girl_rails' - A gem used in tandem with RSpec to create factories for tests
* gem 'rails-controller-testing' - A gem to help integrate assigns feature for controller tests
* gem 'faker' - A gem used to create fake data for testing purposes, also necessary to run the seed file


### Install Features

After cloning this repo in your terminal, run
```terminal
bundle
bundle exec figaro install # generates config/application.yml to store environment variables for SendGrid, etc
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
To seed the database with initial theater/movie data run
```terminal
rake db:seed
```
From here, you can begin to checkout movie screenings and create new ticket orders

### Starting The Application

Inside the application folder in the terminal run
```terminal
rails s
```
to start the server. Go to localhost:3000 in your browser to see the application and choose your theater.

### Test Suite 
To run tests, in the terminal run
```terminal
bundle exec rspec
```
### Heroku
The app is deployed to heroku on https://guarded-dusk-74406.herokuapp.com

