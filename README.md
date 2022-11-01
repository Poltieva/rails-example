# README
## How to run project first time

Add .env file (look at .env.example)
```
docker-compose -f "docker-compose.dev.yml" build
docker-compose -f "docker-compose.dev.yml" run web rake db:create
docker-compose -f "docker-compose.dev.yml" up
```

At this point, you should be able to navigate to http://localhost:3000
or http://192.168.99.100:3000 (Docker's default host)
in your local browser and see the app running.

To stop containers, use
```docker-compose -f "docker-compose.dev.yml" down```

You have to run
```docker-compose -f "docker-compose.dev.yml" build```
every time you add a new gem!

To use PgAdmin, go to localhost:5555, register server with 
hostname `host.docker.internal`
maintenance database `example_app_development`
username & password from `.env` `POSTGRES_USER_DEV` and `POSTGRES_PW_DEV`

##Push changes to heroku
Use `git push heroku main` to push main branch to Heroku
Use `heroku run rake db:migrate` to run migrations
Use `heroku open` to launch app in the browser
Use `heroku logs` to see the logs
Use `heroku run [command]` to run rails / rake commands

