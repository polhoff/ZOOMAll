
dirmapGWarea <- paste ( dirtop, "GWModelling/map_GW_area/", sep = "" )



ListMapGWArea <- function ( run_number, n_year, c_month, indir = dirmapGWarea  )
	{
	
	file_list <- list.files ( indir, full.names = TRUE )
	
	x_ndx <- grep ( run_number, file_list)

	new_file_list <- file_list[x_ndx]
	
	return (new_file_list)
	}


#x <- ListMapGWArea ("Run131")




LoadMapGWArea <- function ( file_list )
	{

	for (i in file_list)
		{
		print(i)
		load(i, env = .GlobalEnv)
		}
	}

#LoadMapGWArea (x[c(279,284)])

