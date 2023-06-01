#include<iostream>
using namespace std;
struct Student
{
	string Name;
	string Reg_No;
	int marks[5];
	string Grade;
	int sum=0;
	string grade(float total)
	{
		float mark;
		mark=(total/500);
		mark=mark*100;
		if(mark<50)
		return "F";
		else if(mark>=50&&mark<60)
		return "C";
		else if(mark>=60&&mark<70)
		return "C+";
		else if(mark>=70&&mark<80)
		return "B";
		else if(mark>=80&&mark<90)
		return "B+";
		else if(mark>=90&&mark<=100)
		return "A";
		else
		return "None";
	}
	void calculations()
	{
		for(int i=0;i<5;i++)
		{
			sum=sum+marks[i];
		}
		Grade=grade(sum);
		cout<<"Im Grade"<<Grade;
	}
};
int main()
{
	Student Arr[3];
	for(int i=0;i<3;i++)
	{
		cout<<"Student "<<i+1<<" : \n";
		cout<<"Enter Name   : ";
		cin.ignore();
		getline(cin,Arr[i].Name);
		cout<<"Enter Reg No : ";
		getline(cin,Arr[i].Reg_No);
		for(int j=0;j<5;j++)
		{
			cout<<"Enter Subject "<<j+1<<" marks : ";
			cin>>Arr[i].marks[j];
		}
		Arr[i].calculations();
	}
	for(int i=0;i<3;i++)
	{
		cout<<"\nName    : "<<Arr[i].Name;
		cout<<"\nReg No  : "<<Arr[i].Reg_No;
		cout<<"\nMarks   : "<<Arr[i].sum;
		cout<<"\nGrade   : "<<Arr[i].Grade;
	}
	return 0;
}
