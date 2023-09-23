
WriteK_File = function ( ZOOM_data_set, outdir = dirdmp1, n_ctr )
	{

	grids_new = names ( table ( ZOOM_data_set$glx ) )
	
	for ( i in grids_new )

		{

		x = ZOOM_data_set [ ZOOM_data_set$glx == i, ]
		
		x = GrdSrtForOutput ( x )
		
		#assign ( paste ( "rgmdl_", i, sep = "" ), x, envir = .GlobalEnv )

		assign ( paste ( "rgmdl_", i, sep = "" ), x )

		}

	zz = file ( paste ( outdir, "K_values_new", c_labels[n_ctr], ".dat", sep="") ,"w") 

	i = match ( "K_values_new", names ( K_values_df ) )

	for ( j in 1:(length ( grids_new ) ) )
	
		{
	
		n_rows = get ( paste ( "gdim", j, sep = "" ) ) [1]
		
		n_cols = get ( paste ( "gdim", j, sep = "" ) ) [2]
		
		column_from_rgmdl =  get ( paste ( "rgmdl_", grids_new[j], sep = "" ) ) [,i]
		
		x = matrix ( column_from_rgmdl, nrow = n_rows, byrow = TRUE)

		write(dashes,zz, append=TRUE, ncol=1)
		#when the matrix is written, it is written by columns
		#therefore have to transpose
		# if there was no byrow = TRUE above, then no need to transpose
		write(t(x),zz, append=TRUE, ncol = n_cols)
		
		}

	close(zz)
	
	#print ( paste ( "New files written to   ", outdir, sep = "" ) )

	#listobject = ListNewObjects(listobject)

	}
