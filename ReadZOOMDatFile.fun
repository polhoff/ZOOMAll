
ReadZOOMDatFile = function ( indir = dirorig, input_filename ="hydcond01.dat")
	{

	dircurrent = getwd()
	
	setwd ( indir )
	
	x =  readLines ( input_filename )

	x1 = textConnection ( x )
	
	z = count.fields ( x1 )

	z_table = table ( z )

	out_vector = NULL

	for ( j in seq ( along = grids ) )

		{
		
		relevant_gdim = get ( paste ( "gdim", j, sep = "" ) )
		
		relevant_grids = grids[j]
		
		base_grid_sub = base_grid [ base_grid$glx == relevant_grids, ]
		
		incoming_order = base_grid_sub [ order ( -base_grid_sub$yloc, base_grid_sub$xloc ), ]
		
		which_rows = which ( z == relevant_gdim[2] )
		
		y1 = scan ( textConnection  ( x [ which_rows ] ) )

		#sort y1 to original order of base_grid, which is increasing yloc then increasing xloc
		#out_vector = out_vector[ order ( incoming_order$yloc, incoming_order$xloc  ) ]
		y1 = y1[ order ( incoming_order$yloc, incoming_order$xloc  ) ]
		
		out_vector = append ( out_vector, y1 )
				
		}
	
	setwd ( dircurrent )
	
	return ( out_vector )

	}
