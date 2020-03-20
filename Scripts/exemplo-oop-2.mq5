//+------------------------------------------------------------------+
//|                                                exemplo-oop-2.mq5 |
//|                                 Copyright 2017, Jonathan Pereira |
//|                          https://www.mql5.com/pt/users/14134597  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Jonathan Pereira"
#property link      "https://www.mql5.com/pt/users/14134597"
#define SCRIPT_VERSION  "1.03"
//---
class CDemo
  {
public:
                     CDemo() { Print("Inicializado"+__FUNCTION__+" Linha " +(string)__LINE__); };
                    ~CDemo() { Print("Desinicializado "+__FUNCTION__+" Linha "+(string)__LINE__); };
   //---
   void              Init(void);
   void              GetInfoAccount(void);
private:
   string            AccountName(void);
   int               AccountNumber(void);
  };
//---
void CDemo::Init(void)
  {
   AccountName();
   AccountNumber();
  }
//--
string CDemo::AccountName(void)
  {
   return(AccountInfoString(ACCOUNT_COMPANY));
  }
//--
int CDemo::AccountNumber(void)
  {
   return(AccountInfoInteger(ACCOUNT_LOGIN));
  }
//--
void CDemo::GetInfoAccount(void)
  {
   Print(AccountName()+"\n"+(string)AccountNumber());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart(void)
  {
   CDemo ExtScript;
   
//---
   ExtScript.Init();
   ExtScript.GetInfoAccount();
  }
//+------------------------------------------------------------------+
