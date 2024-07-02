#!/bin/zsh

while getopts A:B:C opt;
do
	case "$opt"
	in
		A) opt_a=${OPTARG};;
		B) opt_b=${OPTARG};;
		C) opt_c="optc";;
	esac
done

# if positional argument
if [ $# -eq 0 ]; then
	opt_pos=$1
fi

echo "opt_pos: ${opt_pos}"
echo "opt_a: ${opt_a}"
echo "opt_b: ${opt_b}"
echo "opt_c: ${opt_c}"
