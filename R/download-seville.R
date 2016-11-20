dl_sevilla_official = function() {
  u = "https://www.juntadeandalucia.es/institutodeestadisticaycartografia/DERA/ficheros/G07_Sistema_Urbano.zip"
  if(!file.exists("G07_Sistema_Urbano.zip"))
    download.file(u, "G07_Sistema_Urbano.zip")
  if(!file.exists("G07_SistemaUrbano/07_Metadatos_Sistema_urbano.pdf"))
    unzip("G07_Sistema_Urbano.zip")
  f = list.files(path = "G07_SistemaUrbano/", pattern = ".shp$")
  s = file.size(paste0("G07_SistemaUrbano/", f))
  message(paste("Downloaded these shapefiles:\n", f, round(s / 1000000), "MB"))[order(s)]
}


grid_pob = raster::shapefile("G07_SistemaUrbano/su08_grid_poblacion_250.shp")
grid_sev = grid_pob[grid_pob$Municipio == "Sevilla",]

plot(grid_sev)
library(tmap)
tmap_mode("view")
nrow(grid_sev)
plot(grid_sev$POBTOTAL)
qtm(grid_sev)
