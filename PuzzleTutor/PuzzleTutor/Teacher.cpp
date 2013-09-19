#include "Teacher.h"

Teacher::Teacher()
{
	for (int i = 0; i < 81; i++)
	{
		puzzle[i / 9][i % 9] = 0;
		for (int j = 0; j < 9; j++)
		{
			avail[i / 9][i % 9][j+1] = 1;
		}
		avail[i / 9][i % 9][0] = 9;
	}
}

Teacher::Teacher(int aPuzzle[81])
{
	for (int i = 0; i < 81; i++)
	{
		puzzle[i / 9][i % 9] = aPuzzle[i];
	}
	findAvail();
}

void Teacher::findAvail()
{
	for (int i = 0; i < 81; i++)
	{
		for (int j = 0; j < 9; j++)
		{
			avail[i / 9][i % 9][j+1] = 1;
		}
		avail[i / 9][i % 9][0] = 9;
		if (puzzle[i / 9][i % 9] == 0)
		{
			bool holder[9];
			for (int j = 0; j < 9; j++)
			{
				holder[j] = false;
			}
			for (int j = 0; j < 9; j++)
			{
				int temp;
				temp = puzzle[((i / 9 ) / 3) * 3 + (j / 3)][(( i % 9 ) / 3) * 3 + (j % 3)];
				if (temp != 0 && holder[temp - 1] == false)
				{
					holder[temp - 1] = true;
				}
				temp = puzzle[j][i % 9];
				if (temp != 0 && holder[temp - 1] == false)
				{
					holder[temp - 1] = true;
				}
				temp = puzzle[i / 9][j];
				if (temp != 0 && holder[temp - 1] == false)
				{
					holder[temp - 1] = true;
				}
			}
			for (int j = 0; j < 9; j++)
			{
				if (holder[j] == false)
				{
					avail[i / 9][i % 9][j+1] = 0;
					avail[i / 9][i % 9][0] -= 1;
				}
			}
		}
	}
}

void Teacher::printPuzzle()
{
	for (int i = 0; i < 81; i++)
	{
		if ( i % 9 == 0)
		{
			cout << endl;
		}
		cout << puzzle[i / 9][i % 9];
	}
	cout << endl;
}

void Teacher::printAvail(int x, int y)
{
	for (int i = 0; i < avail[x][y][0]; i++)
	{
		cout << avail[x][y][i+1];
	}
	cout << endl;
}

vector <int> Teacher::checkEight()
{
	for (int i = 0; i < 9; i++)
	{
		int numFilled = 0;
		int position = 0;
		for (int j = 0; j < 9; j++)
		{
			if (puzzle[i][j] != 0)
			{
				numFilled++;
			}
			else if (position == 0)
			{
				position = i*9 + j;
			}
		}
		if (numFilled == 8)
		{
			vector <int> results;
			results.push_back(1);
			results.push_back(1);
			results.push_back(position);
			return results;
		}
		numFilled = 0;
		position = 0;
		for (int j = 0; j < 9; j++)
		{
			if (puzzle[j][i] != 0)
			{
				numFilled++;
			}
			else if (position == 0)
			{
				position = j*9 + i;
			}
		}
		if (numFilled == 8)
		{
			vector<int> results;
			results.push_back(1);
			results.push_back(2);
			results.push_back(position);
			return results;
		}	
		numFilled = 0;
		position = 0;
		for (int j = 0; j < 9; j++)
		{
			if (puzzle[(i % 3) * 3 + j % 3][(i / 3) * 3 + j / 3] != 0)
			{
				numFilled++;
			}
			else if (position == 0)
			{
				position = ((i % 3) * 3 + j % 3) * 9 + (i / 3) * 3 + j / 3;
			}
		}
		if (numFilled == 8)
		{
			vector<int> results;
			results.push_back(1);
			results.push_back(3);
			results.push_back(position);
			return results;
		}
	}
	vector<int> results;
	results.push_back(0);
	return results;
}

vector <int> Teacher::oneAvail()
{
	for (int i = 0; i < 81; i++)
	{
		if (avail[i / 9][i % 9][0] == 1)
		{
			vector<int> results;
			results.push_back(2);
			results.push_back(i);
			return results;
		}
	}
	vector<int> results;
	results.push_back(0);
	return results;
}

vector <int> Teacher::onlyLocation()
{
	for(int i = 0; i < 9; i++)
	{
		for (int j = 1; j < 10; j++)
		{
			int location = -1;
			for (int k = 0; k < 9; k++)
			{
				if (puzzle[i][k] == j)
				{
					break;
				}
				else
				{
					for (int l = 0; l < avail[i][k][0]; l++)
					{
						if (avail[i][k][l+1] == j)
						{
							if (location != -1)
							{
								location = -2;
								break;
							}
							else if (location != -2)
							{
								location = 9 * i + k;
							}
						}
					}
				}
			}
			if (location > -1)
			{
				vector<int> results;
				results.push_back(3);
				results.push_back(1);
				results.push_back(location);
				results.push_back(j);
				return results;
			}
			location = -1;
			for (int k = 0; k < 9; k++)
			{
				if (puzzle[k][i] == j)
				{
					break;
				}
				else
				{
					for (int l = 0; l < avail[k][i][0]; l++)
					{
						if (avail[k][i][l+1] == j)
						{
							if (location != -1)
							{
								location = -2;
								break;
							}
							else if (location != -2)
							{
								location = 9 * k + i;
							}
						}
					}
				}
			}
			if (location > -1)
			{
				vector<int> results;
				results.push_back(3);
				results.push_back(2);
				results.push_back(location);
				results.push_back(j);
				return results;
			}
			location = -1;
			for (int k = 0; k < 9; k++)
			{
				if (puzzle[(i % 3) * 3 + k % 3][(i / 3) * 3 + k / 3] == j)
				{
					break;
				}
				else
				{
					for (int l = 0; l < avail[(i % 3) * 3 + k % 3][(i / 3) * 3 + k / 3][0]; l++)
					{
						if (avail[(i % 3) * 3 + k % 3][(i / 3) * 3 + k / 3][l+1] == j)
						{
							if (location == -1)
							{
								location = ((i % 3) * 3 + k % 3) * 9 + (i / 3) * 3 + k / 3;
							}
							else if (location != -2)
							{
								location = -2;
								break;
							}
						}
					}
				}
			}
			if (location > -1)
			{
				vector<int> results;
				results.push_back(3);
				results.push_back(3);
				results.push_back(location);
				results.push_back(j);
				return results;
			}
		}
	}
	vector<int> results;
	results.push_back(0);
	return results;
}

vector <int> Teacher::hint()
{
	//printPuzzle();
	vector<int> results;
	results = checkEight();
	if (results.size() != 1)
	{
		if (results[1] == 1)
		{
			cout << "Row " << results[2] / 9 << " has 8." << endl;
		}
		else if (results[1] == 2)
		{
			cout << "Column " << results[2] % 9 << " has 8." << endl;
		}
		else
		{
			cout << "Box " << ((results[2] % 9) / 3) + ((results[2] / 9) / 3) * 3 << " has 8." << endl;
		}
		return results;
	}
	results = oneAvail();
	if (results.size() != 1)
	{
		cout << "Location " << results[1] << " has only 1 option available." << endl;
		return results;
	}
	results = onlyLocation();
	if (results.size() != 1)
	{
		if (results[1] == 1)
		{
			cout << "Row " << results[2] / 9 << " has a number with only 1 location it can go." << endl;
		}
		else if (results[1] == 2)
		{
			cout << "Column " << results[2] % 9 << " has a number with only 1 location it can go." << endl;
		}
		else
		{
			cout << "Box " << ((results[2] % 9) / 3) + ((results[2] / 9) / 3) * 3 << " has a number with only 1 location it can go." << endl;
		}
		return results;
	}
	cout << "No move could be made." << endl;
	return results;
}

int Teacher::findOnlyAvail(int loc)
{
	for (int i = 0; i < 9; i++)
	{
		if (avail[loc / 9][loc % 9][i+1] == 1)
		{
			return i+1;
		}
	}
}

bool Teacher::fillSquare(vector<int> results)
{
	if (results[0] == 0)
	{
		return false;
	}
	if (results[0] == 3)
	{
		puzzle[results[2] / 9][results[2] % 9] = results[3];
	}
	if (results[0] == 1 || results[0] == 2)
	{
		puzzle[results[results.size()-1] / 9][results[results.size()-1] % 9] = avail[results[results.size()-1] / 9][results[results.size()-1] % 9][findOnlyAvail(results[results.size()-1])];
	}
	findAvail();
	return true;
}