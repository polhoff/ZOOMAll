
SortDataForOutputToZoom = function ( ZOOM_data_set )

	{

	grids_new = names ( table ( ZOOM_data_set$glx ) )

	for ( i in grids_new )

		{

		x = ZOOM_data_set [ ZOOM_data_set$glx == i, ]
		
		x = GrdSrtForOutput ( x )
		
		assign ( paste ( "rgmdl_", i, sep = "" ), x, envir = .GlobalEnv )

		}

	rm(x)

	}
