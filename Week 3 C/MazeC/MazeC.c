// Maze Game
// Language - C
// Paradigm - Procedural

#include <stdio.h>
#include <stdbool.h>

// Maze Map
// Key: 1 = wall, 0 = free space, 2 = water, A = Player
// Water and player only appear during runtime
int maze[19][19] = { {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
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
					 {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1} };

void drawMaze(int playerPos[2]) {
	for (int i = 0; i < 19; i++) {
		for (int j = 0; j < 19; j++) {
			if (i == playerPos[0] && j == playerPos[1]) {
				printf("A");
				continue;
			}

			switch (maze[i][j]) {
				case 0:
					printf(" ");
					break;
				case 1:
					printf("#");
					break;
			}
			//printf("%d", maze[i][j]);
		}
		printf("\n");
	}
}

int movePlayer(int xPosition, int x, int yPosition, int y) {
	//printf("%d, %d, %d, %d \n", xPosition, x, yPosition, y);
	if (maze[xPosition + x][yPosition + y] == 1) {
		printf("Movement blocked!\n");
		if (x != 0) {
			return xPosition;
		}
		else if (y != 0) {
			return yPosition;
		}
		else {
			return xPosition;
		}
	}
	else {
		if (x != 0) {
			return xPosition + x;
		}
		else if (y != 0) {
			return yPosition + y;
		}
	}
}

void placeBomb(int position[2]) {
	char input = "s";
	printf("Which direction? (w, a, s, d): ");
	scanf_s(" %c", &input);

	// W
	if (input == 87 || input == 119) {
		maze[position[0] - 1][position[1]] = 0;
	}
	// A
	else if (input == 65 || input == 97) {
		maze[position[0]][position[1] - 1] = 0;
	}
	// S
	else if (input == 83 || input == 115) {
		maze[position[0] + 1][position[1]] = 0;
	}
	// D
	else if (input == 68 || input == 100) {
		maze[position[0]][position[1] + 1] = 0;
	}
}

int main() {
	int playerPosition[2] = { 0, 1 };
	int numBombs = 3;
	bool playerWon = false;

	while (playerWon == false) {
		drawMaze(playerPosition);
		char input = "s";
		
		printf("w, a, s, d to move, e to use a bomb :");
		scanf_s(" %c", &input);
		printf("%c\n", input);

		// W
		if (input == 87 || input == 119) {
			playerPosition[0] = movePlayer(playerPosition[0], -1, playerPosition[1], 0);
			//printf("%d %d\n", playerPosition[0], playerPosition[1]);
		}
		// A
		else if (input == 65 || input == 97) {
			playerPosition[1] = movePlayer(playerPosition[0], 0, playerPosition[1], -1);
			//printf("%d %d\n", playerPosition[0], playerPosition[1]);
		}
		// S
		else if (input == 83 || input == 115) {
			playerPosition[0] = movePlayer(playerPosition[0], 1, playerPosition[1], 0);
			//printf("%d %d\n", playerPosition[0], playerPosition[1]);
		}
		// D
		else if (input == 68 || input == 100) {
			playerPosition[1] = movePlayer(playerPosition[0], 0, playerPosition[1], 1);
			//printf("%d %d\n", playerPosition[0], playerPosition[1]);
		}
		else if (input == 69 || input == 101) {
			if (numBombs > 0){
				printf("Number of bombs: %d\n", numBombs);
				placeBomb(playerPosition);
				printf("KABOOOM!\n");
				numBombs--;
			}
			else {
				printf("No more bombs!");
			}
			
		}
		else {
			printf("Invalid Input!\n");
		}
		//printf("%d, %d\n", playerPosition[0], playerPosition[1]);

		if (playerPosition[0] == 17 && playerPosition[1] == 18){
			playerWon = true;
		}
	}

	printf("YOU ESCAPED THE MAZE!!!!!!!!!");
	scanf_s("");

	return 0;
}