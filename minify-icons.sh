#!/bin/bash

for f in lib/assets/*.svg;
do
  echo "Processing $f file..."
  svgcleaner $f $f
done
