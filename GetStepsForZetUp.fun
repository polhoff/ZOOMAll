#j is column number, which is xloc i is row number which is yloc
#xlocinit ylocinit is any [i,j] where 1000
#j and i is any one of the [i,j]s adjacent to [ylocinit, xlocinit]
GetStepsForZetUp = function(xlocinit, ylocinit, j, i, m_matrix)

	{

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
