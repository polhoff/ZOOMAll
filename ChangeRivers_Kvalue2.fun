
ChangeRiverK = function ( specified_nodes, input_dir, river_input_file, x_factor, river_output_file, col_num = 5 )

	{

	rivers = readLines(paste ( input_dir, river_input_file, sep = "" ) )

	#look for ---- but discard first occurrence
	ndx = grep("----", rivers)[-1]

	#these are the lines we are interested in
	ndx1 = ndx + 1
	ndx2 = ndx + 2

	#set width to ten metres
	#rivers_file[river_ndx,3] = 10

	rivers_sub = textConnection ( rivers[ndx1] )

	rivers_nodes = read.table ( rivers_sub )

	#which ( rivers_nodes[,1] == specified_nodes )

	river_ndx = which ( !is.na( match ( rivers_nodes[,1], specified_nodes ) ) )

	#ndx = ndx + 2

	rivers_sub = textConnection ( rivers[ndx2] )

	rivers_file = read.table ( rivers_sub )

	#increase K by x_factor
	
	rivers_file[river_ndx, col_num] = rivers_file[river_ndx,5] * x_factor
	
	rivers_file[river_ndx, col_num + 1] = rivers_file[river_ndx,6] * x_factor
	
	#return ( rivers_file )

	write.table ( rivers_file, textConnection ("aa", open = "w" ), col.names = FALSE, row.names = FALSE )

	print(head(aa))

	print(head(rivers,20))

	#replace original values with new values
	rivers[ndx2] = aa

	print(head(rivers,20))

	#write new rivers to file

	write ( rivers, file = paste ( dirout, river_output_file, ".dat", sep = "" ) )

	close ( rivers_sub )
	
	close ( "aa" )
	
	rm(aa)

	print ("here")
	
	close ( "aa" )
	
	}
