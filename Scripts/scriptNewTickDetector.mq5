//+------------------------------------------------------------------+
//|                                        scriptNewTickDetector.mq5 |
//|                                 Copyright 2020, Jonathan Pereira |
//|                          https://www.mql5.com/pt/users/14134597  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Jonathan Pereira"
#property link      "https://www.mql5.com/pt/users/14134597"
#define SCRIPT_VERSION  "1.02"

#include "..\Include\newTick.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CNewTick *tick=new CNewTick();
int i =0;
void OnStart()
  {
   while(!IsStopped())
     {
      if(tick.IsNewTick())
         Print("Novo evento de tick");
     }

  }
//+------------------------------------------------------------------+
