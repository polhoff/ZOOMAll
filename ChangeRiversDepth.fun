#source ( paste ( "C:/BGS/Simon/azoom/FREE_RegMod/rscripts/", "SetEnv.R", sep="" ) )
source ( paste ( dirscript, "ImportFunctions.R", sep="" ) )

dirdata = "GWModelling/GroundwaterModel/Regional_model/FM_3L_V2/FM_3L_V2_TV_100/Run1/"
dirdata = paste ( dirroot, dirdata, sep="" )

dirDTM = "/GIS/DTM/"
dirDTM = paste ( dirroot, dirDTM, sep="" )

dirrivers = paste ( dirroot, "azoom/FREE_RegMod/paramfiles/rivers/", sep = "" )

#dirintrst = "FM_3L_V2/FM_3L_V2_TV_500/"

#dirbase = paste ( dirroot, dirtop1, dirintrst, sep = "" )


ChangeRiverDepth = function ( specified_nodes, input_dir = dirdata, output_dir = dirdmp, river_input_file, x_factor, river_output_file )

	{

	rivers = readLines(paste ( input_dir, river_input_file, sep = "" ) )

	#look for ---- but discard first occurrence
	ndx = grep("----", rivers)[-1]

	#these are the lines we are interested in
	ndx1 = ndx + 1
	ndx2 = ndx + 2


	rivers_sub = textConnection ( rivers[ndx1] )

	rivers_nodes = read.table ( rivers_sub )

	lamb_nodes_100 = 307:562

	#gives the position of the shorter vector in the longer one
	x = match (lamb_nodes_100, rivers_nodes[,1] )

	rivers_nodes_lamb = rivers_nodes[ x, ]

	names ( rivers_nodes_lamb ) = c ("node", "branch", "xloc", "yloc" )

	plot(rivers_nodes_lamb$xloc, rivers_nodes_lamb$yloc )
	points ( elev_new[,2], elev_new[,3], pch = "+", col ="red" )

	#tells you which nodes in rivers.dat are nearest neighbours for the Lambourn ArcVIEW river points
	y = knn ( rivers_nodes_lamb[,3:4], elev_new[,2:3], 1:length(rivers_nodes_lamb[,1] ) )

	#tells you which points from the Lambourn ArcVIEW river points are nearest nearest neighbours for rivers_nodes_lamb
	z = knn ( elev_new[,2:3], rivers_nodes_lamb[,3:4], 1:length(elev_new[,1]) )

	
	


	#which ( rivers_nodes[,1] == specified_nodes )

	river_ndx = which ( !is.na( match ( rivers_nodes[,1], specified_nodes ) ) )

	#ndx = ndx + 2

	rivers_sub = textConnection ( rivers[ndx2] )

	rivers_file = read.table ( rivers_sub )

	#set width to ten metres
	
	rivers_file[river_ndx,3] = rivers_file[river_ndx,3] * x_factor
	
	#return ( rivers_file )

	write.table ( rivers_file, textConnection ("aa", open = "w" ), col.names = FALSE, row.names = FALSE )

	print(head(aa))

	print(head(rivers,20))

	#replace original values with new values
	rivers[ndx2] = aa

	print(head(rivers,20))

	#write new rivers to file

	write ( rivers, file = paste ( output_dir, river_output_file, ".dat", sep = "" ) )

	close ( rivers_sub )
	
	close ( "aa" )
	
	rm(aa)

	print ("here")
	
	close ( "aa" )
	
	}
