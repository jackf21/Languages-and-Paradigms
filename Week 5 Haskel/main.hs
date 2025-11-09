data MazeTile = Wall | Space | Water | Player
    deriving(Eq)

instance Show MazeTile where
    show Wall = "#"
    show Space = " "
    show Water = "~"
    show Player = "A"
	
--type Maze  = [[MazeTile]]

display2D :: (Show a) => [[a]] -> IO ()
display2D = mapM_ (putStrLn . unwords . map show)

main = display2D [[Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall],[Wall, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Space, Wall],[Wall, Space, Wall, Space, Wall, Wall, Wall, Space, Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall],[Wall, Space, Space, Space, Wall, Space, Space, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Space, Space, Wall],[Wall, Space, Wall, Wall, Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Space, Wall, Space, Wall],[Wall, Space, Wall, Space, Space, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Wall, Space, Wall, Space, Wall],[Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall, Wall, Wall, Space, Wall],[Wall, Space, Space, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Wall, Space, Wall, Space, Space, Space, Wall],[Wall, Wall, Wall, Space, Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall],[Wall, Space, Space, Space, Wall, Space, Wall, Space, Space, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall],[Wall, Wall, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall],[Wall, Space, Space, Space, Wall, Space, Space, Space, Wall, Space, Wall, Space, Wall, Space, Space, Space, Wall, Space, Wall],[Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Space, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall],[Wall, Space, Space, Space, Space, Space, Space, Space, Wall, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Wall],[Wall, Wall, Wall, Wall, Wall, Space, Wall, Space, Wall, Space, Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall],[Wall, Space, Space, Space, Wall, Space, Wall, Space, Wall, Space, Space, Space, Wall, Space, Space, Space, Wall, Space, Wall],[Wall, Space, Wall, Wall, Wall, Space, Wall, Space, Wall, Wall, Wall, Wall, Wall, Space, Wall, Space, Wall, Space, Wall],[Wall, Space, Space, Space, Space, Space, Wall, Space, Space, Space, Space, Space, Space, Space, Wall, Space, Wall, Space, Space],[Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall, Wall]]