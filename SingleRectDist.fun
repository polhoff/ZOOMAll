SingleRectDist = function ( x, y = 10 )

	{
	
	x_lower = x / y
	
	x_upper = x * y
	
	value = sample ( x_lower : x_upper, 1 )

	return (value)
		
	}
