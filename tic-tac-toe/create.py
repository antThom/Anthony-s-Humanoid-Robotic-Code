import analyzeData as AD

def createData(humMove,comMove,gameNum,turn,meth):
	# Data should be created and uploaded after every turn
	
	# Split the board into human and computer moves
	turn -= 1
	file = open('ant.csv','a')
	file.write(str(gameNum))
	file.write(',')
	file.write(str(humMove))
	file.write(',')
	file.write(str(comMove))
	file.write(',')
	file.write(str(turn))
	file.write(',')
	file.write(str(meth))
	file.write(',')
	file.write('\n')
	file.close()
	

def initialWrite():
	# The initial line should write the names of each variable at the top of the file.
	# Variable names are: game, human, turn , comp, winMeth

	file = open('ant.csv','w')
	file.write('game, human, comp, turn, winMeth,\n')
	file.close()
