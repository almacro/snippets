{- Write a function to calculate the volume of a cylinder.
   The volume of a cylinder is the area of the base, which
   is a circle (you already programmed this function in this
   chapter, so reuse it) multiplied by the height -}
area r = pi * r ^ 2
volumeCylinder r h = h * area r
