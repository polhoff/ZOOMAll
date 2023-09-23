
LoadModelDataSet = function ( inputdir = dirFM_500m_3L, filename =  paste ( "FREEmodelconfig_", run_number, ".Rdata", sep = "") )
	{
	load ( paste ( inputdir, filename, sep = "" ) , .GlobalEnv)
	}

listobject = ListNewObjects(listobject)
