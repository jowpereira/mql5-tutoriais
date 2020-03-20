//+------------------------------------------------------------------+
//|                                                currentMinute.mq5 |
//|                                 Copyright 2020, Jonathan Pereira |
//|                          https://www.mql5.com/pt/users/14134597  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Jonathan Pereira"
#property link      "https://www.mql5.com/pt/users/14134597"
#define SCRIPT_VERSION  "1.00"

#include "..\Include\newBarDetector.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CNewBar *bar=new CNewBar();
void OnStart()
  {
   while(!IsStopped())
     {
      if(bar.IsNewBar())
         Print("nova barra");
      Sleep(10000);
     }

  }
//+------------------------------------------------------------------+
