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
				gameNum.append(int(row['gameNum']))
				humPos.append(int(row['hum']))
				comPos.append(int(row['com']))
				turn.append(int(row['turn']))
				method.append(int(row['winMeth']))

		# Remove all zeros from each list
		method=list(filter(lambda a: a!=0, method))
		humPos=list(filter(lambda a: a!=0, humPos))
		comPos=list(filter(lambda a: a!=0, comPos))
		gameNum=list(set(gameNum))
		print comPos
		print humPos
		print method
		print gameNum
		print turn
		
		

def main():
	orderData()
	

main()