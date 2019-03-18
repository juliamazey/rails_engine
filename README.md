# README
### Rails Engine
This is a one week long, solo project where we use Rails and ActiveRecord to build a JSON API which exposes the SalesEngine data schema.
Here is the [project description](http://backend.turing.io/module3/projects/rails_engine). In the project I have used the gem  Fast JSON:API, which complies with the the [JSON:API specifications](https://jsonapi.org/). 
### Installation

You can install the application by cloning it

```
$ git clone https://github.com/juliamarco/rails_engine.git
$ cd rails_engine
$ bundle install
```

Then set up the database

```
rails db:{create,migrate}
```

Import the data from the csv files
inside "/lib/tasks/import.rake" you will see the different tasks to upload each file. E.g.:

```
rake import:invoices
```

