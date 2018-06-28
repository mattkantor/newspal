# README
How to run this thing

* Ruby version: 2.4

* System dependencies: Redis, Postgres, Unicorn, NGINX, python3/spacy/spacy en, Sentry.io

* Configuration

* Database creation: see config/database.yml

* Database initialization -
- rake db:seed
- rake update_news
- rake update_ner

* How to run the test suite - NYI

* Services (job queues, cache servers, search engines, etc.)
- redis / sidekiq

* Deployment instructions
cap production deploy

Next:
- create categories from entities, one time only.
- add aliases to item_categories
- create script tp build items_categories every day from the 2 days before 
