TwoRectDist1 = function ( x, y = 10, l_bimodal = TRUE )
	{

	x_lower = x / y
	x_upper = x * y
	

	if (l_bimodal)
		{
		#choose where to sample from
		pick = runif(1)
		#probability of selecting from lower distribution is y times that of selecting from upper
		#i.e. y / (y+1) divided by 1/ (y+1) which is y
		if ( pick < ( y / ( y + 1 ) ) )
		
			{
			value = sample ( x_lower:x, 1 )
			}
			
		else
			{
			value = sample ( x:x_upper, 1 )
			}
			
		#return ( value )
		}
	
	#otherwise
	else { value = sample ( x_lower : x_upper, 1 ) }
	return ( value )
	}

x_test = rep (NA,100)

for ( i in 1:1000 )
	{
	x_test[i] =  TwoRectDist1 (100, 10 )
	}

hist (x_test)


for ( i in 1:1000 )
	{
	x_test[i] =  TwoRectDist1 (100, 10, l_bimodal = F )
	}

hist (x_test)
