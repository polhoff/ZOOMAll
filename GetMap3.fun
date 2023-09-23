GetMap3 = function ( xlocmin = 436000, xlocmax = 450000, ylocmin = 166000, ylocmax = 180000, gridnumber = "gl1", layer = "01", variable = "hydcond" )

	{

	mapvariable = paste ( variable, layer, sep="")

	analvar = match ( mapvariable, names ( rgmdlsub ) )

	subdata = rgmdlsub[rgmdlsub$xloc > xlocmin & rgmdlsub$xloc < xlocmax,]

	subdata = subdata[subdata$yloc > ylocmin & subdata$yloc < ylocmax,]

	subdata = as.data.frame ( subdata  [subdata$glx  == gridnumber, c (1:2,analvar)] )

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
	assign (   paste ( "map", mapvariable, "_GetMap3", sep="" ),   cutnoise1, inherits = TRUE   )

	return ( cutnoise1 )

	rm ( analvar, cutnoise1, cutvec, mat, subdata, subdata.ppp, xhi, xlow, yhi, ylow )

	}

Wait(wait)

listobject = ListNewObjects(listobject)

aa = GetMap3(gridnumber = "gl2", variable = "syield")
plot(aa)
points(boundary1)

