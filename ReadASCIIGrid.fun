library ( maptools )

ReadASCIIGrid = function ( indir = dirdata, infile )

	{

	x <- data.frame(readAsciiGrid ( paste ( indir, infile, sep = "" ) ) )
	
	return ( x )
	
	}
