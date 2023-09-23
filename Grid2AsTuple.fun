
GridAsCols = function (x1, y1, x2, y2, gridstep )

	{

	xloc = seq(x1,x2,by = gridstep)
	yloc = seq(y1,y2,by = gridstep)

	xy = expand.grid(xloc,yloc)

	gridascols = as.data.frame( xy[order(-xy[,2],xy[,1]),] )

	names(gridascols) = c("xloc","yloc")

	return (gridascols)

	}

Wait(wait)

listobject = ListNewObjects(listobject)

