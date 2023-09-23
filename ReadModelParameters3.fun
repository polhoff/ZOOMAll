RMP = function( x )

	{

	parvalsmeta = read.csv(paste(dirzoomout,"parameterdatabase_metadata.csv",sep=""))

	for(i in x)

		{
		
		parvals = read.csv(paste(dirzoomout,"parameterdatabase.csv",sep=""))[i,]

		attach(parvals)

		#print(sorval)

		print ("parvals old is")		
		print (t( parvals ))
		
		#previously this was -c(1,2)
		for ( j in names (parvals)[-c(1)] )

			{

			#for each name in parameter database, get the corresponding row numbers from metadata
			a1 = grep ( j, parvalsmeta[,1] )

			#subset those row numbers
			a2 = parvalsmeta[a1,]

			#extract the value of j and assign to a3
			# (e.g. if j is mesh, then get(j) might be 2 and a3 might be "coarse"
			a3 = a2 [ parvals [j][1,1] , 3]
			
			a3 = as.character ( a3 )
	
			
			#overwrite the code number for j with the value for j
			parvals[j]  =  a3

			}

		print(j)
		print ("parvals new is")
		print (t( parvals ))

		write ( t(parvals), file = paste ( dirzoomout, "parvals.tx", sep="") )

		detach ( parvals )

		}

	return ( parvals )

	}

