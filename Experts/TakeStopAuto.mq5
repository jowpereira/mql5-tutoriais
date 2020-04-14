//+------------------------------------------------------------------+
//|                                                    TakeStopAuto  |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.lethancorp.net  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Jonathan Pereira"
#property version  "1.00"

#include <CtraillingCustom.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CTraillingCuston *trailing=new CTraillingCuston();
//---
input    double   trailingstop = 40;          // TrailingStop
input    double   trailingstep = 40;          // TrailingStep
input    double   takeprofit   = 100;         // TakeProfit
input    double   stoploss     = 100;         // StopLoss

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
 {

  trailing.TrailingStop(trailingstop);
  trailing.TrailingStep(trailingstep);
  trailing.TakeProfit(takeprofit);
  trailing.StopLoss(stoploss);
  return(INIT_SUCCEEDED);
 }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
 {
//---

 }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
 {
  trailing.Run();
 }
//+------------------------------------------------------------------+
