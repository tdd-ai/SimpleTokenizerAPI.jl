using ..Client, ..Auth
using Sockets
using HTTP
using JSON

module Resource

const API_ROUTER = HTTP.Router()

# add the first API function
HTTP.@register(API_ROUTER, "POST", "/count-tokens/", Client.handleCountTokens)

# add the second API function
HTTP.@register(API_ROUTER, "POST", "/get-unique-words/", Client.handleGetUniqueWords)

# add the third API function
HTTP.@register(API_ROUTER, "POST", "/tokenize/", Client.handleTokenize)

not_found(req::HTTP.Request, args) = "not found"
HTTP.@register(API_ROUTER, "/*", not_found)

port = parse(Int, get(ENV, "API_PORT", 5005))

function run()
    HTTP.serve(Auth.AuthHandler, Sockets.localhost, port)
end

end
