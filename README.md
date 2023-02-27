# README

# Sniff-Spot

Spot Management System Backend

## Description:

The following are the endpoints that are supported

add spot

edit spot

delete spot

add review

get spot 

get spot with reviews


## System Architecture:

Api endpoints to manage spot records and there reviews, fetch the spot and reviews from API and save them in our database.
Fetch data by using our show API's
```bash
api/v1/spot/:id
```

## Advantages:

Faster API's

Less dependency with punk API

consistence results

ERD (root directory)

### Key Points
Exception handling in concerns,
Use Serializer for JSON formatting,
Database and Model level validations,
Indexing on database columns,
Complete test coverage for Api's,
Normalized Database Structure,
Stack,
Ruby,
Ruby on Rails,
MySQL,
RSpec,
Getting Started,
To get a local copy up and running follow these simple steps.

## Prerequisites

ruby 2.7.2

rails 7.0.4.2

pg 1.1

## Installation

Clone the repo

Install the gems bundle install

Setup DB rake db:setup

Add basic data in DB rake db:seed

Start the server rails s

Run test suits rspec

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.
