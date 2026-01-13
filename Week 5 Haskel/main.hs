import Data.Char (toUpper)

data MazeTile = Wall | Space | Water | Player
    deriving(Eq)

instance Show MazeTile where
    show Wall = "#"
    show Space = " "
    show Water = "~"
    show Player = "A"

-- Return the tile at a given index r c
getTile :: [[MazeTile]] -> Int -> Int -> MazeTile
getTile maze r c = (maze !! r) !! c

-- Set the tile of a maze at index r c to val
setTile :: [[MazeTile]] -> Int -> Int -> MazeTile -> [[MazeTile]]
setTile maze r c val = take r maze ++ [newRow] ++ drop (r + 1) maze
  where
    row = maze !! r
    newRow = take c row ++ [val] ++ drop (c + 1) row


-- Find the first occurrence of the player and return its index
findPlayer :: [[MazeTile]] -> (Int, Int)
findPlayer maze = head [ (r, c) | (r, row) <- zip [0..] maze, (c, tile) <- zip [0..] row, tile == Player ]

-- | Attempt to move the player in direction (W/A/S/D). Returns (maze', message).
movePlayer :: [[MazeTile]] -> Char -> ([[MazeTile]], String, Int, Int)
movePlayer maze ch =
  let (r, c) = findPlayer maze
      (r', c') = case ch of
                   'W' -> (r - 1, c)
                   'A' -> (r, c - 1)
                   'S' -> (r + 1, c)
                   'D' -> (r, c + 1)
                   _   -> (r, c)
  in case getTile maze r' c' of
        Wall -> (maze, "Cannot move: wall in the way.", r, c)
        _    -> (setTile (setTile maze r c Space) r' c' Player, "Moved.", r', c')




-- MONADIC CODE STARTS

display2D :: (Show a) => [[a]] -> IO ()
display2D = mapM_ (putStrLn . unwords . map show)

-- Monadic game loop, taking player input and moving them through the maze.
gameLoop :: [[MazeTile]] -> IO ()
gameLoop maze = do
  display2D maze
  putStrLn "Enter direction (W/A/S/D)"
  input <- getLine
  case map toUpper input of
    (x:_) | x `elem` "WASD" -> do
             let (maze', msg, r', c') = movePlayer maze x
             putStrLn msg
             if r' == 17 && c' == 18
               then putStrLn "You reached the goal!"
               else gameLoop maze'
    _ -> do
             putStrLn "Invalid input. Please enter W, A, S, D"
             gameLoop maze

main :: IO()
main = do 
    let maze = [[Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall],[Wall, Player, Wall, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Wall],[Wall, Space, Wall, Space, Wall, Wall, Wall, Space, Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall],[Wall, Space, Space, Space, Wall, Space, Space, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Space, Space, Wall],[Wall, Space, Wall, Wall, Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Space, Wall, Space, Wall],[Wall, Space, Wall, Space, Space, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Wall, Space, Wall, Space, Wall],[Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall, Wall, Wall, Space, Wall],[Wall, Space, Space, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Wall, Space, Wall, Space, Space, Space, Wall],[Wall, Wall, Wall, Space, Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall],[Wall, Space, Space, Space, Wall, Space, Wall, Space, Space, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall],[Wall, Wall, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall],[Wall, Space, Space, Space, Wall, Space, Space, Space, Wall, Space, Wall, Space, Wall, Space, Space, Space, Wall, Space, Wall],[Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall],[Wall, Space, Space, Space, Space, Space, Space, Space, Wall, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Wall],[Wall, Wall, Wall, Wall, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall],[Wall, Space, Space, Space, Wall, Space, Wall, Space, Wall, Space, Space, Space, Wall, Space, Space, Space, Wall, Space, Wall],[Wall, Space, Wall, Wall, Wall, Space, Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall, Space, Wall, Space, Wall],[Wall, Space, Space, Space, Space, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Wall, Space, Wall, Space, Space],[Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall]]
    gameLoop maze
