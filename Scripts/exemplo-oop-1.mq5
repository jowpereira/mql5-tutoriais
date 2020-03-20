//+------------------------------------------------------------------+
//|                                                exemplo-oop-1.mq5 |
//|                                 Copyright 2017, Jonathan Pereira |
//|                          https://www.mql5.com/pt/users/14134597  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Jonathan Pereira"
#property link      "https://www.mql5.com/pt/users/14134597"
#define SCRIPT_VERSION  "1.02"
//+------------------------------------------------------------------+
//|            Estrutura de dados                                    |
//+------------------------------------------------------------------+
struct StuctName
  {
   string            primeiroNome;
   string            segundoNome;
  };
//+------------------------------------------------------------------+
//|            Classe CPessoa contem atributos pessoa                |
//+------------------------------------------------------------------+
class CPessoa
  {
protected:
   StuctName         Name;
public:
                     CPessoa() {};
                    ~CPessoa() {};
   void              setNome(string n);
   string            getNome() {return(Name.primeiroNome+" "+Name.segundoNome);}
private:
   string            getPrimeiroNome(string name);
   string            getSegundoNome(string name);
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CPessoa::setNome(string n)
  {
   Name.primeiroNome=getPrimeiroNome(n);
   Name.segundoNome=getSegundoNome(n);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CPessoa::getPrimeiroNome(string name)
  {
   int pos=::StringFind(name," ");
   if(pos>0)
      ::StringSetCharacter(name,pos,0);
   return(name);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CPessoa::getSegundoNome(string name)
  {
   string vReturn;
   int pos=::StringFind(name," ");
   if(pos>0)
      vReturn=::StringSubstr(name, pos+1);
   else
      vReturn=name;
   return(vReturn);
  }
//+------------------------------------------------------------------+
//
void OnStart()
  {
//---
   string  _name="Jow Pereira";
   CPessoa Name;
   Name.setNome(_name);
   ::Print("Nome completo: "+ Name.getNome());

  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+