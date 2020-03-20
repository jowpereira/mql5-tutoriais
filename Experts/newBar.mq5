//+------------------------------------------------------------------+
//|                                                       newBar.mq5 |
//|                               Copyright 2020, Lethan Consultoria |
//|                          https://www.mql5.com/pt/users/14134597  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Lethan Consultoria"
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.00"

#include "..\Include\CBarDetector.mqh"
//+------------------------------------------------------------------+
//|                     inicio EA                                    |
//+------------------------------------------------------------------+
CBarDetector *bar=new CBarDetector();
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   bar.Symbol(Symbol());
   bar.Timeframe(Period());
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
   if(bar.IsNewBar())
      Print("nova barra");
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
         bar.Symbol(Symbol());
         bar.Timeframe(Period());
         text="Symbol or timeframe was changed";
         break;
      case REASON_CHARTCLOSE:
         delete bar;
         text="Chart was closed";
         break;
     }
//---
   return text;
  }