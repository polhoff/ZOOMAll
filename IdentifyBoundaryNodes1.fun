
IdentifyBoundaryNodes1 = function ( input_matrix )

	{
	
	zzz = input_matrix
	
	xdim =  nrow ( zzz  )
	ydim =  ncol ( zzz  )
	
	#+2 because the edge of the matrix maybe the boundary
	#compare the following
	test_each_node = matrix ( nrow = xdim, ncol = ydim )
	test_each_node = matrix ( 0, nrow = xdim, ncol = ydim )
	
	#check boundaries first
	test_each_node[1,] = 1 * !is.na ( zzz[1,] )
	test_each_node[,1] = 1 * !is.na ( zzz[,1] )
	test_each_node[ , ncol (test_each_node) ] = 1 * !is.na ( zzz[ , ncol (zzz)] )
	test_each_node[ nrow (test_each_node),  ] = 1 * !is.na ( zzz[ nrow (zzz), ] )
	
	
	for ( i in 2:(xdim-1) )
	#for ( i in 1:xdim )
	
		{
		
		for ( j in 2: (ydim-1) )
		#for ( j in 1:ydim )
		
			{
			
			a1 = zzz[i,j]

			a2 = zzz[i-1,j]

			a3 = zzz[i+1,j]

			a4 = zzz[i,j-1]

			a5 = zzz[i,j+1]
						
			#diagonals
		
			a6 = zzz[i+1,j+1]

			a7 = zzz[i-1,j+1]

			a8 = zzz[i-1,j-1]

			a9 = zzz[i+1,j-1]
			
			
			if ( !is.na ( a1 ) ) { test_each_node [i,j] = 1 }
			
			#these are at the boundaries of the matrix and therefore must be boundary nodes
			if ( i != 1 & i != xdim & j != 1 & j != ydim )
			
				{
				
				if ( !is.na ( mean (   c ( a2,a3,a4,a5,a6,a7,a8,a9 )   ) ) ) { test_each_node [i,j] = 2 }

				}
		
			}
		}
	
	x1 = as.vector ( test_each_node )
	
	base_grid = expand.grid ( as.numeric ( rownames ( zzz ) ),  as.numeric ( colnames ( zzz ) ) )

	x1 = cbind ( base_grid, x1 )
	
	names ( x1 ) = c ( "yloc", "xloc", "test_in_poly" )
	
	return ( x1 )
	
	}

listobject = ListNewObjects(listobject)









