GetMapEg1 = function ( subdata )

	{

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
	assign (   paste ( "aa_map", mapvariable, layer, sep="" ),   cutnoise1, inherits = TRUE  )

	return ( cutnoise1 )

	rm ( analvar, cutnoise1, cutvec, mat, subdata, subdata.ppp, xhi, xlow, yhi, ylow )

	}

Wait(wait)

listobject = ListNewObjects(listobject)

aa = GetMap1(gridnumber = "gl2", variable = "syield")
plot(aa)
points(boundary1)
