#!/bin/bash

#Run python script to rearrange data 
python regular.py $1

#Run R scripts and get the files saved into a folder 
Rscripts maps.R

#Create .gif usinge imagemagick, installed by default in linux 

for FOLDER in `ls *.png`
do
  convert -delay 200 *.png -loop 0 file.gif
done






