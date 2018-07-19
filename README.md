# Formio API Docker Container

## Docker suite for the [FAST](https://github.com/UN-FAO) project

Includes the [Form.io](https://form.io)'s open-source [API Server](https://github.com/formio/formio) based on Alpine Linux.

### Usage

To start using this docker container just clone the repository and build it using docker-compose

```sh
git clone https://github.com/un-fao/fast-docker-api.git       # clone the repository
cd ./fast-docker-api
cp env-example ./.env                                         # modify and save the .env file
docker-compose up -d mongo formio portainer opencpu netdata   # fire-up the docker container
```

## Environment Configuration

The file `env-example` is provided as template for setting up the environment variables. Once ready, save it as `.env` to start the full stack

### Docker Configuration

These are some of the environment variables available for configuring the [Form.io](https://form.io) docker container. Check [env-example](env-example). For more examples check the [custom-environment-variables.json](config/custom-environment-variables.json) to see how they map themselves into the API server configuration.

##### Docker

| Setting         | Description                                           | Example  |
| --------------- | ----------------------------------------------------- | -------- |
| DATA_PATH_HOST  | Storage path on your machine. For all storage systems | `./data` |
| NETWORKS_DRIVER | The docker network to attach the container            | `bridge` |
| VOLUMES_DRIVER  | The volume to attach the containers                   | `local`  |

##### Formio

| Setting                 | Description                                                                                          | Example                                                                                                                          |
| ----------------------- | ---------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| FORMIO_PROTOCOL         | The protocol used to connect to the formio container (default = http)                                | `http`                                                                                                                           |
| FORMIO_HOST             | The host used to connect to the formio container (default = localhost)                               | `localhost`                                                                                                                      |
| FORMIO_PORT             | The port used to connect to the formio container (listening port)                                    | `3001`                                                                                                                           |
| PROJECT_TEMPLATE        | The project template to use # (leave empty or use default to us default Form.io template).           | `default`                                                                                                                        |
| ROOT_EMAIL              | The default root account username used when installing the Form.io API.                              | `admin@example.com`                                                                                                              |
| ROOT_PASS               | The default root account password used when installing the Form.io API.                              | `admin@example.com`                                                                                                              |
| MONGO                   | The MongoDB connection string to connect to your remote database.                                    | `mongodb://user:user@mongo:27017/fast`                                                                                           |
| MONGO_SECRET            | The database encryption secret.                                                                      | `FTFaVuIdSv4Hj2bjnwae`                                                                                                           |
| MONGO_HIGH_AVAILABILITY | If your database is high availability (like from Mongo Cloud or Compose), then this needs to be set. | `1`                                                                                                                              |
| JWT_SECRET              | The secret password for JWT token encryption.                                                        | `YilQ9E1wOiITdWOeaMCL`                                                                                                           |
| JWT_EXPIRE_TIME         | The expiration for the JWT Tokens.                                                                   | `240`                                                                                                                            |
| EMAIL_TYPE              | The default email transport type (`sendgrid` or `mandrill`).                                         | `sendgrid`                                                                                                                       |
| EMAIL_USER              | The sendgrid api_user string.                                                                        | `sendgrid-user`                                                                                                                  |
| EMAIL_PASS              | The sendgrid api_key string.                                                                         | `sendgrid-pass`                                                                                                                  |
| EMAIL_KEY               | The mandrill apiKey string.                                                                          | `mandrill-key`                                                                                                                   |
| EMAIL_OVERRIDE          | Provides a way to point all Email traffic to a server (ignores all other email configurations).      | `{"transport":"smtp","settings":{"port":2525,"host":"smtp.mailtrap.io","auth":{"user":"23esdffd53ac","pass":"324csdfsdf989a"}}}` |

##### MONGODB

| Setting             | Description                                 | Example |
| ------------------- | ------------------------------------------- | ------- |
| MONGO_PORT          | Port to start the mongodb service.          | `27017` |
| MONGO_ROOT_USERNAME | Name of the root (admin) user               | `admin` |
| MONGO_ROOT_PASSWORD | Password of the root (admin) user           | `admin` |
| MONGO_DB_NAME       | Name of the database to create              | `fast`  |
| MONGO_DB_USER       | Name of the main user of the created DB     | `user`  |
| MONGO_DB_PASSWORD   | Password of the main user of the created DB | `user`  |

##### OpenCpu

| Setting            | Description           | Example |
| ------------------ | --------------------- | ------- |
| OPENCPU_PORT_HTTP  | The OpenCpu http port | `8085`  |
| OPENCPU_PORT_HTTPS | The OpenCpu http port | `8086`  |

##### NetData

| Setting      | Description      | Example |
| ------------ | ---------------- | ------- |
| NETDATA_PORT | The NetData port | `19999` |

## Project Templates

To include a custom project template, save it on the [templates](templates) directory using the following naming convention: `project.<id>.json` (e.g.: `project.basic.json`). To install a specific template, set the `PROJECT_TEMPLATE` value to the templates `<id>`. The `default` id is reserved for Form.io's [default project template](https://github.com/formio/formio-app-formio/blob/master/dist/project.json). All projects templates should use Form.io's Project JSON Schema.

###### Example

You may have multiple project templates in your `templates` directory.

```
--- templates
    |--- project.basic.json
    |--- project.full.json
```

Then on your `.env` file you just need to specify which template to use:

```
PROJECT_TEMPLATE=full
```

If the mongodb database defined in the mongo connection string does not exist, then a new project will be initialized using the given project template.

## Changing the Dockerfiles

If you want to manually apply changes to one of the Dockerfiles dont forget to
manually build the image using: docker-compose build <name-of-the-image>

```
docker-compose build formio
```

## Authors

- **Alfredo Irarrazaval** - [airarrazaval](https://github.com/airarrazaval)
- **Ignacio Cabrera** - [cabrerabywaters](https://github.com/cabrerabywaters)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
