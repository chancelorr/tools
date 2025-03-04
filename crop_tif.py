#!/usr/bin/env python

'''
by Chance

ultility to crop a tif to a region of interest defined by a shape file


'''

import os
import configparser
import argparse
import geopandas as gpd
import rasterio
import rasterio.mask

############### Config os stuff ####################
# Get the directory where the script is located
script_dir = os.path.dirname(os.path.abspath(__file__))
# Construct the full path to the config file
ini = os.path.join(script_dir, 'config/config_os.ini')

# Create a ConfigParser object
config = configparser.ConfigParser()

# Read the configuration file
config.read(ini)
#os and pyproj path config
gdal_data = config.get('os', 'gdal_data')
proj_lib = config.get('os', 'proj_lib')
proj_data = config.get('os', 'proj_data')

os.environ["GDAL_DATA"] = gdal_data # need to specify to make gdal work
os.environ["PROJ_LIB"] = proj_lib # need to specify to make pyproj work
os.environ["PROJ_DATA"] = proj_data # need to specify to make pyproj work

crs_antarctica = 'EPSG:3031'
crs_latlon = 'EPSG:4326'

#####################################################

def crop_tif_to_shapefile(input_file, shape_file, output_file):
    # Read the shapefile using GeoPandas
    gdf = gpd.read_file(shape_file)

    # Open the raster file
    with rasterio.open(input_file) as src:
        # Get CRS of the raster
        raster_crs = src.crs
        
        # Reproject shapefile to match the raster CRS
        if gdf.crs != raster_crs:
            print(f"Reprojecting shapefile from {gdf.crs} to {raster_crs}")
            gdf = gdf.to_crs(raster_crs)
            
        # Convert geometries to a format rasterio understands
        shapes = [geom.__geo_interface__ for geom in gdf.geometry]
        
        # Mask the raster using the shape
        out_image, out_transform = rasterio.mask.mask(src, shapes, crop=True)
        out_meta = src.meta.copy()

        # Update metadata
        out_meta.update({
            "driver": "GTiff",
            "height": out_image.shape[1],
            "width": out_image.shape[2],
            "transform": out_transform
        })

        # Save the cropped raster
        with rasterio.open(output_file, "w", **out_meta) as dst:
            dst.write(out_image)

#################### Main ############################

def main():

    parser = argparse.ArgumentParser(description='enter input, shp and output files', \
                                     fromfile_prefix_chars='@')
    parser.add_argument('input_file', type=str, help="Path to the input TIFF file")
    parser.add_argument('shape_file', type=str, help="Path to the shapefile")
    parser.add_argument('output_file', type=str, help="Path to save the cropped TIFF file")

    args=parser.parse_args()
    
    crop_tif_to_shapefile(args.input_file, args.shape_file, args.output_file)

if __name__ == "__main__":
    main()