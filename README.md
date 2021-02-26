# Julia API Template - Simple Tokenizer

This repo contains an example of a simple tokenizer API in Julia. 

Please follow the instructions carefully.

### Shell scripts:

Each service will contain two shell scripts, which will be used by docker:

- **install.sh**: This script is used for setting up the environment
- **run.sh**: This script will be used by as an entry point for docker

### Environment file [.env](.env)

This file will contain the path to packages file and other environment variables to be used in install.sh and run.sh scripts.
Note that you must not share your own copy of .env file, since it might contain security related information (like authentication tokens). replace it with your version of the .env file:

```
cp vars.env .env
```

### Packages file [julia.packages](julia.packages)

This file contains the required Julia packages, one package name per line.

_Example_:

```
Knet@v1.4.5
Luxor@v2.8.0
Plots@v1.10.3
```

### HTTP and JSON

You will be receiving the HTTP post/get requests in JSON format, so it is essential to know how to use it. Here you can see an example:

```julia
julia> JSON.parse("{\"key\": \"some value here\", \"another key\": [\"one\", \"two\"]}")

Dict{String,Any} with 2 entries:
  "key"         => "some value here"
  "another key" => Any["one", "two"]

julia> var = Dict("some key"=>"some value")
Dict{String,String} with 1 entry:
  "some key" => "some value"

julia> JSON.json(var)
"{\"some key\":\"some value\"}"

```

See [JSON](https://juliapackages.com/p/json) package for more usage examples. [Here](https://juliaweb.github.io/HTTP.jl/stable/public_interface/#Server-/-Handlers) you can read about HTTP requests too.


## Running this example

In order to run this example you need to have julia => v1.3, all you need to do after cloning this repo is to use the scripts install.sh and run.sh:

```
$ ./install.sh
$ ./run.sh
```

And the server will be running on the port 5005 as specified in .env file.

### Test and example

You can test this service by sending a post request with JSON to the following API, for example you can use curl to do this:

```shell
$ curl -X POST -d '{"text":"this is some sentence. this is another sentence"}' http://localhost:5005/tokenize/
{"tokens":["this","is","some","sentence.","this","is","another","sentence"]}

$ curl -X POST -d '{"text":"this is some sentence. this is another sentence"}' http://localhost:5005/count-tokens/
{"count":8}

$ curl -X POST -d '{"text":"this is some sentence. this is another sentence"}' http://localhost:5005/get-unique-words/
{"unique-words":["another","this","is","sentence.","some","sentence"]}

$ curl -X POST -d '{"text":"this is some sentence. this is another sentence"}' http://localhost:5005/not-existing-api/
"not found"
```