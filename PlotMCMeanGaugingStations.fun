
PlotMCMeanGaugingStations = function ( run_number )

	{

	dirmc = paste ( dirtop, "GWModelling/GroundwaterModel/Regional_model/FM_1L_V2/MC_by_borehole/Run", run_number, "/", sep = "" )

	MCGSall = read.table ( paste ( dirmc, "MonteCarloGSAll.out", sep = "" ) )

	y = NULL

	for (i in 1:length(names(MCGSall)))

		{
		
		x = MCGSall[,i]
		
		x = x[x>0]
		
		y[length(y)+1] = mean ( x ) / 1000

		pngfilename = paste ( "gs_", i, "_MCRun", run_number, ".png", sep = "" )
		
		PngOn(outfile = paste ( "gs_", i, "_MCRun", run_number, ".png", sep = "" ))

			hist (x / 1000)

		PngOff()
				
		}

	print ( y)

	return ( y )

	}
