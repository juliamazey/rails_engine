# Rails Engine

Rails engine implements a [JSON API](https://jsonapi.org/) that uses various business intelligent queries to retrieve data based off of [SalesEngine CSV data](https://github.com/turingschool-examples/sales_engine/tree/master/data).



# Dependencies

- Ruby 
- Rails
- PostgreSQL

# Getting Started

Clone the repo, bundle to automate dependency requirements for the project and create and migrate the database

    git clone https://github.com/juliamarco/rails_engine
    cd rails_engine
    bundle
    rake db:{create,migrate}

Load the CSV data

    rake import:{invoices,items,merchants,transactions,customers,invoiceitems}

To start the application run 'rails s'

    rails s

The application runs on port 3000. It provides a Restful collection of API endpoints for all records. All possible endpoints can be found in the project description [here](http://backend.turing.io/module3/projects/rails_engine). One example to retrieve data would be:
    `http://localhost:3000/api/v1/merchants/random`


# Testing

To run the full test suite, run the following command:

    rake spec

# Built Using

- [Ruby on Rails Framework](https://rubyonrails.org/)
- [FastJsonapi](https://github.com/Netflix/fast_jsonapi)

# Created By

- [Julia Marco](https://github.com/juliamarco)
