# Maze Game
# Language - Python
# Paradigm - Procedural

#from colorama import Fore, Back, Style

# Maze Map
# Key: # = wall, 0 = free space ~ = water, A = Player, n = newline
# Water and player only appear during runtime
maze = ["#","0","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","n",
        "#","0","#","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","#","n",
        "#","0","#","0","#","#","#","0","#","0","#","#","#","#","#","#","#","#","#","n",
        "#","0","0","0","#","0","0","0","#","0","0","0","0","0","0","0","0","0","#","n",
        "#","0","#","#","#","0","#","#","#","#","#","#","#","#","#","0","#","0","#","n",
        "#","0","#","0","0","0","#","0","0","0","0","0","0","0","#","0","#","0","#","n",
        "#","0","#","#","#","#","#","0","#","#","#","#","#","0","#","#","#","0","#","n",
        "#","0","0","0","#","0","0","0","0","0","0","0","#","0","#","0","0","0","#","n",
        "#","#","#","0","#","0","#","#","#","#","#","0","#","0","#","0","#","0","#","n",
        "#","0","0","0","#","0","#","0","0","0","#","0","#","0","#","0","#","0","#","n",
        "#","#","#","0","#","0","#","0","#","0","#","0","#","0","#","0","#","0","#","n",
        "#","0","0","0","#","0","0","0","#","0","#","0","#","0","0","0","#","0","#","n",
        "#","0","#","#","#","#","#","#","#","0","#","#","#","#","#","#","#","#","#","n",
        "#","0","0","0","0","0","0","0","#","0","#","0","0","0","0","0","0","0","#","n",
        "#","#","#","#","#","0","#","0","#","0","#","0","#","#","#","#","#","0","#","n",
        "#","0","0","0","#","0","#","0","#","0","0","0","#","0","0","0","#","0","#","n",
        "#","0","#","#","#","0","#","0","#","#","#","#","#","0","#","0","#","0","#","n",
        "#","0","0","0","0","0","#","0","0","0","0","0","0","0","#","0","#","0","0","n",
        "#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","#","n"]

def draw_maze():
    # Printing each item in the maze array to represent the maze
    for i in range(0, len(maze) - 1):
        if maze[i] == "#":
            print("#", end="")
        elif i == player_position:
            print("A", end="")
        elif maze[i] == "0":
            # An empty space is much easier to interprit as free to move into than 0
            print(" ", end="")
        elif maze[i] == "~":
            print("~", end="")
        elif maze[i] == "n":
            # Newline at then end of rows
            # This was to get around some wierd modulo behaviour
            # My bad but this works so stuff it
            print("")
        else:
            print("Invalid data in maze!")
            exit(0)
    print("")

def move_player(amount):
    print("Moving player")
    if maze[player_position + amount] == "#":
        print("Movement Blocked!")
        return player_position
    else:
        return player_position + amount

def game_loop():
    global player_position
    player_position = 1
    #print(player_position)

    player_won = False
    while player_won == False:
        draw_maze()
        move = input("Input a direction (w, a, s, d) :")
        match move:
            case "w" | "W":
                player_position = move_player(-20)
                print(player_position)
            case "a" | "A":
                player_position = move_player(-1)
                print(player_position)
            case "s" | "S":
                player_position = move_player(20)
                print(player_position)
            case "d" | "D":
                player_position = move_player(1)
                print(player_position)
            case _:
                print("Invalid Character!")
                
    
def main():
    game_loop()


if __name__ == "__main__":
    main()
