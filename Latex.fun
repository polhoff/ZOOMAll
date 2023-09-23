Lt = function ( dirin = paste ( dirtop, "essay/", sep = "" ))
	{
	
	setwd(dirin)

	miktex_with_path = "C:/Program Files/MiKTeX 2.8/miktex/bin/pdflatex"
	gsview_with_path = "C:/Program Files/Ghostgum/gsview/gsview32"
	bibtex_with_path = "C:/Program Files/MiKTeX 2.8/miktex/bin/bibtex"
	
	writer_tex = paste ( writer_base, ".tex", sep = "" )
	writer_pdf = paste ( writer_base, ".pdf", sep = "" )


	c_out = paste ('"', miktex_with_path, '"  ', paste (dirin, writer_tex, sep = "" ), sep = "" )
	write ( c_out, file = paste ( dirdmp, "d.bat", sep = "" ) )
	system ( paste ( dirdmp, "d.bat", sep = "" ) )
	print ( paste ("output to ", dirdmp, sep = "" ) )


	c_out = paste ('"', bibtex_with_path, '"  ', paste (dirin, writer_tex, sep = "" ), sep = "" )
	write ( c_out, file = paste ( dirdmp, "d.bat", sep = "" ) )
	system ( paste ( dirdmp, "d.bat", sep = "" ) )
	print ( paste ("output to ", dirdmp, sep = "" ) )

	c_out = paste ('"', miktex_with_path, '"  ', paste (dirin, writer_tex, sep = "" ), sep = "" )
	write ( c_out, file = paste ( dirdmp, "d.bat", sep = "" ) )
	system ( paste ( dirdmp, "d.bat", sep = "" ) )
	print ( paste ("output to ", dirdmp, sep = "" ) )

	c_out = paste ('"', gsview_with_path, '"  ',paste (dirin, writer_pdf, sep = "" ), sep = "" )
	write ( c_out, file = paste ( dirdmp, "d.bat", sep = "" ) )
	system ( paste ( dirdmp, "d.bat", sep = "" ) )
	print ( paste ("output to ", dirdmp, sep = "" ) )

	}

listobject = ListNewObjects(listobject)
