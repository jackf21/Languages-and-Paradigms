# Tic-tac-toe Game
# Language - Python
# Paradigm - Procedural


# Grid index
#  0 1 2
#  3 4 5
#  6 7 8


#The potential winning combinations for the Tic-tac-toe game (columns, rows, diagonals)
winning_combos = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

# the board is a 1-d array of size 9. '-' indicates nothing has been placed yet 
board = ["-"] * 9


#procedure to display the board as ascii text
def display_board():
    print(board[0], board[1], board[2])
    print(board[3], board[4], board[5])
    print(board[6], board[7], board[8])

#procedure that determines if 'player' is a winner by checking the winning combos. Returns a boolean for convenience
def winner(player):
    for combo in winning_combos:
        if board[combo[0]] == player and board[combo[1]] == player and board[combo[2]] == player:
            return True
    return False

#procedure containing instructions for taking a single turn
def take_turn(player):
    print("It's player " + player + "'s turn")
    move = int(input("Enter move index (1-9): "))
    board[move-1] = player
    

#The full game loop
def game_loop():
    #turn order is determined by the array 
    for player in ["o","x","o","x","o","x","o","x","o"]:
        display_board()
        take_turn(player)
        if winner(player):
            display_board()
            print("Player " + player + " wins")
            break

#the only thing we need to do in main is start the game loop. We would need additional behaviour for extra features (e.g., keeping score, etc.)
def main():
    game_loop()

#python boilerplate to indicate starting behaviour
if __name__ == "__main__":
    main()
