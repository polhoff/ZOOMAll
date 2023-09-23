
#library(R.utils)

ReadBoundaryDDat = function ( inputdir = dirdata )

	{
	
	x = readLines ( paste ( inputdir, "boundary.dat", sep = "" ) )

	z = count.fields ( textConnection ( x ) )

	x1 = x[z > 3]
	
	writeLines ( x1, paste ( dirdmp, "boundary_xy_only.dat", sep = "" ) )
	
	x2 = read.table ( paste ( dirdmp, "boundary_xy_only.dat", sep = "" ) )
	
	return ( x2 )
	
	}
