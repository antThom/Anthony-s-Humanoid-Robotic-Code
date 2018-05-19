# This is a game of tic tac toe

''' The first section will be making the board
first print instructions
second print the key options for placement
''' 
from random import *
import create as cd
import subprocess as sp
import collections
import matplotlib


def instruct():
	print 'This is a game of tic tac toe!'
	print ''
	print 'The board is set up as:'
	print '1, 2, 3'
	print '4, 5, 6'
	print '7, 8, 9'
	print ''
	print 'Flip a coint to see who goes first'
	first=coinFlip()
	return first


def coinFlip():
	coin=str(randint(1,2)) #get a random integer between 1 and 2 and convert it to a string
	choice=raw_input('Pick a side 1: Heads or 2: Tails : ') #ask the user to choose a number (choice is a string)
	if choice != '1' or choice != '2': #if choice does not equal 1 or 2 then ask for a new entry
		while (choice != '1' and choice != '2'):
			print 'INVALID ENTRY'
			choice=raw_input('Pick a side 1: Heads or 2: Tails : ')
	if choice == coin: #if the user's choice is equal to coin then the user wins
		print('')
		print 'You won the coin toss so you go first'
		print('')
		first = True
	else:
		print('')
		print 'You lost the coin toss so the Computer goes first '
		print('')
		first = False

	return first


def makeBoard(board):
	print(' ')
	print(' ')
	print(' ' + board[0] + ' | ' + board[1] + ' | ' + board[2])
	print(' ' + board[3] + ' | ' + board[4] + ' | ' + board[5])
	print(' ' + board[6] + ' | ' + board[7] + ' | ' + board[8])


"""
This is where the machine learning takes place. The computer should get smarter the more you play against it.

Step 1: Create data that will be used by the computer 
"""
def COMplay(board,human,COM):
	#1st check to see what the open slots are
	#2nd choose any position that isn't taken
	opp=openSpot(board,human)
	mine=openSpot(board,COM)
	#print(opp)
	#print(mine)
	pos = randint(1,9)
	while pos in opp or pos in mine:
		pos = randint(1,9)
	return pos



def openSpot(board,place):
	taken=[]
	for index, elem in enumerate(board):
		#print index, elem
		if elem == place:
			taken.append(index+1)
		else:
			pass

	return taken


def humanTurn(board,human,COM):
	"""
	This function will ask the user where he would like to go next and returns that position
	to the main function
	"""
	takenHUM = openSpot(board,human)
	takenCOM = openSpot(board,COM)
	#print takenHUM
	#print takenCOM
	pos = ord(raw_input('Choose which spot you to play: ')) # ask the user for thier input and convert it to ascii code
	if ((pos>57 or pos<49) or (int(str(unichr(pos))) in takenHUM or int(str(unichr(pos))) in takenCOM)): # if the entry is out of range according to the ascii code or is already taken
		flag=True #create a flag for the while loop and set it to true
		while (flag==True):
			print 'INVALID ENTRY!!! TRY AGAIN' # let the user know that the entry was invalid
			pos = ord(raw_input('Choose which spot you to play: ')) # re-ask the user for their input
			if (pos<=57 and pos>=49): # if the input is in range according to the ascii code set the flag to false and exit the while loop
				pos=int(str(unichr(pos))) #Convert the string back to an integer
				if (pos in takenHUM or pos in takenCOM): # if the entry is already taken do not allow the user to select that point
					flag=True
				else:
					flag=False
	else:
		pos=int(str(unichr(pos)))
	return pos

def winning(board,playerID,win):
	complete=[]
	#print 'PlayerID = ' +playerID
	#print 'Win Type = ' +str(win)
	pos=openSpot(board,playerID)
	#print 'Position = ' +str(pos)
	if len(pos)>=3:
		for x in range(0,len(pos)):
			if pos[x] in win:
				complete.append(1)
			else:
				complete.append(0)
		if sum(complete)==3:
			won=True
		else:
			won=False
	else:
		won=False
	#print 'Complete = ' +str(complete)
	return won

def banner(playerID):
	if playerID=='X':
		print ' '
		print 'Congratulations You Won!!!!'
		print ' '
		print ' '
	elif playerID=='O':
		print ' '
		print 'The Computer Won!!!!'
		print ' '
		print ' '
	else:
		print ' '
		print 'TIE GAME!!!'
		print ' '
		print ' '

def main():
	play=True
	gameNum=1
	cd.initialWrite()
	while play==True:
		board=[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
		human='X'
		COM='O'
		first=instruct()
		game=True
		turn=1
		win1=[1,2,3]
		win2=[4,5,6]
		win3=[7,8,9]
		win4=[1,4,7]
		win5=[2,5,8]
		win6=[3,6,9]
		win7=[1,5,9]
		win8=[3,5,7]
		won=False
		print 'GAME # ' + str(gameNum)
		while game==True and turn<10 and won==False:
			#print '1st Line of Loop'
			if first == True and turn==1: #This means the human goes first
				pos = humanTurn(board,human,COM)
				humMove=pos
				board[pos-1] = human #Human ALWAYS PLAYS AS X
				nex='com'
			elif first == False and turn ==1:
				pos=COMplay(board,human,COM)
				humMove=0
				board[pos-1] = COM
				nex='hum'
			elif nex=='hum':
				pos=humanTurn(board,human,COM)
				humMove=pos
				board[pos-1] = human #Human ALWAYS PLAYS AS X
				nex='com'
			elif nex=='com':
				pos=COMplay(board,human,COM)
				humMove=0
				board[pos-1] = COM
				nex='hum'
			print 'Turn = ' +str(turn)	
			#tmp = sp.call('clear',shell=True) #Clear the terminal window
			makeBoard(board)
			first=False
			if turn >= 5:
				if winning(board,human,win1):
					won=True
					banner(human)
					meth=1
				elif winning(board,COM,win1):
					won=True
					banner(COM)
					meth=-1
				if winning(board,human,win2):
					won=True
					banner(human)
					meth=2
				elif winning(board,COM,win2):
					won=True
					banner(COM)
					meth=-2
				if winning(board,human,win3):
					won=True
					banner(human)
					meth=3
				elif winning(board,COM,win3):
					won=True
					banner(COM)
					meth=-3
				if winning(board,human,win4):
					won=True
					banner(human)
					meth=4
				elif winning(board,COM,win4):
					won=True
					banner(COM)
					meth=-4
				if winning(board,human,win5):
					won=True
					banner(human)
					meth=5
				elif winning(board,COM,win5):
					won=True
					banner(COM)
					meth=-5
				if winning(board,human,win6):
					won=True
					banner(human)
					meth=6
				elif winning(board,COM,win6):
					won=True
					banner(COM)
					meth=-6
				if winning(board,human,win7):
					won=True
					banner(human)
					meth=7
				elif winning(board,COM,win7):
					won=True
					banner(COM)
					meth=-7
				if winning(board,human,win8):
					won=True
					banner(human)
					meth=8
				elif winning(board,COM,win8):
					won=True
					banner(COM)
					meth=-8
				else:
					pass
			else:
				meth=0
			turn=turn+1
			if (nex=='com' or turn == 10):
				cd.createData(humMove,gameNum,turn,meth)
		again=raw_input('Do you want to play again Y\N:? ')
		again=again.upper()
		gameNum+=1
		if again=='Y':
			play=True
		else:
			play=False
	

main()