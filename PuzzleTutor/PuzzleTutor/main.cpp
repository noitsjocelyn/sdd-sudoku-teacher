#include "Teacher.h"
#include <iostream>
#include <vector>
#include <string>
using namespace std;

void main(){
	int puzzle[81];
	string aPuzzle = "000105000140000670080002400063070010900000003010090520007200080026000035000409000"; //easy
	//string aPuzzle = "000004028406000005100030600000301000087000140000709000002010003900000507670400000"; //gentle
	//string aPuzzle = "400010000000309040070005009000060021004070600190050000900400070030608000000030006"; //moderate
	for (int i = 0; i < 81; i++)
	{
		cout << int(aPuzzle[i]) - 48;
		puzzle[i] = int(aPuzzle[i]) - 48;
	}

	Teacher thePuzzle(puzzle);
	thePuzzle.printPuzzle();
	while(thePuzzle.fillSquare(thePuzzle.hint()))
	{
		;
	}
	thePuzzle.printPuzzle();
	system("pause");
}