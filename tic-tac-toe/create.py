#import tictactoe as t3

def createData(humMove,gameNum,turn,meth):
	# Data should be created and uploaded after every turn
	
	# Split the board into human and computer moves
	turn -= 1
	'''
	print('in CD')
	print('HUMAN POSITION = ' + str(humMove))
	print('turn = ' + str(turn))
	print('gameNumber = '+ str(gameNum))
	print('method = ' + str(meth))
	'''
	
	file = open('ant.csv','a')
	file.write(str(gameNum))
	file.write(',')
	file.write(str(humMove))
	file.write(',')
	file.write(str(turn))
	file.write(',')
	file.write(str(meth))
	file.write(',')
	file.write('\n')
	file.close()
	
	#g=[1,6,3,2]
	#print(type(g))

def initialWrite():
	# The initial line should write the names of each variable at the top of the file.
	# Variable names are: game, human, turn , comp, winMeth

	file = open('ant.csv','w')
	file.write('game, human, turn, winMeth,\n')
	file.close()
