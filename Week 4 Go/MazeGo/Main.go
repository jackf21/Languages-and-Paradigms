package main

import "fmt"

var maze = [19][19]int{{1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
	{1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
	{1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1},
	{1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1},
	{1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1},
	{1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1},
	{1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1},
	{1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
	{1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
	{1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1},
	{1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1},
	{1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
	{1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1},
	{1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1},
	{1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1},
	{1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}}

func drawMaze(playerPos [2]int) {
	for i := 0; i < 19; i++ {
		for j := 0; j < 19; j++ {
			if i == playerPos[0] && j == playerPos[1] {
				fmt.Printf("A")
				continue
			}
			switch tile := maze[i][j]; tile {
			case 0:
				fmt.Printf(" ")
			case 1:
				fmt.Print("#")
			default:
				fmt.Println("Invalid Data in Maze")
			}
		}
		fmt.Println("")
	}
}

func movePlayer(position [2]int, x int, y int) [2]int {
	if (maze[position[0]][position[1]] == 1) {
		fmt.Println("Movement blocked!")
		return position
	}
	
	position[0] += x
	position[1] += y

	return	position
}

func placeBomb(position [2]int) {
	var input string = ""
	
	fmt.Println("Which direction? (w, a, s, d): ")
	fmt.Scan(&input)

	switch input {
	case "w", "W":
		maze[position[0] - 1][position[1]] = 0
	case "a", "A":
		maze[position[0]][position[1] - 1] = 0
	case "s", "S":
		maze[position[0] + 1][position[1]] = 0
	case "d", "D":
		maze[position[0]][position[1] + 1] = 0
	default:
		fmt.Println("Invalid input!")
	}
}

func main() {
	var playerPosition [2]int = [2]int{0, 1}
	var numBombs int = 3

	for i := 0; i < 999; i++ {
		drawMaze(playerPosition)
		
		var input string = ""
		fmt.Println("w, a, s, d to move, e to use a bomb: ")
		fmt.Scan(&input)

		switch input {
		case "w", "W":
			playerPosition = movePlayer(playerPosition, -1, 0)
		case "a", "A":
			playerPosition = movePlayer(playerPosition, 0, -1)
		case "s", "S":
			playerPosition = movePlayer(playerPosition, 1, 0)
		case "d", "D":
			playerPosition = movePlayer(playerPosition, 0, 1)
		case "e", "E":
			if numBombs > 0 {
				fmt.Println("Number of bombs: ", numBombs)
				placeBomb(playerPosition)
				fmt.Println("KABOOM!")
				numBombs--
			} else {
				fmt.Println("No more bombs!")
			}
		default:
			fmt.Println("Invalid Input")
		}

		if playerPosition[0] == 17 && playerPosition[1] == 18 {
			fmt.Println("YOU ESCAPED THE MAZE!!!!!!!!!")
			break;
		}
	}

	fmt.Scan()
}