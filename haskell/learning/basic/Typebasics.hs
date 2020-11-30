xor :: Bool -> Bool -> Bool
xor p q = (p || q) && not (p && q)
