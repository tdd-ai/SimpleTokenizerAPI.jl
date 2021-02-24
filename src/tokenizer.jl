"""
    tokenize(input::String)

    Split the input argument into a list of tokens/words and Return it. 
"""
function tokenize(input::String)
    split(input)
end


"""
    countTokens(input::String)

    Return the number of tokens/words in the given input. 
"""
function countTokens(input::String)
    length(tokenize(input))
end


"""
    getUniqueWords(input::String)

    Return list of unique tokens/words in the given input. 
"""
function getUniqueWords(input::String)
    Set(tokenize(input))
end

nothing;