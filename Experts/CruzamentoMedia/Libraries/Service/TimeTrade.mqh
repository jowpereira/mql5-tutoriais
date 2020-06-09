//+------------------------------------------------------------------+
//|                                                    TimeTrade.mqh |
//|                                     Copyright 2020, Lethan Corp. |
//|                           https://www.mql5.com/pt/users/14134597 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Lethan Corp."
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.00"


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CTimeTrade
  {
private:
   //--
   MqlDateTime        m_time_open;
   MqlDateTime        m_time_stop;
   MqlDateTime        m_time_close;
   string             m_timeOpen;
   string             m_timeStop;
   string             m_timeClose;
protected:
   bool               CheckTimeTrade(void);
   bool               CheckTimeEndTrade(void);
   void               TimeAdjustment(void);
   void               SetTime(string timeOpen, string timeStop, string timeClose);
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CTimeTrade::TimeAdjustment(void)
  {
   TimeToStruct(StringToTime(m_timeOpen),m_time_open);
   TimeToStruct(StringToTime(m_timeStop),m_time_stop);
   TimeToStruct(StringToTime(m_timeClose),m_time_close);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CTimeTrade::CheckTimeTrade(void)
  {
   MqlDateTime timeNow;
   TimeLocal(timeNow);

   if(timeNow.hour >= m_time_open.hour && timeNow.hour <= m_time_stop.hour)
     {
      if(timeNow.hour == m_time_open.hour)
        {
         if(timeNow.min >= m_time_open.min)
            return true;
         else
            return false;
        }
      if(timeNow.hour == m_time_stop.hour)
        {
         if(timeNow.min <= m_time_stop.min)
            return true;
         else
            return false;
        }
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CTimeTrade::CheckTimeEndTrade(void)
  {
   MqlDateTime timeNow;
   TimeLocal(timeNow);
   if(timeNow.hour >= m_time_close.hour)
     {
      if(timeNow.hour == m_time_close.hour)
         if(timeNow.min >= m_time_close.min)
           {
            return true;
           }
         else
           {
            return false;
           }
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CTimeTrade::SetTime(string timeOpen,string timeStop,string timeClose)
  {
   m_timeOpen  = timeOpen;
   m_timeStop  = timeStop;
   m_timeClose = timeClose;
  }