#this fits a variogram and then interpolates using that variogram

InterpHeadFitVarKrig = function ( data_source = data_sub, l_plot = TRUE, outdir = dirdmp, c_m = "powered.exponential", n_sill = 2900, n_range = 20000, max_dist = 20000, n_kappa1 = 1.5 )

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
	#j=2
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

		x2 = variog(x1_sample, breaks = seq(0,10, by = .1)*10^4 )
		
		x2.fit = variofit(x2, ini.cov.pars = c ( n_sill, n_range ), cov.model = c_m, weights = "npairs", messages = TRUE, fix.nugget = TRUE, kappa = n_kappa1, max.dist = max_dist)

		x2.fit.krige <-krige.control(obj.model = x2.fit)

		x2.fit.krige.output = krige.conv (x1_sample, locations = expand.grid ( xlocs_interp, ylocs_interp), krige = x2.fit.krige)

		#can contour direct but seemingly no control over plot size
		contour(x2.fit.krige.output, nlevels = 30, labcex = 1.6, xlim = c ( 435000, 440000))

		x2.fit.krige.output1 = tapply (  x2.fit.krige.output$predict, expand.grid( xlocs_interp, ylocs_interp),  sum )

		xx1 = list ( as.numeric ( rownames ( x2.fit.krige.output1 ) ), as.numeric ( colnames ( x2.fit.krige.output1 ) ), x2.fit.krige.output1 )
		names(xx1) = c ( "x", "y", "z" )

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
