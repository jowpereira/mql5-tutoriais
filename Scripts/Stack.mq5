//+------------------------------------------------------------------+
//|                                                        Stack.mq5 |
//|                                     Copyright 2020, Lethan Corp. |
//|                           https://www.mql5.com/pt/users/14134597 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Lethan Corp."
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.00"

#include <Generic\Stack.mqh>
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
   CStack<int> s;
   s.Push(10);
   s.Push(30);
   s.Push(20);
   s.Push(5);
   s.Push(1);

   Print("The stack is : ");
   showstack(s);
   s.Push(10);
   s.Push(30);
   s.Push(20);
   s.Push(5);
   s.Push(1);
   Print("\ns.size() : ", s.Count());
   Print("\ns.top() : ", s.Peek());

  }
//+------------------------------------------------------------------+
void showstack(CStack<int> &s)
  {
   int t = s.Count();
   for(int i=0; i < t; i++)
     {
      Print("\t ",s.Peek());
      s.Pop();
     }
   Print("\n");
  }
//+------------------------------------------------------------------+
