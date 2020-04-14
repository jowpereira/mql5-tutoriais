//+------------------------------------------------------------------+
//|                                                CTraillingCuston  |
//|                                      Copyright 2017,Lethan Corp. |
//|                           https://www.mql5.com/pt/users/14134597 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017,Lethan Corp."
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.02"

#include <Trade\PositionInfo.mqh>
#include <Trade\Trade.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CTraillingCuston
 {
private:
  double             m_trailing_stop;
  double             m_trailing_step;
  double             m_tick_size;
  int                m_digits;
  double             m_take_profit;
  double             m_stop_loss;
  string             m_symbol;
  double             NormalizePrice(const double price);
  double             PriceStep(void);
  CPositionInfo      m_position;         // trade position object
  CTrade             m_trade;            // trading object
public:
                     CTraillingCuston(void);
  //---
  void               Run(void);
  void               TrailingStop(double trailingStop);
  void               TrailingStep(double trailingStep);
  void               TakeProfit(double tp);
  void               StopLoss(double sp);
 };
//---
CTraillingCuston::CTraillingCuston(void) : m_symbol(Symbol())
 {
 }
//---
void CTraillingCuston::TrailingStop(double trailingStop)
 {
  m_trailing_stop=trailingStop;
 }
//---
void CTraillingCuston::TrailingStep(double trailingStep)
 {
  m_trailing_step=trailingStep;
 }
//--
void CTraillingCuston::TakeProfit(double tp)
 {
  m_take_profit=tp;
 }
//---
void CTraillingCuston::StopLoss(double sp)
 {
  m_stop_loss=sp;
 }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CTraillingCuston::NormalizePrice(const double price)
 {

  SymbolInfoDouble(m_symbol,SYMBOL_TRADE_TICK_SIZE,m_tick_size);
  m_digits=(int)SymbolInfoInteger(m_symbol, SYMBOL_DIGITS);

  if(m_tick_size!=0)
    return(NormalizeDouble(MathRound(price/m_tick_size)*m_tick_size,m_digits));
//---
  return(round(NormalizeDouble(price,m_digits)));
 }
//
double CTraillingCuston::PriceStep(void)
 {
  return  SymbolInfoDouble(m_symbol, SYMBOL_POINT);
 }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CTraillingCuston::Run(void)
 {
  for(int i=PositionsTotal()-1; i>=0; i--)
    if(m_position.SelectByIndex(i))
      if(m_position.Symbol()==m_symbol)
       {
        //--- add stop gain and stop loss
        if(m_position.TakeProfit()==0 || m_position.StopLoss()==0)
         {
          if(m_position.PositionType()==POSITION_TYPE_BUY)
           {
            m_trade.PositionModify(m_position.Ticket()
                                   ,NormalizePrice(m_position.PriceOpen()-PriceStep()*m_stop_loss)
                                   ,NormalizePrice(m_position.PriceOpen()+PriceStep()*m_take_profit));
           }
          if(m_position.PositionType()==POSITION_TYPE_SELL)
           {
            m_trade.PositionModify(m_position.Ticket()
                                   ,NormalizePrice(m_position.PriceOpen()+PriceStep()*m_stop_loss)
                                   ,NormalizePrice(m_position.PriceOpen()-PriceStep()*m_stop_loss));
           }
         }
        else
         {
          if(m_trailing_stop==0 && m_trailing_step==0)
            break;
          if(m_position.PositionType()==POSITION_TYPE_BUY)
            if(m_position.PriceCurrent()-m_position.PriceOpen()>m_trailing_stop+m_trailing_step)
              if(m_position.StopLoss()<m_position.PriceCurrent()-(m_trailing_stop+m_trailing_step))
               {
                m_trade.PositionModify(m_position.Ticket(),
                                       NormalizePrice(m_position.PriceCurrent()-m_trailing_stop),
                                       m_position.TakeProfit());
               }
          if(m_position.PositionType()==POSITION_TYPE_SELL)
            if(m_position.PriceOpen()-m_position.PriceCurrent()>m_trailing_stop+m_trailing_step)
              if((m_position.StopLoss()>(m_position.PriceCurrent()+(m_trailing_stop+m_trailing_step))) ||
                 (m_position.StopLoss()==0))
               {
                m_trade.PositionModify(m_position.Ticket(),
                                       NormalizePrice(m_position.PriceCurrent()+m_trailing_stop),
                                       m_position.TakeProfit());
               }

         }

       }
 }
//+------------------------------------------------------------------+