
CreateSubGrid = function ( xlow, ylow, xhi, yhi, x_spac, y_spac )

	{
	
	y = expand.grid ( seq ( xlow, xhi, by = x_spac ), seq ( ylow, yhi, by = y_spac ) )
	
	names ( y ) = c ( "xloc", "yloc" )
	
	y = y [order (-y$yloc, y$xloc), ]
	
	y$glx = paste ( "gl", ( length ( grids ) + 1 ) ,sep = "" )
	
	y$x_spacing = x_spac
	 
	y$y_spacing = y_spac
	
	return ( y)
	 
	}
