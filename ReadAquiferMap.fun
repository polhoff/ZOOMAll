ReadAquiferMap = function ( inputdir = dirdata )

	{

	print ( ls() )

	x = readLines ( paste ( inputdir, "aquifer.map", sep = "" ) )

	#x1 = x[which(nchar(x)>0)]

	blocks_ndx = grep ("-", x )
	numbers_ndx = grep ("[0-9]", x )
	numbers_ndx = c ( numbers_ndx, length ( x ) + 1 ) 
	
	base_grid = NULL
	
	for ( i in 1: ( length ( numbers_ndx ) - 1 )) 
	#for ( i in 1 ) 
		{
		
		i_ndx = numbers_ndx[i]
		
		y = unlist ( strsplit ( x[i_ndx], "" ) )
		
		y1_ndx = grep ("[0-9]", y )
		
		y2_ndx = y1_ndx [ -1 ]
		
		x_left = as.numeric ( paste ( y[y2_ndx][1:6], collapse = "" ) )
		
		x_right = as.numeric ( paste ( y[y2_ndx][13:18], collapse = "" ) )
		
		y_bottom = as.numeric ( paste ( y[y2_ndx][7:12], collapse = "" ) )
		
		y_top = as.numeric ( paste ( y[y2_ndx][19:24], collapse = "" ) )
		
		x_cols = nchar ( x [ i_ndx + 1 ] )
		
		x_spacing = (x_right - x_left) / (x_cols - 1)
		
		y_rows = numbers_ndx[i+1] - numbers_ndx[i] - 1
		
		y_spacing = (y_top - y_bottom) / (y_rows - 1)
	
		z = expand.grid ( seq ( x_left, x_right, x_spacing ), seq ( y_bottom, y_top, y_spacing ) )
		
		z[3] = paste ( "gl", i, sep = "" )
		
		z[4] = x_spacing
		
		z[5] = y_spacing
		
		names ( z ) = c ( "xloc", "yloc", "glx", "x_spacing", "y_spacing" )
		
		assign ( paste ( "gl", i, sep = "" ), z )
		
		base_grid = rbind ( base_grid, z )
	
		assign ( paste ( "gdim", i, sep = "" ), c ( y_rows, x_cols ) )
		
		assign ( paste ( "blockx", i, sep = "" ), c ( x_left, x_right, x_spacing ) )

		assign ( paste ( "blocky", i, sep = "" ), c ( y_bottom, y_top, y_spacing ) )

		}

	grids =  ls() [ grep ( "gl", ls() ) ]

	n_grid = length ( grids )

	rm ( z, i, i_ndx, numbers_ndx, x, y, x_left, x_right, y_top, y_bottom, x_cols, y_rows, x_spacing, y_spacing, y1_ndx, y2_ndx )

	objs <- ls()
	objList <- vector(mode='list', length=length(objs))
	names(objList) <- objs

	for(x in seq(along=objs)) objList[[x]] <- get(objs[x])

	#You could also use save the objects into a file:
	#save(objs, file='objects.Rdata')
	
	return ( objList )
	
	}

listobject = ListNewObjects(listobject)

#aquifer_map = ReadAquiferMap ()
