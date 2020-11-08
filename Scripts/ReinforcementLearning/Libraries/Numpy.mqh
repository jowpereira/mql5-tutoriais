//+------------------------------------------------------------------+
//|                                                       Random.mq5 |
//|                                      Copyright 2020,Lethan Corp. |
//|                           https://www.mql5.com/pt/users/14134597 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020,Lethan Corp."
#property link      "https://www.mql5.com/pt/users/14134597"
#property version   "1.00"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
namespace Random
{
double Random(void)
  {
   return((double)rand() / (SHORT_MAX));
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Randint(int max_num)
  {
   int result = 0, low_num = 0, hi_num = 0, min_num=0;

   if(min_num < max_num)
     {
      low_num = min_num;
      hi_num = max_num + 1; // include max_num in output
     }
   else
     {
      low_num = max_num + 1; // include max_num in output
      hi_num = min_num;
     }

   result = (rand() % (hi_num - low_num)) + low_num;
   return(result==max_num?result-1:result);
  }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ArgMax(double &arr[], int size)
  {
   double max_val = arr[0];
   int max_idx    = -1;
   for(int i=0; i<size; i++)
     {
      if(arr[i]>max_val)
        {
         max_val = arr[i];
         max_idx = i;
        }
     }
   return(max_idx==-1?0:max_idx);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Sum(double &arr[])
  {
   double result = .0;
   for(int i=0; i<ArraySize(arr); i++)
     {
      result += arr[i];
     }
   return(result);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CumSum(const double &array[],double &result[])
  {
   int size=ArraySize(array);
   if(size==0)
      return(false);
   if(ArraySize(result)<size)
      if(ArrayResize(result,size)!=size)
         return(false);

   double sum=0.0;
   for(int i=0; i<size; i++)
     {
      if(!MathIsValidNumber(array[i]))
         return(false);
      sum+=array[i];
      result[i]=sum;
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CumSum(double &array[])
  {
   int size=ArraySize(array);
   if(size==0)
      return(false);
   double sum=0.0;
   for(int i=0; i<size; i++)
     {
      if(!MathIsValidNumber(array[i]))
         return(false);
      sum+=array[i];
      array[i]=sum;
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Max(double &array[])
  {
   double temp=DBL_MIN;
   for(int i=0; i<ArraySize(array); i++)
     {
      if(array[i]>temp)
         temp=array[i];
     }
   return(temp);
  }
//+------------------------------------------------------------------+
