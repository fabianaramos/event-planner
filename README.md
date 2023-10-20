## Event Planner

Event planner is an application for organizing conferences, setting a time for your lectures, obtaining their duration and generating a schedule. You can create lectures by uploading a CSV file or manually.

Feel free to use the example [CSV file](https://github.com/fabianaramos/event-planner/blob/main/public/lectures.csv) to testing create lectures by upload.

# Pre-requisites

- install [docker](https://docs.docker.com/get-docker/)

# Starting the application

- Copy and paste the following command on your terminal:

```bash
$ docker compose up
```

# Setting up the database

- Copy and paste the following commands on your terminal:

```bash
$ docker ps
$ docker exec -it <CONTAINER_ID> rails db:create
$ docker exec -it <CONTAINER_ID> rails db:migrate
$ docker exec -it <CONTAINER_ID> rails db:seed
```

# Running tests

- Copy and paste the following command on your terminal:

```bash
$ docker exec -it <CONTAINER_ID> rspec
```

# Acessing application

- http://localhost:3000 on browser (frontend application)

or

- install [postman](https://www.postman.com/downloads/) and import the [postman collection](https://github.com/fabianaramos/event-planner/blob/main/event_planner.postman_collection) to send requests (api)

# Libraries

- gem [active_model_serializers](https://github.com/rails-api/active_model_serializers)
- gem [factory_bot_rails](https://github.com/thoughtbot/factory_bot)
- gem [rspec-rails](https://github.com/rspec/rspec-rails/tree/6-0-maintenance)
