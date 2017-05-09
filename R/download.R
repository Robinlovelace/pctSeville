# # # # # # # # # # # # # #
# Download from internet  #
# # # # # # # # # # # # # #

#' @export
dl_city_sev = function() {
  u = "https://www.juntadeandalucia.es/institutodeestadisticaycartografia/DERA/ficheros/G07_Sistema_Urbano.zip"
  if(!file.exists("G07_Sistema_Urbano.zip"))
    download.file(u, "G07_Sistema_Urbano.zip")
  if(!file.exists("G07_SistemaUrbano/07_Metadatos_Sistema_urbano.pdf"))
    unzip("G07_Sistema_Urbano.zip")
  f = list.files(path = "G07_SistemaUrbano/", pattern = ".shp$")
  s = file.size(paste0("G07_SistemaUrbano/", f))
  message(paste("Downloaded these shapefiles:\n", f, round(s / 1000000), "MB"))[order(s)]
}


# grid_pob = raster::shapefile("G07_SistemaUrbano/su08_grid_poblacion_250.shp")
# grid_sev = grid_pob[grid_pob$Municipio == "Sevilla",]

# plot(grid_sev)
# library(tmap)
# tmap_mode("view")
# nrow(grid_sev)
# plot(grid_sev$POBTOTAL)
# qtm(grid_sev)

# # # # # # # # # #
# From local repo #
# # # # # # # # # #

#' @export
load_city_sev = function(data_dir){
  old = setwd(data_dir)
  f = list.files(pattern = ".zip")
  message(paste0("Unzipping these files:", paste(f, collapse = ", ") ))
  for(i in 1:length(f)) unzip(f[i])
  f_shape = list.files(pattern = ".shp$")
  sev_dat = vector(mode = "list", length = length(f_shape))
  sev_names = gsub(pattern = ".shp", replacement = "", x = f_shape)
  names(sev_dat) = sev_names
  for(i in 1:length(f_shape)){
    message(paste0("Reading", f_shape[i]))
    sev_dat[[sev_names[i]]] = sf::st_read(f_shape[i])
  }
  setwd(old)
  sev_dat
}
