ReadRiversDDat = function ( dir_this = paste ( dirdata, "zetup/", sep = "") )

	{

	x = readLines ( paste ( dir_this, "rivers.dat", sep="" ) )
	x1 = paste ( dir_this, "rivers.dat", sep="" )

	z = count.fields ( x1 )
	summary (z )
	table ( z )

	#output might be....... 
	#z
	#  1   2   3   4   7 
	#126 121   1 122 122 


	#Get those line numbers from rivers.dat which show xy coordinates
	xycoords = which(z==4)

	#Get those line numbers from rivers.dat which show elevation and stage
	elev_and_stage = which(z==7)

	#subset those lines of rivers.dat which contain coordinates
	x2 = x[xycoords]
	z = textConnection ( x2 )
	assign ( "rivers_xycoords", read.table ( z, header = FALSE), inherits = TRUE )
	
	
	#subset those lines of rivers.dat which contain elevation and stage
	x2 = x[elev_and_stage]
	z = textConnection ( x2 )
	assign ( "rivers_elevation", read.table ( z, header = FALSE), envir = .GlobalEnv )
	
	
	}

ReadRiversDDat()

listobject = ListNewObjects(listobject)
