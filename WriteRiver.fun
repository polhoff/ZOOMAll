WriteRiver = function ( dir_this = dirdmp, x = river_list, outfile = "rivers.dat")

	{

	river_list = x

	river_out = NULL
	
	river_out[1:4] = unlist ( river_list[1])[1:4]

	n_rivernodes = unlist ( river_list[2])

	for ( i in 1:n_rivernodes )
	
		{
		
		river_out [ length ( river_out ) + 1 ] = "--------------------"
		river_out [ length ( river_out ) + 1 ] = paste ( as.data.frame ( river_list[6] )[i,], collapse = " ")
		river_out [ length ( river_out ) + 1 ] = paste ( as.data.frame ( river_list[7] )[i,], collapse = " " )
		river_out [ length ( river_out ) + 1 ] = paste ( as.data.frame ( river_list[8] )[i,] )
		
		}

	write ( river_out, file = paste ( dir_this, outfile, sep = "" ) )
	print ( paste ( "New files written to   ", dir_this, sep = "" ) )
	return ( river_out )
	
	}

WriteRiver ()
