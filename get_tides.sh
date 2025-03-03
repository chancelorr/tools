#!/bin/zsh

# Author: Chance
# Date: 2024-07-01
# Description: This script looks in the directory provided and runs Tyler's tide program for every 
#   available granule, then outputs them into a subdirectory named 'tides'
# example call ./get_tides.sh -I linear -T CATS2008-v2023 -O ~/Applications/buttressing/data/is2/ATL11_Cp-D_test

start_dir=$(pwd)

# Function to display usage information
usage() {
  echo "Usage: $0 [-O <search_directory>] [-T <tide_model>] [-I <interpolate_method>]" 
  echo " [-S <short_name>] [-E <extrapolate_dist>] [-f <granule_name>] [-h]"
  echo " "
  echo "Upper case options are passed to compute_tides_ICESat2_ATLXX.py"
  echo "lower case options are for this script"
  echo " "
  echo "Options:"
  echo "  -O Specify the output directory."
  echo "  -I Spatial interpolation method."
  echo "  -E Extrapolate using nearest neigbors, distance in km"
  echo "  -T Specify tide model."
  echo "  -S Specify data product shortname."
  echo "  -f Specify single granule."
  echo "  -h Display this help message."
  echo " "
  echo " Example: get_tides.sh -I linear -T CATS2008-v2023 -O ~/Applications/buttressing/data/is2/ATL11_Cp-D_test"
  echo " "
  exit 1
}

# initialize variables
directory=''
int_method=''
tide_model=''
granule=''
ext_dist=''
short_name=''

# Parse options using getopts
while getopts "O:I:E:T:S:f:h" opt; 
do
  case "$opt" 
  in
    O) directory=${OPTARG};;
    I) int_method=${OPTARG};;
    E) ext_dist=${OPTARG};;
    T) tide_model=${OPTARG};;
    S) short_name=${OPTARG};;
    f) granule=${OPTARG};;
    h) usage;;
    *) usage;;
    \?) usage;;
  esac
done

# Check if the required options are provided
if [ -z "$int_method" ] || [ -z "$tide_model" ]; then
  echo "Error: Missing required options."
  usage
fi

# Check if a directory argument is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Set the directory variable to the first positional argument if it wasn't set by -O
if [ -z "$directory" ]; then
  directory=$1
fi

cd ${directory}/../../

# Check if the provided argument is a valid directory
if [ ! -d "$directory" ]; then
  echo "Error: $directory is not a valid directory."
  exit 1
fi

# Check if a tides directory exists
if [ ! -d "${directory}/tides" ]; then
  echo " No directory <tides>, creating.."
  mkdir ${directory}/tides
fi

tide_dir=${directory}/tides

compute_tides() {
	local this=$1
	local in_dir=$directory
	local out_dir=$tide_dir
	local model=$tide_model
	local interp=$int_method
	local extrap=$ext_dist
	local short_name=$short_name
	#echo "this ${this}"
	#echo "in_dir ${in_dir}"
	#echo "out_dir ${tide_dir}"
	#echo "model ${tide_model}"
	#echo "interp ${interp}"
	echo "compute_tides_ICESat2_${short_name}.py ${this} -D./ -O${out_dir} -T${model} -I${interp}"
	compute_tides_ICESat2_${short_name}.py ${this} -D./ -O${out_dir} -T${model} -I${interp}
}


if [ -n "$granule" ]; then
	echo "Processing single granule: ${granule}"
	file=${directory}/${granule}
	compute_tides $file
	exit 1
fi

# Main script execution
for file in "$directory"/*.h5; do
  compute_tides $file
done

cd $start_dir

# End of script
