ReadRiversDDat = function ( dir_this = paste ( dirdata, "zetup/", sep = ""), river_filename = "rivers.dat" )

	{

	x = readLines ( paste ( dir_this, river_filename, sep="" ) )
	x1 = paste ( dir_this, river_filename, sep="" )

	river_Lines = readLines ( paste ( dir_this, river_filename, sep="" ) )
	river_Lines_length  = length ( river_Lines )
	
	river_Lines_nodes  = as.numeric ( unlist ( strsplit ( river_Lines[4], " " ) )[2] )
	river_Lines_xycoords_ndx = seq ( 6, by = 4, length.out = river_Lines_nodes )
	river_Lines_data_ndx = seq ( 7, by = 4, length.out = river_Lines_nodes )
	river_Lines_connect_ndx = seq ( 8, by = 4, length.out = river_Lines_nodes )
	
	z = textConnection ( river_Lines[river_Lines_xycoords_ndx] )
	river_xycoords = read.table ( z )
	
	z = textConnection ( river_Lines[river_Lines_data_ndx] )
	river_data = read.table ( z )
	
	river_Lines_connect = river_Lines[river_Lines_connect_ndx]
	
	n_rivernodes = river_Lines_nodes
	
	x = list ( river_Lines, n_rivernodes, river_Lines_xycoords_ndx, river_Lines_data_ndx,	river_Lines_connect_ndx,  river_xycoords, river_data,  river_Lines_connect )
		
	return ( x )
	
	}


	
	print ( river_Lines[river_Lines_xycoords] )
	
	print ( river_Lines[river_Lines_data] )


	z = count.fields ( x1 )
	summary (z )
	table ( z )

	#output might be....... 
	#z
	#  1   2   3   4   7 
	#126 121   1 122 122 

	#Get those line numbers from rivers.dat which show xy coordinates
	xycoords = which(z==4)
	xycoords_linenumbers

	#Get those line numbers from rivers.dat which show elevation and stage
	elev_and_stage = which(z==7)

	#subset those lines of rivers.dat which contain coordinates
	x2 = x[xycoords]
	z = textConnection ( x2 )
	assign ( "rivers_xycoords", read.table ( z, header = FALSE) )
	
	#there maybe one line with four fields which does not relate to xy coordinates
	rivers_xycoords = rivers_xycoords[ which(rivers_xycoords[,3] > 100000), ]
		
	#subset those lines of rivers.dat which contain elevation and stage
	x2 = x[elev_and_stage]
	z = textConnection ( x2 )
	assign ( "rivers_elevation", read.table ( z, header = FALSE) )
	
	x = list ( rivers_xycoords, rivers_elevation )

	return ( x )
	
	}

rivers_list = ReadRiversDDat ( dir_this = dirdata )
rivers_xycoords = as.data.frame ( rivers_list[1] )
rivers_elevation = as.data.frame ( rivers_list[2] )

listobject = ListNewObjects(listobject)

print ( length ( rivers_xycoords[,1] ) ) 
print ( length ( rivers_elevation[,1] ) ) 
