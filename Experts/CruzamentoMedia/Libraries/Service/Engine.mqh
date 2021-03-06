//+------------------------------------------------------------------+
//|                                                       Engine.mqh |
//|                                     Copyright 2020, Lethan Corp. |
//|                           https://www.mql5.com/pt/users/14134597 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Lethan Corp."
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.00"
#include "\TimeTrade.mqh"
#include "\NewBar.mqh"
#include "..\Model\MoveAverage.mqh"
#include "..\Enums\TypeEvent.mqh"
#include <Trade\Trade.mqh>
#include <Arrays\ArrayObj.mqh>

#include <ClassControlPanel.mqh>
#include <Trade\SymbolInfo.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CEngine : private CTimeTrade
  {
private:
   bool               m_sinal_compra;
   bool               m_sinal_venda;
   bool               m_comprado;
   bool               m_vendido;
   string             m_symbol;
   ENUM_TIMEFRAMES    m_time_frame;
   //--
   CTrade             *m_trade;
   ulong              m_magic;
   ulong              m_deviation;
   float              m_lot;
   bool               m_reverse_position;
   bool               CrossOver(void);
   bool               CrossUnder(void);
   void               CheckPosition(void);
   void               InitPosition(void);
   void               CloseAtMarket(void);
   TypeEvent          m_event;
   bool               CheckMoneyForTrade(string symb,double lots,ENUM_ORDER_TYPE type);

   //--
   void               NewBar(void);
   bool               AddBar(string symbol,ENUM_TIMEFRAMES timeframe);
   CArrayObj          m_bars_detectors;
   void               CallFunctions(void);

public:
                     CEngine(void);
                     CEngine(string symbol, ENUM_TIMEFRAMES tf);
                    ~CEngine(void);

   //-- moving average objects
   CMoveAverage       *m_fast_ma;
   CMoveAverage       *m_slow_ma;

   void               MagicNumber(ulong magic) { m_magic=magic; }
   void               Deviation(ulong deviation) { m_deviation=deviation; }
   void               Lot(float lot) { m_lot=lot; }
   void               ReversePosition(bool reverse) { m_reverse_position=reverse; }
   virtual void       OnTick(void);
   virtual bool       OnInit(void);

   void               Time(string open,string stop,string close) { SetTime(open,stop,close); }
   void               Event(TypeEvent event) { m_event=event; }
   bool               Comprado(void) { CEngine::CheckPosition(); return m_comprado; }
   bool               Vendido(void) { CEngine::CheckPosition(); return m_vendido; }
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CEngine::CEngine(void) : m_symbol(Symbol()), m_time_frame(Period())
  {
   if(m_trade == NULL)
      m_trade = new CTrade();

   if(m_fast_ma == NULL)
      m_fast_ma = new CMoveAverage();

   if(m_slow_ma == NULL)
      m_slow_ma = new CMoveAverage();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CEngine::CEngine(string symbol,ENUM_TIMEFRAMES tf)
  {
   m_symbol        = symbol;
   m_time_frame    = tf;

   if(m_trade == NULL)
      m_trade = new CTrade();

   if(m_fast_ma == NULL)
      m_fast_ma = new CMoveAverage();

   if(m_slow_ma == NULL)
      m_slow_ma = new CMoveAverage();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CEngine::~CEngine(void)
  {
   if(m_trade != NULL)
     {
      delete m_trade;
      m_trade = NULL;
     }

   if(m_fast_ma != NULL)
     {
      delete m_fast_ma;
      m_fast_ma = NULL;
     }

   if(m_slow_ma != NULL)
     {
      delete m_slow_ma;
      m_slow_ma = NULL;
     }
  }
//+------------------------------------------------------------------+
//| Return true if fast ma cross slow ma over. Otherwise return      |
//| false.                                                           |
//+------------------------------------------------------------------+
bool CEngine::CrossOver(void)
  {

   if(m_fast_ma[1]>m_slow_ma[1] && m_fast_ma[2]<m_slow_ma[2])
     {
      m_sinal_compra = true;
      return true;
     }

   return false;
  }
//+------------------------------------------------------------------+
//| Return true if fast ma cross slow ma under. Otherwise return     |
//| false.                                                           |
//+------------------------------------------------------------------+
bool CEngine::CrossUnder(void)
  {
   if(m_fast_ma[1]<m_slow_ma[1] && m_fast_ma[2]>m_slow_ma[2])
     {
      m_sinal_venda = true;
      return true;
     }

   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CEngine::CheckPosition(void)
  {
   if(PositionSelect(m_symbol))
     {
      //--- se a posição for comprada
      if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
        {
         m_comprado = true;
        }
      //--- se a posição for vendida
      if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
        {
         m_vendido = true;
        }
     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CEngine::InitPosition(void)
  {
   if(!CheckMoneyForTrade(m_symbol,m_lot, ORDER_TYPE_BUY))
      return;

   if(!CheckMoneyForTrade(m_symbol,m_lot, ORDER_TYPE_SELL))
      return;

   if(!m_comprado && !m_vendido)
     {
      if(m_sinal_compra)
        {
         m_trade.Buy(m_lot,m_symbol,0,0,0,"Compra a mercado");
        }
      if(m_sinal_venda)
        {
         m_trade.Sell(m_lot,m_symbol,0,0,0,"Venda a mercado");
        }
     }
   else
     {
      if(m_comprado)
        {
         if(m_sinal_venda)
           {
            m_trade.Sell(m_reverse_position?m_lot*2:m_lot,m_symbol,0,0,0,"Virada de mão (compra->venda)");
           }
        }
      else
         if(m_vendido)
           {
            if(m_sinal_compra)
              {
               m_trade.Buy(m_reverse_position?m_lot*2:m_lot,m_symbol,0,0,0,"Virada de mão (venda->compra)");
              }
           }
     }

   m_sinal_compra = false;
   m_sinal_venda  = false;
   m_comprado     = false;
   m_vendido      = false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CEngine::CloseAtMarket(void)
  {
   for(int i = PositionsTotal()-1; i>=0; i--)
     {
      if(PositionGetSymbol(i) == m_symbol && PositionGetInteger(POSITION_MAGIC) == m_magic)
        {
         if(!m_trade.PositionClose(PositionGetInteger(POSITION_TICKET), m_deviation))
           {
            Print("Falha. ResultRetcode: ", m_trade.ResultRetcode(), ", RetcodeDescription: ", m_trade.ResultRetcodeDescription());
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CEngine::NewBar(void)
  {
   if(m_bars_detectors.Total()==0)
      AddBar(m_symbol,m_time_frame);
   for(int i=0; i<m_bars_detectors.Total(); i++)
     {
      CNewBar *bar=m_bars_detectors.At(i);
      if(bar.IsNewBar())
         CEngine::CallFunctions();
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CEngine::AddBar(string symbol,ENUM_TIMEFRAMES timeframe)
  {
   for(int i=0; i<m_bars_detectors.Total(); i++)
     {
      CNewBar *d=m_bars_detectors.At(i);
      if(d.Symbol()==symbol && d.Timeframe()==timeframe)
        {
         string text="You are already subscribed to the opening bars of said symbol and timeframe.";
         ::Print(text);
         return false;
        }
     }
   datetime time[];
   if(CopyTime(symbol,timeframe,0,3,time)==0)
     {
      string text="A symbol "+symbol+" that you want to monitor is not available in the terminal."+
                  " Make sure that the name of the instrument and its timeframe"+EnumToString(timeframe)+" are correct.";
      ::Print(text);
      return false;
     }
   CNewBar *bar=new CNewBar(symbol,timeframe);
   return m_bars_detectors.Add(bar);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CEngine::CallFunctions(void)
  {
   if(!CEngine::CheckTimeTrade())
      return;

   if(CEngine::CheckTimeEndTrade())
     {
      CEngine::CloseAtMarket();
      return;
     }

   if(CEngine::CrossOver())
     {
      CEngine::CheckPosition();
      CEngine::InitPosition();
     }
   if(CEngine::CrossUnder())
     {
      CEngine::CheckPosition();
      CEngine::InitPosition();
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CEngine::CheckMoneyForTrade(string symb,double lots,ENUM_ORDER_TYPE type)
  {
//--- obtemos o preço de abertura
   MqlTick mqltick;
   SymbolInfoTick(symb,mqltick);
   double price=mqltick.ask;
   if(type==ORDER_TYPE_SELL)
      price=mqltick.bid;
//--- valores da margem necessária e livre
   double margin,free_margin=AccountInfoDouble(ACCOUNT_MARGIN_FREE);
//--- chamamos a função de verificação
   if(!OrderCalcMargin(type,symb,lots,price,margin))
     {
      //--- algo deu errado, informamos e retornamos false
      Print("Error in ",__FUNCTION__," code=",GetLastError());
      return(false);
     }
//--- se não houver fundos suficientes para realizar a operação
   if(margin>free_margin)
     {
      //--- informamos sobre o erro e retornamos false
      Print("Not enough money for ",EnumToString(type)," ",lots," ",symb," Error code=",GetLastError());
      return(false);
     }
//--- a verificação foi realizada com sucesso
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CEngine::OnInit(void)
  {
   m_trade.SetDeviationInPoints(m_deviation*SymbolInfoDouble(m_symbol, SYMBOL_POINT));
   m_trade.SetExpertMagicNumber(m_magic);
   CEngine::TimeAdjustment();
   if(CheckPointer(GetPointer(m_fast_ma))!=POINTER_INVALID || CheckPointer(GetPointer(m_slow_ma))!=POINTER_INVALID)
      return true;

   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CEngine::OnTick(void)
  {
   if(m_event == EVENT_NEW_BAR)
      CEngine::NewBar();
   else
      CEngine::CallFunctions();
  }
//+------------------------------------------------------------------+
