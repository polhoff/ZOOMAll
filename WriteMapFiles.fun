
WriteMapFiles = function ( ZOOM_data_set, outdir = dirdmp )

	{

	varnames_ndx = grep ( paste ( mapfilelist, collapse = "|"), names ( ZOOM_data_set ) )



	n_len = length ( varnames_ndx )
	
	grids_new = names ( table ( ZOOM_data_set$glx ) )
	
	for ( i in grids_new )

		{

		x = ZOOM_data_set [ ZOOM_data_set$glx == i, ]
		
		x = GrdSrtForOutput ( x )
		
		#assign ( paste ( "rgmdl_", i, sep = "" ), x, envir = .GlobalEnv )

		assign ( paste ( "rgmdl_", i, sep = "" ), x )

		}


	for (i in 1:n_len)
	#for (i in 29:31)

		{

		zz = file ( paste ( outdir, names ( ZOOM_data_set[varnames_ndx[i]] ), ".map", sep="") ,"w") 

		for ( j in 1:(length ( grids_new ) ) )
		
			{
		
			n_rows = get ( paste ( "gdim", j, sep = "" ) ) [1]
			
			n_cols = get ( paste ( "gdim", j, sep = "" ) ) [2]
			
			column_from_rgmdl =  get ( paste ( "rgmdl_", grids_new[j], sep = "" ) )[varnames_ndx[i]]
						
			x1 = matrix ( as.character ( column_from_rgmdl[,1] ), nrow = n_rows, byrow = TRUE)
			
			x =  matrix ( paste ( x1, collapse = "" ), nrow = n_rows )

			write(dashes,zz, append=TRUE, ncol=1)
			#when the matrix is written, it is written by columns
			#therefore have to transpose
			# if there was no byrow = TRUE above, then no need to transpose
			
			for ( k in 1:n_rows )
			
				{
				
				write( paste ( x1[k,], collapse = "" ), zz, append=TRUE )
			
				}
			
			
			}

		close(zz)

		}

	print ( paste ( "New files written to   ", outdir, sep = "" ) )

	#listobject = ListNewObjects(listobject)

	}
