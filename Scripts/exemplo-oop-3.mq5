//+------------------------------------------------------------------+
//|                                                        teste.mq5 |
//|                               Copyright 2017, Lethan Consultoria |
//|                          https://www.mql5.com/pt/users/14134597  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Lethan Consultoria"
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
interface IAnimal
   {
     void Som();
     void Mover();
   };
class CGato : public IAnimal
  {
   public:
               CGato() { Print("um novo Gato foi criado!"); }
              ~CGato() { Print("Um Gato foi Morto! xD"); }
    void Som() { Print("Miau!"); }
    void Mover() { Print("Gatos se movem sorrateramente!"); }
  };
class CCachorro : public IAnimal
  {
   public:
               CCachorro() { Print("um novo Cachorro foi criado!"); }
              ~CCachorro() { Print("Um Cachorro foi Morto! xD"); }
    void Som() { Print("AuAu!"); }
    void Mover() { Print("Cachorros correm e chamam a atenção!"); }
  };
//--fim da declaração das classes
void OnStart()
  {
//---
   IAnimal *animais[2];
   animais[0] = new CGato;
   animais[1] = new CCachorro;

   for(int i=0; i<ArraySize(animais);i++)
     {
       animais[i].Som();
       animais[i].Mover(); 
     }

   for(int i=0; i<ArraySize(animais);i++)
     delete animais[i];
  }
//+------------------------------------------------------------------+