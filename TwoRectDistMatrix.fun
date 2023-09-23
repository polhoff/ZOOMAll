TwoRectDistMatrix = function ( x, y = 10 )

	{
	
	x_lower = x / y
	
	x_upper = x * y
	
	#choose where to sample from
	pick = runif (length(x)) 
	#probability of selecting from lower distribution is y times that of selecting from upper
	#i.e. y / (y+1) divided by 1/ (y+1) which is y
	
	l_top = pick < ( y / ( y + 1 ) )
	
	n_value = rep ( NA, length(x) )
	
	n_value[l_top] = sample ( x_lower:x, 1 )
	
	if ( pick < ( y / ( y + 1 ) ) )
	
		{
		
		value = sample ( x_lower:x, 1 )
		
		}
		
	else
	
		{
	
		value = sample ( x:x_upper, 1 )
	
		}
		
	return ( value )
	
	}
