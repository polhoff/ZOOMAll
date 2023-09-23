CreateDirPT = function ( inputdir )

	{
	
	n_char = nchar ( inputdir )

	x = left ( inputdir, n_char-1)

	x1 = paste ( x, "_p/", sep = "" )

	return (x1)

	}
