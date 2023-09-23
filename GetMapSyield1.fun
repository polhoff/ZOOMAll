GetMapSyield1 = function ( gridnumber = "gl1", layer = "01", variable = "syield", x_min = 0, x_max = 2.87 )
	{

	mapvariable = paste ( variable, layer, sep="")

	analvar = match ( mapvariable, names ( rgmdlsub ) )

	table ( rgmdlsub$syield01 )

	subdata = as.data.frame ( rgmdlsub [rgmdlsub$noflow01!="o",] )
	subdata = as.data.frame ( subdata [subdata$glx == gridnumber, c (1:2,analvar)])
	#subdata = subdata [subdata$glx == gridnumber, c (1:2,analvar)]
	subdata = subdata[!is.na(subdata[,3]),]
	subdata = subdata[subdata[,3]!=-999,]
	

	names(subdata) = c("x","y","z")

	x1 = table ( rgmdlsub[c("syield01")] )
	x2 = table ( rgmdlsub[c("syield02")] )
	x3 = table ( rgmdlsub[c("syield03")] )

	all_values = as.numeric ( c ( names(x1), names(x1), names(x3) ) )
	x = unique ( all_values [all_values!=-999] )

	
	x_min = min ( floor (x) )
	x_max = max ( x )
	
	mat= t(tapply(subdata[,3],subdata[,-3],sum))
	
	#compare these both are possible
	cutvec = cut( mat, seq ( x_min, x_max, by = 0.01 ) )
	#cutvec = x
	
	
	cutnoise1 <- im(cutvec, xcol = sort ( unique(subdata[,1]) ), yrow =  sort ( unique(subdata[,2])) )
	#cutnoise1 <- im( mat, xcol = sort ( unique(subdata[,1]) ), yrow =  sort ( unique(subdata[,2])) )

	object_name = paste ( "map", mapvariable, "_", gridnumber, sep="" )

	x = list ( object_name, length(table(cutvec)), cutnoise1 )
	#x = list ( object_name, length(x), cutnoise1 )

	return ( x )
	}

Wait(wait)

listobject = ListNewObjects(listobject)

x = GetMapSyield1()
