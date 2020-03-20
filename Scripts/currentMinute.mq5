//+------------------------------------------------------------------+
//|                                                currentMinute.mq5 |
//|                                 Copyright 2020, Jonathan Pereira |
//|                          https://www.mql5.com/pt/users/14134597  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Jonathan Pereira"
#property link      "https://www.mql5.com/pt/users/14134597"
#define SCRIPT_VERSION  "1.00"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart()
  {
   datetime time[];
   if(CopyTime(Symbol(), Period(), 0, 1, time) < 1)
      Print("Erro ao recuperar timeCurrent");
   Print(time[0]);

  }
//+------------------------------------------------------------------+
