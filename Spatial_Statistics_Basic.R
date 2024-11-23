#install.packages(c("sf", "tmap", "rnaturalearth", "rnaturalearthdata"))

library(sf)
library(tmap)
library(rnaturalearth)
library(rnaturalearthdata)

# Load world boundaries dataset
world <- ne_countries(scale = "medium", returnclass = "sf")

# Check structure of the dataset
print(world)

#-------------
#VIZUALIZE THE DATA
# Simple map of world boundaries
tm_shape(world) +
  tm_borders() +
  tm_layout(title = "World Map")

# Add thematic coloring based on population
tm_shape(world) +
  tm_polygons("pop_est", title = "Population") +
  tm_layout(title = "World Population Map")

#--------------
#1 change the map title and layout elements like font size and positioning.
tm_shape(world) +
  tm_borders() +
  tm_layout(
    title = "Modified World Map", # Change the title
    title.size = 1,              # Adjust the size of the title
    title.position = c("left", "bottom"), # Center the title at the top
    frame = FALSE                # Remove the border around the map
  )

#2 Change the Attribute for Thematic Mapping

# Calculate area in square kilometers
world$area_km2 <- as.numeric(st_area(world)) / 1e6  # Convert from square meters to square kilometers

# Check the new column
head(world[, c("name", "area_km2")])

tm_shape(world) +
  tm_polygons(
    "area_km2", 
    title = "Country Area (sq km)",
    palette = "BuPu" # Blue-Purple palette
  ) +
  tm_layout(
    title = "World by Area",
    legend.outside = TRUE
  )

tm_shape(world) +
  tm_polygons("area_km2", title = "Country Area (sq km)") +
  tm_layout(
    title = "World by Area",
    title.size = 1.5,
    legend.position = c("left", "bottom") # Move the legend
  )


#3. Customize Colors
#Change the color palette to something more visually striking:
tm_shape(world) +
  tm_polygons(
    "pop_est", 
    title = "Population",
    palette = "YlGnBu" # Yellow-Green-Blue palette
  ) +
  tm_layout(
    title = "World Population Map (Custom Colors)",
    title.size = 1.5
  )


# 4. Add Point Data (Cities)
# Let’s add some major cities to the map using rnaturalearth:
# Load cities dataset
cities <- ne_download(scale = "medium", type = "populated_places", returnclass = "sf")

# Plot countries with cities as points
tm_shape(world) +
  tm_borders() +
  tm_shape(cities) +
  tm_dots(size = 0.2, col = "red", title = "Cities") +
  tm_layout(
    title = "World Map with Cities",
    title.size = 1.5
  )


# 5. Combine Multiple Attributes
# Visualize population with color and highlight country borders based on income level:
tm_shape(world) +
  tm_polygons(
    "pop_est", 
    title = "Population",
    palette = "viridis"
  ) +
  tm_borders(col = "income_grp", lwd = 1.5) +
  tm_layout(
    title = "Population and Income Levels",
    legend.outside = TRUE
  )


# INI ADALAH BARIS BARU PERCOBAAN

