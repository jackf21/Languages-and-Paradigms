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

-- Attempt to move the player in direction (W/A/S/D), blocked by walls.
-- Returns updates maze, a message, and new player coordinates.
movePlayer :: [[MazeTile]] -> Char -> ([[MazeTile]], Int, Int)
movePlayer maze ch =
  let (r, c) = findPlayer maze
      (r', c') = case ch of
                   'W' -> (r - 1, c)
                   'A' -> (r, c - 1)
                   'S' -> (r + 1, c)
                   'D' -> (r, c + 1)
                   _   -> (r, c)
  in case getTile maze r' c' of
        Wall -> (maze, r, c)
        _    -> (setTile (setTile maze r c Space) r' c' Player, r', c')

-- Place a bomb in a direction that will destroy a wall
placeBomb :: [[MazeTile]] -> Char -> [[MazeTile]]
placeBomb maze ch =
  let (r, c) = findPlayer maze
      (r', c') = case ch of
                   'W' -> (r - 1, c)
                   'A' -> (r, c - 1)
                   'S' -> (r + 1, c)
                   'D' -> (r, c + 1)
                   _   -> (r, c)
  in case getTile maze r' c' of
        Wall -> setTile maze r' c' Space
        _    -> maze


-- Spread water: for each Water tile, turn adjacent Space tiles into Water (one-step spread)
spreadWater :: [[MazeTile]] -> [[MazeTile]]
spreadWater maze =
  let rows = length maze
      cols r = length (maze !! r)
      inBounds r c = r >= 0 && r < rows && c >= 0 && c < cols r
      isWater r c = inBounds r c && getTile maze r c == Water
      newTile r c = case getTile maze r c of
                      Space -> if any (\(dr,dc) -> isWater (r+dr) (c+dc)) [(-1,0),(1,0),(0,-1),(0,1)]
                                 then Water
                                 else Space
                      t     -> t
  in [ [ newTile r c | c <- [0 .. cols r - 1] ] | r <- [0 .. rows - 1] ]


-- MONADIC CODE STARTS

-- Display a 2D maze to the console.
display2D :: (Show a) => [[a]] -> IO ()
display2D = mapM_ (putStrLn . unwords . map show)

-- Monadic game loop, taking player input and moving them through the maze.
gameLoop :: [[MazeTile]] -> Int -> IO ()
gameLoop maze counter = do
  -- Spread water every even turn (one-step spread based on current water positions)
  let maze' = if even counter then spreadWater maze else maze
  display2D maze'
  putStrLn "Enter direction (WASD) or E to place a bomb"
  input <- getLine
  case map toUpper input of
    (x:_) | x `elem` "WASDE" -> do
      if x `elem` "WASD"
        then do
          let (maze'', r', c') = movePlayer maze' x
          if r' == 17 && c' == 18
            then putStrLn "You reached the goal!"
            else gameLoop maze'' (counter + 1)
        else do
          putStrLn "Enter a direction (WASD)"
          dir <- getLine
          case map toUpper dir of
            (d:_) | d `elem` "WASD" -> do
              let maze'' = placeBomb maze' d
              gameLoop maze'' (counter + 1)
            _ -> do
              putStrLn "Invalid input. Please enter W, A, S, D"
              gameLoop maze' counter
    _ -> do
      putStrLn "Invalid input. Please enter W, A, S, D"
      gameLoop maze' counter

main :: IO()
main = do 
    let maze = [[Wall, Water, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall],[Wall, Player, Wall, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Wall],[Wall, Space, Wall, Space, Wall, Wall, Wall, Space, Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall],[Wall, Space, Space, Space, Wall, Space, Space, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Space, Space, Wall],[Wall, Space, Wall, Wall, Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Space, Wall, Space, Wall],[Wall, Space, Wall, Space, Space, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Wall, Space, Wall, Space, Wall],[Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall, Wall, Wall, Space, Wall],[Wall, Space, Space, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Wall, Space, Wall, Space, Space, Space, Wall],[Wall, Wall, Wall, Space, Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall],[Wall, Space, Space, Space, Wall, Space, Wall, Space, Space, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall],[Wall, Wall, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall],[Wall, Space, Space, Space, Wall, Space, Space, Space, Wall, Space, Wall, Space, Wall, Space, Space, Space, Wall, Space, Wall],[Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall],[Wall, Space, Space, Space, Space, Space, Space, Space, Wall, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Wall],[Wall, Wall, Wall, Wall, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall],[Wall, Space, Space, Space, Wall, Space, Wall, Space, Wall, Space, Space, Space, Wall, Space, Space, Space, Wall, Space, Wall],[Wall, Space, Wall, Wall, Wall, Space, Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall, Space, Wall, Space, Wall],[Wall, Space, Space, Space, Space, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Wall, Space, Wall, Space, Space],[Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall]]
    gameLoop maze 0
