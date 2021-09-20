# Hometime

<a href="https://asciinema.org/a/436916" target="_blank"><img width="80%" src="https://asciinema.org/a/436916.svg" /></a>

### Running the application

To run this project simply you need to have Docker installed.
>  https://docs.docker.com/get-docker/

```sh
cd hometime
docker compose up
```
Wait for a few seconds until Docker instances become `healthy`, you can run the migrations.
> NOTE: You can check if Docker instances are running healthy by executing `docker-compose ps`

```sh
docker compose run web rails db:create db:migrate RAILS_ENV=development
```

> NOTE: You can run this using `docker-compose` but the latest version of
> Docker has added `docker compose` but if you find it unstable you can install
> `docker-compose`.
>```sh
>cd hometime
>docker-compose up
>docker-compose run web rails db:create db:migrate RAILS_ENV=development
>```


### Running the tests

You need to run the migrations for test environment using the command below:

```sh
docker compose run web rails db:create db:migrate RAILS_ENV=development
```

Then you can run `RSpec` tests using the command below:

```sh
docker compose run web rspec --format doc
```



### Things that can be done

- [ ] Use a serializer gem to prettify the response of `ReservationsController#create`
- [ ] Add static typing / schema validations inside each mapper to avoid bad data
- [ ] Deploy the application on Heroku
