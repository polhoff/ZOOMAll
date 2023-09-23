ReadRiver = function ( dir_this = paste ( dirdata, "zetup/", sep = ""), river_filename = "rivers.dat" )

	{

	river_Lines = readLines ( paste ( dir_this, river_filename, sep="" ) )
	river_Lines_length  = length ( river_Lines )
	
	z = textConnection ( river_Lines[4] )
	river_Lines_nodes = as.numeric ( read.table ( z )[1,2] )
	
	#river_Lines_nodes  = as.numeric ( unlist ( strsplit ( river_Lines[4], " " ) )[2] )
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
	
	names ( x ) = c ( "river_Lines", "n_rivernodes", "river_Lines_xycoords_ndx", "river_Lines_data_ndx",	"river_Lines_connect_ndx",  "river_xycoords", "river_data",  "river_Lines_connect" )
	
	return ( x )
	
	}

listobject = ListNewObjects(listobject)

