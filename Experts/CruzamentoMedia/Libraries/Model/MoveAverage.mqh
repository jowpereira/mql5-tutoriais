//+------------------------------------------------------------------+
//|                                                  MoveAverage.mqh |
//|                                     Copyright 2020, Lethan Corp. |
//|                           https://www.mql5.com/pt/users/14134597 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Lethan Corp."
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.00"


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CMoveAverage
  {
private:

   int                m_ma_handle;
   ENUM_TIMEFRAMES    m_time_frame;
   int                m_ma_period;
   int                m_ma_shift;
   string             m_symbol;
   ENUM_MA_METHOD     m_ma_method;
   ENUM_APPLIED_PRICE m_applied_price;

   void               Init(void);

public:
                     CMoveAverage(void);

   void              MaInit(void);

   void              Timeframe(ENUM_TIMEFRAMES timeframe);
   void              Symbol(string symbol);
   void              MaPeriod(int ma_period);
   void              MaShift(int ma_shift);
   void              MaMethod(ENUM_MA_METHOD method);
   void              AppliedPrice(ENUM_APPLIED_PRICE source);
   double            operator[](int index);

  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CMoveAverage::CMoveAverage(void) : m_ma_handle(INVALID_HANDLE)
  {

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CMoveAverage::MaInit(void)
  {
   if(m_ma_handle!=INVALID_HANDLE)
     {
      bool res=::IndicatorRelease(m_ma_handle);
      if(!res)
        {
         string text="Realise iMA indicator failed. Error ID: "+(string)::GetLastError();
         ::Print(text);
        }
     }
   m_ma_handle=::iMA(m_symbol,m_time_frame,m_ma_period,m_ma_shift,m_ma_method,m_applied_price);
   if(m_ma_handle==INVALID_HANDLE)
     {
      string params="(Period:"+(string)m_ma_period+", Shift: "+(string)m_ma_shift+
                    ", MA Method:"+::EnumToString(m_ma_method)+")";
      string text="Create iMA indicator failed"+params+". Error ID: "+(string)GetLastError();
      ::Print(text);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CMoveAverage::Timeframe(ENUM_TIMEFRAMES tf)
  {
   m_time_frame=tf;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CMoveAverage::MaPeriod(int ma_period)
  {
   m_ma_period=ma_period;;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CMoveAverage::MaMethod(ENUM_MA_METHOD method)
  {
   m_ma_method=method;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CMoveAverage::MaShift(int ma_shift)
  {
   m_ma_shift=ma_shift;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CMoveAverage::AppliedPrice(ENUM_APPLIED_PRICE price)
  {
   m_applied_price = price;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CMoveAverage::Symbol(string symbol)
  {
   m_symbol=symbol;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CMoveAverage::operator[](int index)
  {
   double values[];
   if(m_ma_handle == INVALID_HANDLE)
      return EMPTY_VALUE;
   if(CopyBuffer(m_ma_handle, 0, index, 1, values) == 0)
     {
      string text = "Failed copy buffer of indicator. Last error: " + (string)::GetLastError();
      ::Print(text);
      return EMPTY_VALUE;
     }
   return values[0];
  }
//+------------------------------------------------------------------+
