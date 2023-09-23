InterpHeadLoess = function ( data_source = data_sub, n_type = 1, n_degree = 2, n_span = 0.25, l_normalize = TRUE, l_plot = TRUE, outdir = dirdmp )
	{

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


		x1 <- loess (z ~ x * y, degree = n_degree, span = n_span, normalize = l_normalize )
		xx1 = predict.surface(x1, grid.list = grid_list)


		
		if(n_type == 1)
			{
			
			topo.mar <- list ( x = seq ( 0, 6.5, 0.2 ), y = seq ( 0, 6.5, 0.2) )
			topo.lo <- predict ( topo.loess, expand.grid ( topo.mar))
			contour ( topo.mar$x, topo.mar$y, topo.lo )



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
		
				
		if (l_plot)
			{
			par ( ask = TRUE )
			contour ( xx1, nlevels = 30, cex.lab = 1.6, cex.axis = 1.6 )
			points ( river_xycoords[,3], river_xycoords[,4], col = "blue", pch = "+" )
			#persp ( xx1, nlevels = 30, cex.lab = 1.6, cex.axis = 1.6 )
			persp( xx1, theta = par_set[1], phi = par_set[2], zlim = c ( 70,150 ))
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
