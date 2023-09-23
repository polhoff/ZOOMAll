
PlotMCMeanFlowVsRMSE = function ( run_number )

	{

	colnumflow = 1
	gs_name = "Shaw"

	#pngfilename= paste ( "flow_vs_rmse_lambourn_at_", gs_name, "MCrun_", run_number, ".png", sep = "" )
	PngOn( outfile = paste ( "flow_vs_rmse_lambourn_at_", gs_name, "MCrun_", run_number, ".png", sep = "" ))

		par ( mar = c ( 7,7,5,5 ) )
		plot ( MCGSall[, colnumflow]/1000, mc_out[,37], main = "", ylab = "RMSE (Lambourn)", xlab = "Flow (megalitres per day)", cex.axis = 2, cex.lab = 2, ylim = c ( 0, 30 ), xlim = c ( 50, 200 )  )
		
	PngOff()

	pngfilename= paste ( "flow_vs_rmse_lambourn_at_", gs_name, "MCrun_", run_number, ".png", sep = "" )
	pngfilename= paste ( "flow_vs_rmse_boxford_at_", gs_name, "MCrun_", run_number, ".png", sep = "" )
	PngOn( outfile = paste ( "flow_vs_rmse_boxford_at_", gs_name, "MCrun_", run_number, ".png", sep = "" ))


		par ( mar = c ( 7,7,5,5 ) )
		plot ( MCGSall[, colnumflow]/1000, rmse_boxford, main = "", ylab = "RMSE (Boxford)", xlab = "Flow (megalitres per day)", cex.axis = 2, cex.lab = 2, ylim = c ( 0, 8 )   )
		
	PngOff()

	pngfilename= paste ( "rmse_all_vs_rmse_boxford_MCrun_", run_number, ".png", sep = "" )
	PngOn( outfile = paste ( "rmse_all_vs_rmse_boxford_MCrun_", run_number, ".png", sep = "" ))

		par ( mar = c ( 7,7,5,5 ) )

		plot ( mc_out[,37], rmse_boxford, main = "", ylab = "RMSE (Boxford)", xlab = "RMSE (Lambourn)", cex.axis = 2,
		cex.lab = 2, ylim = c ( 0, 8 ), xlim = c ( 0, 30 ) )
		
	PngOff()

	}
