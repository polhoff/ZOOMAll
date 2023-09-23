
dirmapGWarea <- paste ( dirtop, "GWModelling/map_GW_area/", sep = "" )



LoadMapGWArea <- function ( n_year, c_month, indir = dirmapGWarea )
	{
	l_name <- load ( paste (indir, "map_GW_area_", n_year, "_", c_month, "_4_Kirsty_i0302.Rdata", sep = ""))
	x = get (l_name)
	return (x)
	}










plot ( river_xycoords[,3:4] )

mnths = c ( "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" )

c_mnths = c ( paste ( "0", 1:9, sep = "" ), 10,11,12)

lambourn_extend_poly = matrix ( c ( 
418000, 185000,
418000, 180000,
425000, 174000,
442000, 168000,
448640, 164000,
450930, 172240,
446960, 179510,
444270, 182050,
442300, 182370,
440580, 184730,
436430, 184380,
432710, 186350,
428160, 186270
), ncol = 2, byrow= TRUE )


kennet_pang_rivers_poly = matrix ( c ( 
437000, 167000,
450000, 167000,
454000, 171500,
452000, 180000,
452000, 183000,
450000, 185000,
450000, 188000,
422000, 188000,
422000, 179000,
425500, 179000,
430000, 171000
), ncol = 2, byrow= TRUE )


northwest_poly = matrix ( c ( 
420000, 182010,
425000, 175000,
428160, 186270
), ncol = 2, byrow= TRUE )



gl2_poly_extended = matrix ( c ( 
418000, 162000, 
418000,  188000, 
455000,  188000, 
455000,  162000
) , ncol = 2, byrow= TRUE )



which_poly = lambourn_poly
which_poly = lambourn_extend_poly
which_poly = kennet_pang_rivers_poly
which_poly = gl2_poly
which_poly = gl2_poly_extended

#which_poly = northwest_poly

plot ( which_poly )
polygon ( which_poly )

pars1 = c ( 35, -20 )
pars1a = c ( 45, -90 )
pars1b = c ( 45, -20 )
pars2 = c ( 225, 90 )
pars2a = c ( 225, 40 )

par_set = pars1b
#par_set = pars2a


contour_files_in_dir_no_txt <- c(
"contour_4-10-1976",
"contour_4-1-1994",
"contour_4-3-1994",
"contour_4-9-1994",
"contour_4-1-1992",
"contour_4-9-1992"
)


#dirFM_500m_3L <- paste (dirtop, "GWModelling/GroundwaterModel/Regional_model/FM_3L_V2/FM_3L_V2_TV_500/Kirsty_i0301/", sep = "")
#dirFM_500m_3L <- paste (dirtop, "GWModelling/GroundwaterModel/Regional_model/FM_3L_V2/FM_3L_V2_TV_500/Kirsty_i0302/", sep = "")
#dirFM_500m_3L <- paste (dirtop, "GWModelling/GroundwaterModel/Regional_model/FM_3L_V2/FM_3L_V2_TV_500/Kirsty_i0311/", sep = "")
#dirFM_500m_3L <- paste (dirtop, "GWModelling/GroundwaterModel/Regional_model/FM_3L_V2/FM_3L_V2_TV_500/Kirsty_i0312/", sep = "")



#all cases
for ( i in contour_files_in_dir_no_txt )
#for ( i in contour_files_in_dir_no_txt[1:3] )
#for ( i in contour_files_in_dir_no_txt[15] )
	{

	#i = contour_files_in_dir_no_txt[1]

	figure_name = as.numeric ( unlist ( strsplit ( i, "-" ) )[2:3] )
	
	c_mnth = c_mnths[figure_name[1]]
	c_year = figure_name[2]
	
	contours = read.table ( paste ( dirFM_500m_3L, i, ".txt", sep = "" ) )

	x1 = inout ( contours[,1:2], which_poly )

	contours_lmb = contours[x1, ]

	x = tapply (contours_lmb$V4, list ( contours_lmb$V1,  contours_lmb$V2 ), sum )

	x[which(x==-999)] = NA

	
	xx1 = list ( as.numeric ( rownames ( x ) ), as.numeric ( colnames ( x ) ), x )

	names ( xx1 ) = c ( "x", "y", "z" )

	mtext (paste ( mnths [figure_name[1]], " ", figure_name[2], sep = "" ) )


	dd1 = LoadMapGWArea ( c_year, c_mnth )
	
	PngOn (outfile = paste ("contour_", c_year, "_", c_mnth, "_", run_number, "_CEH_withcatch.png", sep = ""), outdir =  dirdmp1)
		#par ( ask = TRUE )
		par ( mar = c ( 7,6,4,5))
		contour ( xx1, levels = seq ( 60, 160, by = 2), cex.lab = 1.6, cex.axis = 1.6, labcex = 1.6, xlab = "EASTING (m)", ylab = "NORTHING (m)", col = "grey30"  )
		#points ( river_xycoords[,3], river_xycoords[,4], col = "black", pch = "+" )
		legend ( "topleft", paste ( mnths[figure_name[1]], c_year ), cex = 1.6 )
		
		#points (dd1, col = colors()[134], pch = 16, cex = 0.6)
		points (dd1, col = "gray70", pch = 15, cex = 1)
		#points (dd1, col = colors()[573], pch = 15, cex = 1)
		plot(uppsev, add = TRUE, col = "grey60")
		polygon ( lambourn_poly72, lty = 2, lwd = 2.4 )
		#polygon ( lambourn_poly72, lty = 2, lwd = 2, border = "purple" )
		contour ( xx1, levels = seq ( 60, 160, by = 2), cex.lab = 1.6, cex.axis = 1.6, labcex = 1.6, xlab = "EASTING (m)", ylab = "NORTHING (m)", col = "grey30", add = T  )
		
	PngOff ( )

	}
