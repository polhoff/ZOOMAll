
ReadCatchmentArea = function ( inputdir = paste ( dirtop, "GWModelling/area_2011_03_25/", sep = "" ), c_suffix = run_number)
	{
	filename = paste ( "area_lmb_core_series", c_suffix, ".dat", sep = "")
	x = read.table ( paste ( inputdir, filename, sep = "" ), stringsAsFactors = F, header = TRUE )
	x[,1] = as.POSIXct(x[,1])
	#x[1] = as.POSIXct(x[1])
	#x[1] = as.Date(x[1])
	#x[2] = as.numeric(x[2])
	x[,2] = as.numeric(x[,2])
	assign ( paste ( "area_lmb_core_series", c_suffix, sep = "" ), x, .GlobalEnv)
	}

listobject = ListNewObjects(listobject)

#ReadCatchmentArea ()
