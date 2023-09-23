
LoadObswellsOut = function ( inputdir = dirFM_500m_3L, filename =  paste ( "obswellsout_lmb50_", run_number, ".Rdata", sep = "") )
	{
	load ( paste ( inputdir, filename, sep = "" ) , .GlobalEnv)
	}

listobject = ListNewObjects(listobject)
