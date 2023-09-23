GetMapHydcond = function ( gridnumber = "gl1", layer = "01", variable = "hydcond", x_min = 0, x_max = 2.87 )
	{

	mapvariable = paste ( variable, layer, sep="")

	analvar = match ( mapvariable, names ( rgmdlsub ) )

	subdata = as.data.frame ( rgmdlsub [rgmdlsub$glx == gridnumber, c (1:2,analvar)] )
	subdata = subdata[!is.na(subdata[,3]),]
	subdata = subdata[subdata[,3]!=-999,]
	subdata[,3] = round (log (subdata[,3], base = 10), 2)

	names(subdata) = c("x","y","z")

	table(subdata[,3])

	x = as.numeric(names(table(subdata[,3])))
	#this is so that all maps have the same scale
	if( layer == "01" )
		{
		x_min = min ( floor (x) )
		x_max = max ( x )
		}
	
	mat= t(tapply(subdata[,3],subdata[,-3],sum))
	
	cutvec = cut( mat, seq ( x_min, x_max, length.out = 11 ) )

	cutnoise1 <- im(cutvec, xcol = sort ( unique(subdata[,1]) ), yrow =  sort ( unique(subdata[,2])) )

	object_name = paste ( "map", mapvariable, "_", gridnumber, sep="" )

	x = list ( object_name, length(table(cutvec)), cutnoise1 )

	return ( x )
	}

Wait(wait)

listobject = ListNewObjects(listobject)

x = GetMapHydcond()
