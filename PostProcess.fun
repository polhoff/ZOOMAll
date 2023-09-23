PostProcess = function ( input_list )
	{
	x = names ( input_list )

	for ( i in seq ( along = x ) )
		{
		
		assign ( x[i], input_list [[i]], envir = .GlobalEnv  )

		}
	}
