#j is column number, which is xloc i is row number which is yloc
#xlocinit ylocinit is any [i,j] where 1000
#m_matrix is any two column matrix of x and y coordinates. No starting position needs to be specified
GetStepsForZetUp = function ( x_spacing = 500, y_spacing = 500, m_matrix)

	{

	cycle_through_distances = matrix ( c ( 0, y_spacing, x_spacing, 0, 0, -y_spacing, -x_spacing, 0 ), ncol = 2, byrow = TRUE )
	#expand.grid ( c ( x_spacing, -x_spacing ), c ( y_spacing, -y_spacing ) )

	v_move = c("n 1","e 1","s 1","w 1")

	first_point = m_matrix[1,]
	
	m_matrix_new = m_matrix[ c ( 2:length ( m_matrix[,1]), 1 ), ]

	i = length ( m_matrix[,1] )

	reference_point = first_point

	boundary_steps = NULL

	while ( i > 0 )

		{
	
		l_found = FALSE
	
		j = 0
		
		while ( l_found == FALSE)
			
			{
		
			j = j + 1
	
			test_point = reference_point + cycle_through_distances[j,]
	
			distance = ( test_point[1] - m_matrix_new[,1] ) ^ 2 + ( test_point[2] - m_matrix_new[,2] ) ^ 2
			
			print ( min ( distance ) )
			
			if ( min ( distance ) == 0 )
			
				{
				
				boundary_steps[length ( boundary_steps ) + 1] = v_move[j]
				
				reference_point = m_matrix_new[ which ( distance == 0 ), ]
				
				m_matrix_new = m_matrix_new[- (which ( distance == 0 )), ]
			
				l_found = TRUE
			
				}
				
			#j = (j + 1)%%4 + 1
			
			}
		
		i = i - 1
		
		}

















	n_obs = as.vector(m_matrix)
	n_obs = length(n_obs[n_obs==1000])
	#add another row because first row is starting position
	n_obs = n_obs + 1
	#v_out = cbind(rep("xxx",n_obs),  rep("1", n_obs), rep(0, n_obs), rep(0, n_obs), rep(0, n_obs) )
	v_out = cbind(rep("xxx",n_obs), rep(0, n_obs), rep(0, n_obs) )
	v_move = c("n 1","e 1","s 1","w 1")
	#v_move = c("n","e","s","w")

	xold=xlocinit;  yold=ylocinit
	#do not know why +5 just works
	v_out[1,1] = paste ( xlocinit, " ", (ylocinit+5), sep = "" )

	for (t in 2:n_obs)

		{
		
		v_comp = c(	m_matrix[i-1,j]==1000,
				m_matrix[i,j+1]==1000,
				m_matrix[i+1,j]==1000,
				m_matrix[i,j-1]==1000
				)
				
		v_locold = c(i - yold==1, j-xold==-1, i-yold==-1,j-xold==1)
		l_pick = !v_locold & v_comp
		
		
		v_out[t,1] = v_move[l_pick]
		#v_out[t, 3:4] = c(i,j)
		v_out[t, 2:3] = c(i,j)
		#v_out[t, 5] = paste ( v_out[t,1], v_out[t,2], sep = " " )
		xold = j; yold=i
		
		j = j + c(0,1,0,-1)[l_pick]

		i = i + c(-1,0,1,0)[l_pick]
		
		}

	return (v_out)

	}

#GetStepsForZetUp ( 17,6,17,5, gl1withbnd )
