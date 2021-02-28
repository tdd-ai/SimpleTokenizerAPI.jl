module APITemplate
using SimpleTokenizer

include("src/Client.jl")
using .Client

include("src/Resource.jl")
using .Resource

include("src/Auth.jl")
using .Auth

function run()
    Resource.run()
end

end # module
