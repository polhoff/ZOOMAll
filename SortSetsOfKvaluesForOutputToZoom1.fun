SortSetsOfKvaluesForOutputToZoom = function ( grepterm = "valtransectcircle" )

	{

	varlist = ls()[grep ( grepterm, ls())]

	for ( i in varlist )

		{

		assign ( i, GrdSrtForOutput1 ( get ( i ) ), inherits = TRUE )

		}

	}

