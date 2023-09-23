ReadZoomData = function ( x, inputdir = dirazoom )

	{
	
	output = read.table ( paste ( inputdir, x, sep = "" ), header = TRUE, stringsAsFactors = FALSE )
	
	}

BX_10m_3L = ReadZoomData ("BX_10m_data.dat")
	
	


