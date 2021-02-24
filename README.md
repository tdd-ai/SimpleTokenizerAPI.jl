# Julia API Template - Simple Tokenizer API Example in Julia

This repo contains an example of a simple tokenizer API in Julia.

Each service needs to contain two shell scripts, which will be used by docker:

- **install.sh**: This script is used for setting up the environment
- **run.sh**: This script will be used by as an entry point for docker

### Environment file [vars.env](vars.env)

This file contains the path to packages file and other environment variables to be used in install.sh or run.sh scripts.

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
julia> JSON2.parse("{\"key\": \"some value here\", \"another key\": [\"one\", \"two\"]}")

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
