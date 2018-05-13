# This is a game of tic tac toe

''' The first section will be making the board
first print instructions
second print the key options for placement
''' 
from random import *
import collections

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
	coin=str(randint(1,2))
	choice=raw_input('Pick a side 1: Heads or 2: Tails : ')
	if isinstance(choice, int)==False:
		while isinstance(choice, int)==False:
			print'INVALID ENTRY!!! TRY AGAIN'
			choice=int(raw_input('Pick a side 1: Heads or 2: Tails : '))
	elif choice>9 or choice<1:
		while (choice!=2 or choice!=1):
			print'INVALID ENTRY!!! TRY AGAIN'
			choice=int(raw_input('Pick a side 1: Heads or 2: Tails : '))
	if choice == coin:
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
	print(' ' + board[0] + ' | ' + board[1] + ' | ' + board[2])
	print(' ' + board[3] + ' | ' + board[4] + ' | ' + board[5])
	print(' ' + board[6] + ' | ' + board[7] + ' | ' + board[8])

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

def humanTurn():
	pos=raw_input('Choose which spot you to play: ')
	if isinstance(pos, int)==False:
		while isinstance(pos, int)==False:
			print'INVALID ENTRY!!! TRY AGAIN'
			pos=int(raw_input('Choose which spot you to play: '))
	elif pos>9 or pos<1:
		while (pos>9 or pos<1):
			print'INVALID ENTRY!!! TRY AGAIN'
			pos=int(raw_input('Choose which spot you to play: '))
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
	else:
		print ' '
		print 'The Computer Won!!!!'
		print ' '
		print ' '

def main():
	play=True
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
		while game==True and turn<10 and won==False:
			print '1st Line of Loop'
			if first == True and turn==1: #This means the human goes first
				pos = humanTurn()
				board[pos-1] = human #Human ALWAYS PLAYS AS X
				nex='com'
			elif first == False and turn ==1:
				pos=COMplay(board,human,COM)
				board[pos-1] = COM
				nex='hum'
			elif nex=='hum':
				pos=humanTurn()
				board[pos-1] = human #Human ALWAYS PLAYS AS X
				nex='com'
			elif nex=='com':
				pos=COMplay(board,human,COM)
				board[pos-1] = COM
				nex='hum'
			print 'Turn = ' +str(turn)	
			makeBoard(board)
			first=False
			if turn >= 5:
				if winning(board,human,win1):
					won=True
					banner(human)
				elif winning(board,COM,win1):
					won=True
					banner(COM)
				if winning(board,human,win2):
					won=True
					banner(human)
				elif winning(board,COM,win2):
					won=True
					banner(COM)
				if winning(board,human,win3):
					won=True
					banner(human)
				elif winning(board,COM,win3):
					won=True
					banner(COM)
				if winning(board,human,win4):
					won=True
					banner(human)
				elif winning(board,COM,win4):
					won=True
					banner(COM)
				if winning(board,human,win5):
					won=True
					banner(human)
				elif winning(board,COM,win5):
					won=True
					banner(COM)
				if winning(board,human,win6):
					won=True
					banner(human)
				elif winning(board,COM,win6):
					won=True
					banner(COM)
				if winning(board,human,win7):
					won=True
					banner(human)
				elif winning(board,COM,win7):
					won=True
					banner(COM)
				if winning(board,human,win8):
					won=True
					banner(human)
				elif winning(board,COM,win8):
					won=True
					banner(COM)
				else:
					pass
			#print 'Won = ' + str(won)
			turn=turn+1
		again=raw_input('Do you want to play again Y\N:? ')
		again=again.upper()
		if again=='Y':
			play=True
		else:
			play=False
	

main()