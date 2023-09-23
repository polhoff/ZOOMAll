
ReadHydcondMap = function ( inputdir = dirdata, filename = "hydcond01.map" )

	{

	filelist_part = list.files ( inputdir, pattern =  "hydcond[0-9]+.map$" )
	filelist_full = list.files ( inputdir, pattern =  "hydcond[0-9]+.map$", full.names = TRUE )

	fieldnames = matrix ( unlist ( strsplit ( filelist_part, "[.]" ) ), ncol = 2, byrow = TRUE )

	Asterisks(3)
	print ("this requires that each grid or sub-grid has a unique number of columns" )
	Asterisks(3)
	
	out_df = base_grid

	for (i in seq ( along = fieldnames[,1] ) )

		{

		#add ----- at the end to make splitpoints classification consistent
		#file1 = c ( readLines(filesoutsub[i,1]),   dashes )
		x =  readLines ( filelist_full [i] )

		x = InsertChar ( x )


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
			
			y1 = scan ( textConnection  ( x [ which_rows ] ), what = "character" )

			#sort y1 to original order of base_grid, which is increasing yloc then increasing xloc
			#out_vector = out_vector[ order ( incoming_order$yloc, incoming_order$xloc  ) ]
			y1 = y1[ order ( incoming_order$yloc, incoming_order$xloc  ) ]
			
			out_vector = append ( out_vector, y1 )
					
			}
		
		assign ( fieldnames[i,1], out_vector )

		out_df = cbind ( out_df, out_vector )

		out_df[[length ( names ( out_df ) )]] = as.character ( out_df[[length ( names ( out_df ) )]] )

		names ( out_df ) [length ( names ( out_df ) )] = fieldnames[i,1]

		}
	
	return ( out_df )
	
	}

	listobject = ListNewObjects(listobject)
