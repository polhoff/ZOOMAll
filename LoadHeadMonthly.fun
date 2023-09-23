
LoadHeadMonthly = function ( inputdir = dirFM_500m_3L)
	{
	x = list.files (inputdir)

	filename =  x [ grep ( "contours_mnth", x ) ]
	filename =  filename  [ grep ( "Rdata", filename ) ]
		
	load ( paste ( inputdir, filename, sep = "" ) , .GlobalEnv)
	}

listobject = ListNewObjects(listobject)
