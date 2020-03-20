//+------------------------------------------------------------------+
//|                                        expertNewTickDetector.mq5 |
//|                               Copyright 2020, Lethan Consultoria |
//|                          https://www.mql5.com/pt/users/14134597  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Lethan Consultoria"
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.03"

#include "..\Include\newTick.mqh"
//+------------------------------------------------------------------+
//|                     inicio EA                                    |
//+------------------------------------------------------------------+
CNewTick *tick=new CNewTick();
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   Print(__FUNCTION__," UninitializeReason() = ",getMsgDeinitialization(UninitializeReason()));
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   if(tick.IsNewTick())
      Print("Novo evento de tick");
  }
//+------------------------------------------------------------------+
//|   function retrun reason deinitialization in text                |
//+------------------------------------------------------------------+
string getMsgDeinitialization(int reasonCode)
  {
   string text="";
//---
   switch(reasonCode)
     {
      case REASON_CHARTCHANGE:
         text="Symbol or timeframe was changed";
         break;
      case REASON_CHARTCLOSE:
         delete tick;
         text="Chart was closed";
         break;
     }
//---
   return text;
  }
//+------------------------------------------------------------------+
