#this interpolates given an already existing experimental and fitted variogram

InterpHeadKrig = function ( data_source = data_sub, data_sample_ndx, n_type = 2, n_poly = 3, l_plot = TRUE, outdir = dirdmp, n_degree = 2, c_m = "powered.exponential", n_sill = 2900, n_range = 20000, n_kappa1 = 1.5, obj_model )
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

		x = cbind ( xy_locs, z )

		x1_sample = as.geodata ( x ) 

		x2.fit.krige <-krige.control(obj.model = obj_model)

		x2.fit.krige.output = krige.conv (x1_sample, locations = expand.grid ( xlocs_interp, ylocs_interp), krige = x2.fit.krige)

		#x2.fit.krige.output1 = tapply ( x1$coords,  x2.fit.krige.output$predict, sum )
		x2.fit.krige.output1 = tapply (  x2.fit.krige.output$predict, list( xlocs_interp, xlocs_interp,  sum )

		xx1 = list ( as.numeric ( rownames ( x2.fit.krige.output1 ) ), as.numeric ( colnames ( x2.fit.krige.output1 ) ), x2.fit.krige.output1 )
		
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






		
		if (l_plot)
			{
			
			PngOn (outfile = paste ("contour_", c_year, "_", c_mnth, ".png", sep = ""), outdir = bodge_outdir, x = TRUE)
				#par ( ask = TRUE )
				contour ( xx1, nlevels = 30, cex.lab = 1.6, cex.axis = 1.6, labcex = 1.6  )
				points ( river_xycoords[,3], river_xycoords[,4], col = "blue", pch = "+" )
				legend ( "topleft", paste ( c_mnths[c_mnth_ndx], c_year ), cex = 1.6 )
			PngOff ( x = TRUE)
			
			#persp ( xx1, nlevels = 30, cex.lab = 1.6, cex.axis = 1.6 )
			PngOn (outfile = paste ("persp_", c_year, "_", c_mnth, ".png", sep = ""), outdir = bodge_outdir, x = TRUE)
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
		
	
	par = oldpar

	return ( output_data )
	}
