using HTTP
using JSON

# include our service functions
include("src/tokenizer.jl")

# /tokenize
function handleTokenize(req::HTTP.Request, input)
    tokenize(input)
end

# /count-tokens
function handleCountTokens(req::HTTP.Request, input)
    countTokens(input)
end

# /get-unique-words
function handleGetUniqueWords(req::HTTP.Request, input)
    getUniqueWords(input)
end

# define REST endpoints to dispatch to "service" functions
const API_ROUTER = HTTP.Router()

# add the first API function
HTTP.@register(API_ROUTER, "POST", "/count-tokens/", handleCountTokens)

# add the first API function
HTTP.@register(API_ROUTER, "POST", "/get-unique-words/", handleGetUniqueWords)

# add the third API function
HTTP.@register(API_ROUTER, "POST", "/tokenize/", handleTokenize)

# fetch authentication token
AUTH_TOKEN = get(ENV, "AUTH_TOKEN", "")

function JSONHandler(req::HTTP.Request)
    # first check if there's any request body
    body = IOBuffer(HTTP.payload(req))
    if eof(body)
        # no request body
        response_body = handle(API_ROUTER, req)
    else
        # there's a body, so pass it on to the handler we dispatch to
        response_body = handle(API_ROUTER, req, JSON.parse(body))
    end
    return HTTP.Response(200, JSON.json(response_body))
end

# AuthHandler to reject any unknown users, here we authenticate using token, if we don't set the AUTH_TOKEN variable in .env file then there will be no authentication
function AuthHandler(req)
    if HTTP.hasheader(req, "Auth-Token")
        auth_token = HTTP.header(req, "Auth-Token")
        if AUTH_TOKEN == auth_token
            return JSONHandler(req)
        end
    elseif isempty(AUTH_TOKEN)
        return JSONHandler(req)
    else
        return HTTP.Response(401, "unauthorized")
    end
end

# get port from .env file 
port = get(ENV, "API_PORT", 5005)

# start listening
HTTP.serve(API_ROUTER, "0.0.0.0", port)