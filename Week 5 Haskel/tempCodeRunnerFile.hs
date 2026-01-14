(x:_) | x `elem` "WASD" -> do
             let (maze', msg, r', c') = movePlayer maze x
             putStrLn msg
             gameLoop maze'