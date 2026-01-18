
#define ID 23635926

#include "Maze.h"
#include "Player.h"

#include <iostream>

int main()
{
    Player* player = new Player(0, 1);

    Maze* maze = new Maze(player);

    while (maze->GetState() == 0) {
        maze->drawMaze();
        
        char input;
        
        std::cout << "Input a direction: ";
        std::cin >> input;
        std::cout << std::endl;
        
        switch (input) {
        // W
        case 87:
        case 119:
            maze->movePlayer(-1, 0);
            break;
        // A
        case 65:
        case 97:
            maze->movePlayer(0, -1);
            break;
        // S
        case 83:
        case 115:
            maze->movePlayer(1, 0);
            break;
        // D
        case 68:
        case 100:
            maze->movePlayer(0, 1);
            break;
        // E
        case 69:
        case 101:

            char bombInput;
            std::cout << "Input a direction: ";
            std::cin >> bombInput;
            
            switch (bombInput) {
            // W
            case 87:
            case 119:
                maze->placeBomb(-1, 0);
                break;
            // A
            case 65:
            case 97:
                maze->placeBomb(0, -1);
                break;
            // S
            case 83:
            case 115:
                maze->placeBomb(1, 0);
                break;
            // D
            case 68:
            case 100:
                maze->placeBomb(0, 1);
                break;
            }
        }

    }

    if (maze->GetState() == 1) {
        std::cout << "YOU WIN!!" << std::endl;
    }
    else {
        std::cout << "you lost..." << std::endl;
    }
}

