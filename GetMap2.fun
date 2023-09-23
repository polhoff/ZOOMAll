GetMap2 = function ( gridnumber = "gl1", layer = "01", variable = "hydcond" )

	{

	mapvariable = paste ( variable, layer, sep="")

	analvar = match ( mapvariable, names ( rgmdlsub ) )

	subdata = as.data.frame ( rgmdlsub [rgmdlsub$glx == gridnumber, c (1:2,analvar)] )
	
	xlow = min(subdata[,1])
	xhi = max(subdata[,1])
	ylow = min(subdata[,2])
	yhi = max(subdata[,2])
	
	names(subdata) = c("x","y","z")
	
	subdata.ppp = ppp(subdata$x, subdata$y, window = owin(c(xlow,xhi),c(ylow,yhi)),marks = subdata$z)
	
	mat= t(tapply(subdata[,3],subdata[,-3],sum))
	
	cutvec = cut(mat,c(0,unique(subdata[,3])))

	cutnoise1 <- im(cutvec, xcol = sort ( unique(subdata[,1]) ), yrow =  sort ( unique(subdata[,2])) )
	#assign (   paste ( "map", grids[j], names(rgmdlsub)[analvar], sep="" ),   cutnoise1   )
	assign (   paste ( "map", mapvariable, "_", gridnumber, sep="" ),   cutnoise1, inherits = TRUE   )



	rm ( analvar, cutnoise1, cutvec, mat, subdata, subdata.ppp, xhi, xlow, yhi, ylow )

	}

Wait(wait)

listobject = ListNewObjects(listobject)

