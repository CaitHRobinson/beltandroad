## Set your working directory
setwd("/beltandroad")
getwd()

# Install spatial packages
library(sf)
library(tmap)

# Import country boundaries
countries_sf <- st_read("CNTR_RG_01M_2016_3857_select.shp")
plot(st_geometry(countries_sf)) # Plot only the boundaries

# Import BRI projects (also available as csv. file)
briprojects_sf <- st_read("BRIEnergy_Shapefile.shp")
plot(st_geometry(briprojects_sf)) # Plot only the boundaries

# Install colour palette package
library("RColorBrewer")

# Create a colour palette
pal <- rev(brewer.pal(6, ("YlGnBu"))) # select 6 colors from the palette
class(pal)

# Plot map with countries as polygons and projects as bubbles (sized according to cost of the project)
plot1 <- tm_shape(countries_sf) +
  tm_borders(col = "white", lwd = 0.5) +
  tm_fill(col = "grey82")+
  tm_shape(briprojects_sf) + 
  tm_bubbles(col = "Finance",
             size = "Finance",
             border.lwd = NA,
             palette = pal,
             title.size ="Value ($ millions)",
             title.col ="Value ($ millions)", 
             alpha = 0.7)+ # transparency of bubbles (between 0 and 1)
  tm_layout(legend.outside = TRUE, 
            legend.outside.position="bottom",
            frame= NA,
            legend.title.fontface = "bold")

# Export as a tiff
tiff("BRI_MapYlBu.tiff", width = 4000, height = 2500, res=600)
plot1
dev.off()
