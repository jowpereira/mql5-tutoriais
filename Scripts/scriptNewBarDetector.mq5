//+------------------------------------------------------------------+
//|                                         scriptNewBarDetector.mq5 |
//|                                 Copyright 2020, Jonathan Pereira |
//|                          https://www.mql5.com/pt/users/14134597  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Jonathan Pereira"
#property link      "https://www.mql5.com/pt/users/14134597"
#define SCRIPT_VERSION  "1.01"

#include "..\Include\newBar.mqh"
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
     }

  }
//+------------------------------------------------------------------+
