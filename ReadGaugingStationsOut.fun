
ReadGaugingStationsOut = function ( indir = dirdata, gsfile = "gauging_stations.dat" )

	{
	
	#indir = dirdata; gsfile = "gauging_stations.dat"

	gsout = read.table ( paste ( indir, "gauging_stations.out", sep = ""  ) )
	
	n_gs = as.integer ( readLines ( paste ( indir, gsfile, sep=""),n = 1))

	gs_nodes = read.table ( paste ( indir, gsfile, sep=""), skip=2, nrows = n_gs)

	objs <- ls()

	objList <- vector(mode='list', length=length(objs))

	names(objList) <- objs
	
	for(x in seq(along=objs)) objList[[x]] <- get(objs[x])

	#You could also use save the objects into a file:
	#save(objs, file='objects.Rdata')
	
	return ( objList )

	}
