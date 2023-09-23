
#Sun definition
#You can right your own
#sqrt(x-mean(x))


CalcRMSE = function ( in_matrix, in_mean_values )

	{

	mc_out_matrix = t(as.matrix( in_matrix))
	lmb_diff = t(mc_out_matrix - in_mean_values)

	#this gives the mean of the squared errors
	x1 = function ( x ) (sum(x^2) / length ( x ))
	#x1 = function ( x ) (sum(x^2) / (length ( x )-1))
	lmb_squared = apply ( lmb_diff, 1, x1 )
	
	lmb_rmse = lmb_squared ^ 0.5

	return ( lmb_rmse )

	}

