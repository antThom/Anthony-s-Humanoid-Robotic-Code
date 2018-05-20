import csv

'''
	1. Get the data from a file
	2. Determine which games were wins or loses for the computer
	3. For computer loses, find a pattern
		- Look at where the human plays after the computer makes a move
		- Determine whether or not the human is an offensive or defensive player
		- Find an algorithm to use as the computer to play against the human
	'''

def orderData():
	gameNum=[]
	humPos=[]
	comPos=[]
	turn=[]
	method=[]
	with open('ant.csv','r') as csvfile:
		reader = csv.DictReader(csvfile, fieldnames=("gameNum","hum","com","turn","winMeth"))
		for row in reader:
			if (row['gameNum'] != 'game'):
				# In this loop you will save all data in their cooresponding fieldnames
				gameNum.append(row['gameNum'])
				humPos.append(row['hum'])
				comPos.append(row['com'])
				turn.append(row['turn'])
				method.append(row['winMeth'])
			#if (method[row] != 0):
				#comWin=winOrLose(method)
				#print comWin
				#print type(method[0])
		'''
		print gameNum
		print humPos
		print comPos
		print turn
		'''
		print method
		#print len(method)
		print method[len(method)-1]
		

def winOrLose(method):
	if method > 0:
		comWin=True
	elif method < 0:
		comWin=False
	else:
		comWin=-1
	return comWin

def main():
	orderData()
	

main()