//+------------------------------------------------------------------+
//|                                                      CBandit.mqh |
//|                                      Copyright 2020,Lethan Corp. |
//|                           https://www.mql5.com/pt/users/14134597 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020,Lethan Corp."
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.00"

#include "Numpy.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CBandit
 {
private:
  // p: the win rate
  double             m_value_p;
  double             m_estimate;
  double             m_value_N;
public:

                     CBandit(double p);
                    ~CBandit();
  double             Pull(void);
  void               Update(double x);
  double             Estimative(void) { return m_estimate; }
  double             P(void) { return m_value_p; }
 };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBandit::CBandit(double p) : m_value_p(p), m_estimate(0), m_value_N(0)
 {
 }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBandit::~CBandit()
 {
 }
//+------------------------------------------------------------------+
double CBandit::Pull(void)
 {
  return Random::Random() < m_value_p;
 }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CBandit::Update(double x)
 {
  m_value_N +=1;
  m_estimate = ((m_value_N -1)*m_estimate +x) / m_value_N;
 }
//+------------------------------------------------------------------+