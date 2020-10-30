# ↘️ ParallelDownload ↙️
The purpose of this app is to make **GET** requests to a given list of urls. You can pass them as an argument or via a `.txt` file.

## Requirements
- `elixir ~> 1.10`

## Installation
**ParallelDownload** is a common Elixir app and therefore is expected that you have it installed on your machine. However in this project you will also find a `docker-compose.yml` file so you can run via Docker

Make sure that you are on the project root folder and then run the following command. This will get the dependencies and compile the project
```
mix do deps.get, compile
```

If you would like to run via `docker-compose`, just prepend the previous command with docker-compose specific options, for instance:
```
docker-compose run --rm app mix do deps.get, compile
```

Good! now it's time to run the app!

## Usage
The app itself is running by a [mix task](https://hexdocs.pm/mix/Mix.Task.html) called `download` and this tasks accepts:

1) As much URLs that you can pass in the command line, separated by a space
2) A `.txt` files containing **only the URLs on each line**

### Configuration
You can also configure some operational aspects of this app by editing the `config/config.exs` file.
- The `max_concurrency` parameter control how many process will do the requests
  - Accept a `integer` value, e.g: `8` which is 8 process making requests

- The `task_timeout` is responsible to set a timeout on the process that is doing the request
  - Accept a `milliseconds` value or `:infinity` if you would like to disable the time out

- The `request_timout` is a client timeout configuration
  - Accept `milliseconds` as value, e.g: `2_000` which is equivalent of 2 seconds

---
Let's begin by covering the URLs passed by as arguments. To start the app with this options just run
```
mix download https://www.google.com https://github.com
```
The task will initialize the app and pass a list with only two URLs `["https://www.google.com", "https://github.com"]`

If the app succeeded, it will output some information, like this:
```
GET https://www.google.com -> status 200 in 508ms
GET https://github.com -> status 200 in 1642ms
```
---

Besides the previous running option, you also have the possibility to run the app passing a `txt` file containing a bunch of URLs.

This way can be really useful if you have a big list of URLs to **GET** to (pun intended 🥁).

So simple run the command passing the path to file as the argument
```
mix download /path/to/file/file.txt
```
⚠️ The file format accepted by the app is **very restricted** so make sure that it follows these rules:
1) Only URLs are allowed in the file
2) Each URL must be on it's on line

You can use the example file `urls.txt` on the project root folder to take a pic of how the file looks like, but it's pretty simple.

---
### Usage with docker
This app won't store any relevant information after it's finished his job, with that thought in mind we can run the app with the `docker-compose run --rm app` command, so after the app job is finished the docker container will be discarded.

The same as the installation process, you could run the app with the previous commands only prepend the `docker-compose` bit:
```
docker-compose run --rm app mix download /path/to/file/file.txt
```
---
### 🚀 Running the app with a single script
To execute all the above commands, tasks and tests you can execute the `run.sh` script, so just:
```
./run.sh
```

With docker:
```
docker-compose run --rm app ./run.sh
```

## Tests
To run the test suite just execute the command
```
mix test
```
