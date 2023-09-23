InterpHead = function ( data_source = data_sub, n_type = 2, n_poly = 3, l_plot = TRUE, outdir = dirdmp, n_degree = 2, n_span = 0.25, l_normalize = TRUE, c_m = "powered.exponential", n_sill = 2900, n_range = 20000, n_kappa1 = 1.5, n_theta = 100, n_lambda )
	{

	bodge_outdir = outdir
	

	c_mnths =  c ( "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")





	grid_list = list ( xlocs_interp, ylocs_interp )

	oldpar = par ()

	pars1 = c ( 35, -20 )
	pars1a = c ( 45, -90 )
	pars1b = c ( 45, -20 )
	pars2 = c ( 225, 90 )
	pars2a = c ( 225, 40 )

	par_set = pars1b

	#for ( j in 2)
	#for ( j in 1:2)
	#for ( j in 1:30)
	for ( j in 1:length(data_source[,1]) )
		{
		#l_ask = par ( "ask" )
		z = as.numeric (data_source[j,name_ndx])
		c_year = format ( as.POSIXct (data_source[j,1]), "%Y")
		c_mnth = format ( as.POSIXct (data_source[j,1]), "%m")
		c_mnth_ndx = as.numeric ( format ( as.POSIXct (data_source[j,1]), "%m") )

		
		if(n_type == 1)
			{
			x1 = Krig( xy_locs, z, m = n_poly )
			xx1 = predict.surface(x1, grid.list = grid_list)
			xx2 = predict.Krig(x1)
			}
			
		if(n_type == 2)
			{
			x1 = Tps( xy_locs, z, m = n_poly )
			xx1 = predict.surface(x1, grid.list = grid_list)
			}
		
		if(n_type == 3)
			{
			xx1 = interp(x,y,z, xo = xlocs_interp, yo = ylocs_interp)
			}
		
		if(n_type == 4)
			{
			xx1 = interp(x,y,z, xo = xlocs_interp, yo = ylocs_interp, linear = FALSE)
			}

		if(n_type == 5)
			{
			x1 <- loess (z ~ x * y, degree = n_degree, span = n_span, normalize = l_normalize )
			xx1 = predict.surface(x1, grid.list = grid_list)
			}

		if(n_type == 6)
			{
			x1 = Krig( xy_locs, z, m = n_poly, theta = n_theta, Covariance =  c_m )
			xx1 = predict.surface(x1, grid.list = grid_list)
			xx2 = predict.Krig(x1)
			}

		if(n_type == 7)
			{
			x1 = Tps( xy_locs, z, m = n_poly, lambda = n_lambda )
			xx1 = predict.surface(x1, grid.list = grid_list)
			}

		if(n_type == 8)
			{
			x1 = Krig( xy_locs, z, m = n_poly )
			xx1 = predict.surface(x1, grid.list = grid_list)
			xx2 = predict.Krig(x1)
			}

		if(n_type == 9)
			{
			x1 = krige ( xy_locs, z, m = n_poly )
			xx1 = predict.surface(x1, grid.list = grid_list)
			xx2 = predict.Krig(x1)
			}



		
		if (l_plot)
			{
			
			PngOn (outfile = paste ("contour_", c_year, "_", c_mnth, ".png", sep = ""), outdir = paste ( bodge_outdir, "fig/contour/", sep = ""), x = TRUE)
				#par ( ask = TRUE )
				par ( mar = c ( 7,6,4,5))
				contour ( xx1, nlevels = 30, cex.lab = 1.6, cex.axis = 1.6, labcex = 1.6  )
				points ( river_xycoords[,3], river_xycoords[,4], col = "black", pch = "+" )
				legend ( "topleft", paste ( c_mnths[c_mnth_ndx], c_year ), cex = 1.6 )
				polygon ( lambourn_poly72, lty = 2 )
			PngOff ( x = TRUE)
			
			#persp ( xx1, nlevels = 30, cex.lab = 1.6, cex.axis = 1.6 )
			PngOn (outfile = paste ("persp_", c_year, "_", c_mnth, ".png", sep = ""), outdir = paste ( bodge_outdir, "fig/persp/", sep = ""), x = TRUE)
				persp( xx1, theta = par_set[1], phi = par_set[2], zlim = c ( 70,150 ))
			PngOff ( x = TRUE)
			
			}
		
		xy_locs_output = expand.grid ( round (xx1$x,2), round (xx1$y,2) )
		
		out1 = round ( as.numeric ( xx1$z ), 1 )
		
		output_data = cbind ( xy_locs_output, out1, out1, out1 )
		output_data = output_data [ !is.na ( output_data[,3] ), ]
		#names ( output_data ) = c ( "xloc", "yloc", "h1" )
		write.table ( output_data, file = paste ( outdir, contour_names[j], ".txt", sep = "" ), row.names = FALSE, col.names = F )
		}

	a1 <- rep ( NA, 11 )
	a1[1] <- try(n_type)
	a1[2] <- try(n_poly)
	a1[3] <- try(n_degree)
	a1[4] <- try(n_span)
	a1[5] <- try(c_m)
	a1[6] <- try(n_sill)
	a1[7] <- try(n_range)
	a1[8] <- try(n_kappa1)
	a1[9] <- try(n_theta)
	a1[10] <- try(n_lambda)
	a1[11] <- try(outdir)
	
	write ( a1, paste ( outdir, "interpolate_GWarea_parameters.dat", sep = "" ) )
		
	par = oldpar

	return ( output_data )
	}
