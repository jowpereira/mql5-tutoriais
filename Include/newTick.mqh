//+------------------------------------------------------------------+
//|                                                      newTick.mq5 |
//|                               Copyright 2020, Lethan Consultoria |
//|                          https://www.mql5.com/pt/users/14134597  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Lethan Consultoria"
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.00"
#include <Object.mqh>
//+------------------------------------------------------------------+
//| New tick detector                                                |
//+------------------------------------------------------------------+
class CNewTick : public CObject
  {
private:
   string            m_symbol;
   MqlTick           m_last_tick;
public:
                     CNewTick(void);
                     CNewTick(string symbol);
   string            Symbol(void);
   void              Symbol(string symbol);
   bool              IsNewTick(void);
  };
  
CNewTick::CNewTick(void)
  {
   m_symbol=_Symbol;
  }
  
CNewTick::CNewTick(string symbol)
  {
   m_symbol=symbol;
  }
  
void CNewTick::Symbol(string symbol)
  {
   m_symbol=symbol;
  }
  
string CNewTick::Symbol(void)
  {
   return m_symbol;
  }
  
bool CNewTick::IsNewTick(void)
  {
   MqlTick tick;
   SymbolInfoTick(m_symbol,tick);
   if(tick.last!=m_last_tick.last || 
      tick.time!=m_last_tick.time)
     {
      m_last_tick=tick;
      return true;
     }
   return false;
  }
