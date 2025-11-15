#pragma once

#include "Player.h"

#include <iostream>

class Maze {
public:
	Maze(Player* reqPlayer) :
		m_player(reqPlayer) {}

	// Outputting the contents of the m_maze variable to the console
	inline void drawMaze() {

		// Spread water every 2 "ticks" but manually spread on the first two to avoid out of bounds errors with spreading
		if (m_waterTick % 2 == 0 && m_waterTick != 0) {
			spreadWater();
		}

		if (m_waterTick == 2) {
			m_maze[0][1] = 2;
		}

		if (m_waterTick == 4) {
			m_maze[1][1] = 2;
		}

		// Player is represented by an "A", spaces the are free to move in: " ", walls: "#", water:"~"
		for (unsigned int i = 0; i < 19; i++) {
			for (unsigned int j = 0; j < 19; j++) {
				if (i == m_player->GetXPosition() && j == m_player->GetYPosition()) {
					std::cout << ("A ");
					continue;
				}

				switch (m_maze[i][j]) {
				case 0:
					std::cout << "  ";
					break;
				case 1:
					std::cout << "# ";
					break;
				case 2:
					std::cout << "~ ";
					break;
				default:
					std::cout << "Invalid Data in Maze" << std::endl;
					break;
				}
			}
			std::cout << "" << std::endl;
		}

		m_waterTick++;
	}

	// Getting a tile in the maze realtive to the player's posiiton
	inline int checkTile(int x, int y) {
		//std::cout << x << " " << y << std::endl;
		return m_maze[m_player->GetXPosition() + x][m_player->GetYPosition() + y];
	}

	inline void movePlayer(int x, int y) {
		//std::cout << m_player->GetXPosition() << " " << m_player->GetYPosition() << std::endl;
		switch (checkTile(x,y))
		{
		case 0:
			m_player->move(x, y);
			break;
		case 1:
			std::cout << "Movement Blocked!" << std::endl;
			break;
		// Game ends if the player touches water
		case 2:
			m_state = DIED;
			break;
		}

		// Player wins the game if they reach this space in the maze
		if (m_player->GetXPosition() == 17 && m_player->GetYPosition() == 18) {
			m_state = WON;
		}
	}

	// Bombs allow for the destruction of walls and work similar to movement
	inline void placeBomb(int x, int y) {
		switch (checkTile(x, y))
		{
		case 0:
			break;
		case 1:
			m_maze[m_player->GetXPosition() + x][m_player->GetYPosition() + y] = 0;
			break;
		case 2:
			break;
		}

		m_player->useBomb();
	}

	// Taking every water tile in the maze and filling empty spaces around it with water
	inline void spreadWater() {
		// tempMaze is used to prevent spreading from new water in one pass through of the maze
		int tempMaze[19][19];
		for (unsigned int i = 0; i < 19; i++) {
			for (unsigned int j = 0; j < 19; j++) {
				tempMaze[i][j] = m_maze[i][j];
			}
		}

		// Starting at 1 and ending at 18 to prevent accessing outside of the array bounds
		for (unsigned int i = 1; i < 18; i++) {
			for(unsigned int j = 1; j < 18; j++) {
				if (m_maze[i][j] == 2) {
					if (m_maze[i + 1][j] == 0) {
						tempMaze[i + 1][j] = 2;
					}
					if (m_maze[i - 1][j] == 0) {
						tempMaze[i - 1][j] = 2;
					}
					if (m_maze[i][j + 1] == 0) {
						tempMaze[i][j + 1] = 2;
					}
					if (m_maze[i][j - 1] == 0) {
						tempMaze[i][j - 1] = 2;
					}
				}
			}
		}

		for (unsigned int i = 0; i < 19; i++) {
			for (unsigned int j = 0; j < 19; j++) {
				m_maze[i][j] = tempMaze[i][j];
			}
		}
	}

	inline int GetState() const { return m_state; }

private:
	Player* m_player;

	int m_waterTick = 0;

	enum gameState {
		PLAYING,
		WON,
		DIED
	};

	enum gameState m_state = PLAYING;

	int m_maze[19][19] = { {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
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

};