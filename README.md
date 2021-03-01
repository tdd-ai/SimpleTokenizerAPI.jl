# Julia API Template - Simple Tokenizer

This repo contains an example of an API of [SimpleTokenizer.jl](https://github.com/tdd-ai/SimpleTokenizer.jl) in Julia.

The following project structure is recommended :

- Auth module for authentication
- Client module for client requests
- Resource module for HTTP registrations and other resources
- Model module for type definitions
- Mapper module for database interactions
- Service module for service functions

### Environment file [.env](.env)

This file will contain the path to packages file and other environment variables to be used in both the API package and Dockerfile.

Create your own version of the .env file and set the variables according to your application's required settings:

```shell
cp vars.env .env
```

Note that you must not share your own copy of .env file, since it might contain security related information (like authentication tokens). 

### Run directly

```bash
source .env
julia deploy/packagecompile.jl
julia --sysimage $LIB_PATH -e "SimpleTokenizerAPI.run()"
```

### Build docker image and run

```bash
source .env && docker build --build-arg api_port=$API_PORT --build-arg auth_token=$AUTH_TOKEN --build-arg lib_path=$LIB_PATH -t simple_tokenizer.jl_api:v0.1 .
docker run -p $API_PORT:$API_PORT -d simple_tokenizer.jl_api:v0.1
```

### Test API using cURL

if you are not in the same terminal window, run: `source .env` first.

```bash
curl -H "Auth-Token: "$AUTH_TOKEN -X POST -d '{"text":"this is some sentence. this is another sentence"}' http://localhost:$API_PORT/tokenize/
{"tokens":["this","is","some","sentence.","this","is","another","sentence"]}
```

```bash
curl -H "Auth-Token: "$AUTH_TOKEN -X POST -d '{"text":"this is some sentence. this is another sentence"}' http://localhost:$API_PORT/count-tokens/
{"count":8}
```

```bash
curl -H "Auth-Token: "$AUTH_TOKEN -X POST -d '{"text":"this is some sentence. this is another sentence"}' http://localhost:$API_PORT/get-unique-words/
{"unique-words":["another","this","is","sentence.","some","sentence"]}
```

```bash
curl -H "Auth-Token: "$AUTH_TOKEN  -X POST -d '{"text":"this is some sentence. this is another sentence"}' http://localhost:$API_PORT/not-existing-api/
"not found"
```
