
ReadObswellsOut = function ( indir = dirdata, obswellsfile = "obswells.dat" )

	{
	
	#indir = dirdata; obswellsfile = "obswells.dat"

	obswellsout = read.table ( paste ( indir, "obswells.out", sep = ""  ) )
	
	n_wells = as.integer ( readLines ( paste ( indir, obswellsfile, sep=""),n = 1))

	obswellsloc = read.table ( paste ( indir, obswellsfile, sep=""), skip=2, nrows = n_wells)

	objs <- ls()

	objList <- vector(mode='list', length=length(objs))

	names(objList) <- objs
	
	for(x in seq(along=objs)) objList[[x]] <- get(objs[x])

	#You could also use save the objects into a file:
	#save(objs, file='objects.Rdata')
	
	return ( objList )

	}
