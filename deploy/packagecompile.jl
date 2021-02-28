using Pkg

Pkg.instantiate()

using PackageCompiler

# fetch authentication token
const LIB_PATH = get(ENV, "LIB_PATH", "SimpleTokenizerAPI.so")

create_sysimage(:APITemplate;
    sysimage_path=LIB_PATH,
    precompile_execution_file="deploy/precompile.jl")