source .env

# install required julia packages
[ -e $JULIA_REQ_FILE ] && echo 'installing packages from '$JULIA_REQ_FILE
[ -e $JULIA_REQ_FILE ] && julia -e 'using Pkg; open("'$JULIA_REQ_FILE'") do f while !eof(f) Pkg.add(readline(f)); end; end'