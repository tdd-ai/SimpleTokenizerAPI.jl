module Client

using HTTP
using SimpleTokenizer

function handleTokenize(req::HTTP.Request, input)
    return Dict("tokens" => SimpleTokenizer.tokenize(input["text"]))
end

# /count-tokens/
function handleCountTokens(req::HTTP.Request, input)
    return Dict("count" => SimpleTokenizer.countTokens(input["text"]))
end

# /get-unique-words/
function handleGetUniqueWords(req::HTTP.Request, input)
    return Dict("unique-words" => SimpleTokenizer.getUniqueWords(input["text"]))
end


end # module
