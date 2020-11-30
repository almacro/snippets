area r = pi * r ^ 2
  
areaRect l w = l * w
areaSquare s = areaRect s s

areaTriangle b h = (b * h) / 2

{- Heron's Formula using `where`
heron a b c = sqrt (s * (s - a) * (s - b) * (s - c))
    where
    s = (a + b + c) / 2
-}

areaTriangleTrig a b c = c * height / 2
    where
    cosa = (b ^ 2 + c ^ 2 - a ^ 2) / (2 * b * c)
    sina = sqrt (1 - cosa ^ 2)
    height = b * sina
areaTriangleHeron a b c = result
    where
    result = sqrt (s * (s - a) * (s - b) * (s - c))
    s      = (a + b + c) / 2
