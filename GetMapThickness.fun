GetMapThickness = function ( gridnumber = "gl1", variable = "max_thick", n_levels = 12 )

	{

	mapvariable = variable

	analvar = match ( mapvariable, names ( rgmdlsub ) )

	subdata = as.data.frame ( rgmdlsub [rgmdlsub$glx == gridnumber, c (1:2,analvar)] )
	subdata = subdata[!is.na(subdata[,3]),]
	
	
	xlow = min(subdata[,1])
	xhi = max(subdata[,1])
	ylow = min(subdata[,2])
	yhi = max(subdata[,2])
	
	names(subdata) = c("x","y","z")
	
	#subdata.ppp = ppp(subdata$x, subdata$y, window = owin(c(xlow,xhi),c(ylow,yhi)),marks = subdata$z)
	
	mat= t(tapply(subdata[,3],subdata[,-3],sum))
	
	cutvec = cut( mat,c(0,unique(subdata[,3])))
	cutvec = cut( mat, n_levels )

	x_min = min ( subdata[,3] )
	x_min = floor ( x_min / 10 ) * 10
	
	x_max = max ( subdata[,3] )
	x_max = ceiling ( x_max / 10 ) * 10

	cutvec = cut( mat, seq ( x_min, x_max, by = 10 ) )
	
	cutnoise1 <- im(cutvec, xcol = sort ( unique(subdata[,1]) ), yrow =  sort ( unique(subdata[,2])) )
	#assign (   paste ( "map", grids[j], names(rgmdlsub)[analvar], sep="" ),   cutnoise1   )
	#assign (   paste ( "map", mapvariable, "_", gridnumber, sep="" ),   cutnoise1, inherits = TRUE   )

	object_name = paste ( "map", mapvariable, "_", gridnumber, sep="" )

	x = list ( object_name, length(table(cutvec)), cutnoise1 )

	return ( x )
	}

Wait(wait)

listobject = ListNewObjects(listobject)

x_dud = GetMapThickness ( gridnumber = "gl1", "max_thick" )

plot(x_dud, col = gray((1:12)/12))
