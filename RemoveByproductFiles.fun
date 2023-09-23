
RemoveByproductFiles = function ( outdir = dirdmp )

	{

	a = list.files ( outdir, full.names = TRUE )

	a1 = grep ( paste ( mapfilelist, collapse = "|"), a )
	
	a2 = a[a1]
	
	a3 = grep ( "dat", a2 )

	a4 = a2[a3]
	
	print ( a4 )

	file.remove ( a4 )






	

	a1 = grep ( "initialh", a )
	
	a2 = a[a1]
	
	a3 = grep ( "0", a2 )

	a4 = a2[a3]
	
	print ( a4 )

	file.remove ( a4 )




	}
