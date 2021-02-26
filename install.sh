source .env

# install required julia packages
[ -e $JULIA_REQ_FILE ] && echo 'installing packages from '$JULIA_REQ_FILE
[ -e $JULIA_REQ_FILE ] && julia -e 'using Pkg; open("'$JULIA_REQ_FILE'") do f while !eof(f) nm, vr = split(readline(f), "@");Pkg.add(name=String(nm), version=String(vr)); end; end'