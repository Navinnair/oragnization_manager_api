# Organization Manager

Organization Manager is an api only app for managing different level of Organization and employees.

### Domain overview

Imagine a huge international corporation. It has many sub-companies in different countries. 
Each sub-company has many sub-sub-companies in different regions. Each sub-sub-company can have branches in different cities, etc.

Each company(and its sub-companies) needs some specific required amount of employees.
To properly operate, the following condition should be met:

`Amount of employees in the company + Amount of employees in its sub-companies >= Required amount of employees`

### You can use Organization Manager api for
- Add, Remove and show company
- Add and Remove an employee to the company
- Get a list of all companies
- Get a list of all companies where the amount of employees is less than required (list with filter)




## Installation

### Dependencies
- Ruby 2.7
- SQLite

### Install bundler and required gems
Once the specified version of Ruby is installed with all its dependencies satisfied, run the following command from the root directory of the application.
```sh
gem install bundler
bundle install
```
### Configure application

Update the credentials in database.yml with actual values.

Now you can create the database and perform migrations
```sh
rake db:create
rake db:migrate
```
App will populate the database with an admin user entry when we run the seed.
```sh
rake db:seed
```

### Start application
Start Sidekick.
```sh
bundle exec sidekiq
```

Start Application.
```sh
rails s
```
