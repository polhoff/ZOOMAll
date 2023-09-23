RMP = function(x)

	{

	parvalsmeta = read.csv(paste(dirinp,"parameterdatabase_metadata.csv",sep=""))

	for(i in x)

		{

		parvals = read.csv(paste(dirinp,"parameterdatabase.csv",sep=""))[i,]

		#print(sorval)

		print ("parvals old is")		
		print (t( parvals ))

		for ( j in names (parvals)[-c(1,2)] )

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

		#print(j)
		#print ("parvals new is")
		#print (t( parvals ))

		}

	return ( parvals )

	}

