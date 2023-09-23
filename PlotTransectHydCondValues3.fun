PlotTransectValues = function ( c_type = "hydcond01" )

	{

	#purpose to check by random sampling that K values and Sy values have been assigned at correct coordinates

	#varlist = unique ( varlist [grep ( "hydcond01", varlist) ] )

	#...tail() is to check that the last of the hydcond is actually the same as the original values
	varlistsample = ls()[grep ( c_type, varlist ) ]
	#varlistsample = c ( sample ( varlist, 12 ), tail( varlist, 6 ) )

	for (i in varlistsample )

		{

		subdata = get (i)
		#this row was added because of the addition of glx to the dataframe
		subdata = subdata[subdata$glx=="gl3",-3]
			
		names(subdata) = c("x","y","z")

		xlow = min(subdata[,1])
		xhi = max(subdata[,1])
		ylow = min(subdata[,2])
		yhi = max(subdata[,2])
		
		subdata.ppp = ppp(subdata$x, subdata$y, window = owin(c(xlow,xhi),c(ylow,yhi)),marks = subdata$z)

		mat= t(tapply(subdata[,3],subdata[,-3],sum))
		
		cutvec = cut(mat,c(0,unique(subdata[,3])))

		cutnoise1 <- im(cutvec, xcol = sort ( unique(subdata[,1]) ), yrow =  sort ( unique(subdata[,2])) )

		PngOn(i)

		plot ( cutnoise1 )

		PngOff()	

		Wait(.2)

		}

	}

PlotTransectValues ("hydcond01")
PlotTransectValues ("syield01")

rm ( varlistsample, cutnoise1, cutvec, mat, subdata, subdata.ppp, xhi, xlow, yhi, ylow )

Wait(wait)

listobject = ListNewObjects(listobject)

