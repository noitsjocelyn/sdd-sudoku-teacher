#pragma once
#include <vector>
#include <iostream>
using namespace std;
class Teacher
{
private:
	short puzzle[9][9];
	short avail[9][9][10];
	void Teacher::findAvail();
	vector <int> Teacher::checkEight();
	vector <int> Teacher::oneAvail();
	vector <int> Teacher::onlyLocation();
	int Teacher::findOnlyAvail(int loc);
public:
	Teacher::Teacher();
	Teacher::Teacher(int aPuzzle[81]);
	bool Teacher::fillSquare(vector<int> results);
	void Teacher::printPuzzle();
	void Teacher::printAvail(int x, int y);
	vector <int> Teacher::hint();
};

