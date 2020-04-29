//+------------------------------------------------------------------+
//|                                         MinimumNumberofCoins.mq5 |
//|                                      Copyright 2020,Lethan Corp. |
//|                           https://www.mql5.com/pt/users/14134597 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020,Lethan Corp."
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.00"

//A greedy algorithm is an algorithm used to find an optimal solution for the given problem.
//greedy algorithm works by finding locally optimal solutions ( optimal solution for a part of the problem)
//of each part so show the Global optimal solution could be found.
//In this problem, we will use a greedy algorithm to find the minimum number of coins/ notes that could makeup
//to the given sum. For this we will take under consideration all the valid coins or notes i.e.
//denominations of { 1, 2, 5, 10, 20, 50 }. And we need to return the number of these coins/notes
//we will need to make up to the sum. Let’s take a few examples to understand the context better −

#include <Generic\ArrayList.mqh>

namespace EpsilonGreedy
{
int notes[] = { 1, 2, 5, 10, 20, 50, 100};

// Driver program
void findMin(int V)
 {
// Initialize result
  CArrayList<int> coins;

// Traverse through all notesmination
  for(int i=(sizeof(notes)/sizeof(notes[0]))-1; i >= 0; i--)
   {
    // Find notesminations
    while(V >= notes[i])
     {
      V -= notes[i];
      coins.Add(notes[i]);
     }
   }
// Print result
  for(int i = 0; i<coins.Count(); i++)
   {
    int value_return;
    coins.TryGetValue(i, value_return);

    Print(value_return);
   }
 }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart(void)
 {

  int x = 93;
  Print("Following is minimal number of change for ", x,  " is ");
  EpsilonGreedy::findMin(x);
 }

//+------------------------------------------------------------------+
