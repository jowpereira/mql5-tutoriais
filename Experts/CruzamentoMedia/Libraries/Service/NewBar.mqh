//+------------------------------------------------------------------+
//|                                                       newBar.mq5 |
//|                               Copyright 2020, Lethan Consultoria |
//|                          https://www.mql5.com/pt/users/14134597  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Lethan Consultoria"
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.01"
//Desing Class detects new bar
#include <Object.mqh>
//+------------------------------------------------------------------+
//| New bar detector                                                 |
//+------------------------------------------------------------------+
class CNewBar : public CObject
  {
private:
   ENUM_TIMEFRAMES   m_timeframe;
   string            m_symbol;
   datetime          m_last_time;
public:
                     CNewBar(void);
                     CNewBar(string symbol,ENUM_TIMEFRAMES timeframe);
   void              Timeframe(ENUM_TIMEFRAMES tf);
   ENUM_TIMEFRAMES   Timeframe(void);
   void              Symbol(string symbol);
   string            Symbol(void);

   bool              IsNewBar(void);
  };
//+------------------------------------------------------------------+
//| construtor                                                       |
//+------------------------------------------------------------------+
CNewBar::CNewBar(void)
  {
   m_symbol=Symbol();
   m_timeframe=Period();
  }
//+------------------------------------------------------------------+
//| construtor                                                       |
//+------------------------------------------------------------------+
CNewBar::CNewBar(string symbol,ENUM_TIMEFRAMES tf)
  {
   m_symbol=symbol;
   m_timeframe=tf;
  }
//+------------------------------------------------------------------+
//| set timeFrame                                                    |
//+------------------------------------------------------------------+
void CNewBar::Timeframe(ENUM_TIMEFRAMES tf)
  {
   m_timeframe=tf;
  }
//+------------------------------------------------------------------+
//| get timeFrame                                                    |
//+------------------------------------------------------------------+
ENUM_TIMEFRAMES CNewBar::Timeframe(void)
  {
   return m_timeframe;
  }
//+------------------------------------------------------------------+
//| set Symbol                                                       |
//+------------------------------------------------------------------+
void CNewBar::Symbol(string symbol)
  {
   m_symbol=symbol;
  }
//+------------------------------------------------------------------+
//| get Symbol                                                       |
//+------------------------------------------------------------------+
string CNewBar::Symbol(void)
  {
   return m_symbol;
  }
//+------------------------------------------------------------------+
//| detector new bar                                                 |
//+------------------------------------------------------------------+
bool CNewBar::IsNewBar(void)
  {
   datetime time[];
   if(CopyTime(m_symbol, m_timeframe, 0, 1, time) < 1)
      return false;
   if(time[0] == m_last_time)
      return false;
   return m_last_time = time[0];
  }
//+------------------------------------------------------------------+
