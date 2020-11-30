-- Write a function to calculate the volume of a box
volumeBox w h d = w * h * d

{- Approximately how many stones are the famous pyramids at Gize made up of?
   Hint: you will need estimates for the volume of the pyramids and the volume
         of each block

   Refs:
    https://www.cheops-pyramide.ch/khufu-pyramid/khufu-numbers.html
    https://mae.ufl.edu/~uhk/PYRAMIDS.pdf
-}   
-- volume of square base pyramid
square x = x * x
volumePyramid a h = h * (square a) / 3
metersToCentimeters m = m * 100

-- height of giza pyramid => 146.59m
pyramidheight = metersToCentimeters 146.59
-- length of side of square base of giza pyramid => 230.36m
pyramidBaseSide = metersToCentimeters 230.36
-- giza pyramid block size 127 x 127 x 71 cm
blockVol = volumeBox 127 127 71

pyramidVol = volumePyramid pyramidBaseSide pyramidheight
-- approximate number of stones
numberOfStones = pyramidVol / blockVol
