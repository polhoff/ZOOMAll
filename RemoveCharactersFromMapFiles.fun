
RemoveCharactersFromMapFiles = function ( outdir = dirdmp )

	{

	x = list.files ( outdir, pattern = ".map$" )
	x1 = list.files ( outdir, pattern = ".map$", full.names = TRUE )
	
	for ( i in seq ( along = x ) )
	
		{
		
		y1 = readLines  ( x1[i] )
		
		y2 = DeleteChar ( y1 )
		
		write ( y2, file = x1[i] )
		
		}
	
	}
