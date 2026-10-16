
#property strict
#property version "1.10"
#property description "XAUUSD News Breakout Signal Only"

input int RangeMinutes = 5;
input int BreakoutBufferPoints = 50;

// Set this to the news time in broker server time.
input datetime NewsTime = D'2026.10.16 12:00';

datetime rangeStart;
datetime rangeEnd;
double rangeHigh = 0.0;
double rangeLow = 0.0;
bool rangeReady = false;
bool signalReported = false;

int OnInit()
{
   rangeStart = NewsTime - RangeMinutes * 60;
   rangeEnd = NewsTime;

   Print("Signal-only EA initialized. No orders will be placed.");
   Print("Confirm NewsTime matches broker server time.");
   return INIT_SUCCEEDED;
}

void OnTick()
{
   if(signalReported)
      return;

   datetime now = TimeCurrent();

   if(now < rangeStart)
      return;

   if(now <= rangeEnd)
   {
      double high = iHigh(_Symbol, PERIOD_M1, 0);
      double low  = iLow(_Symbol, PERIOD_M1, 0);

      if(high > 0 && low > 0)
      {
         if(rangeHigh == 0 || high > rangeHigh)
            rangeHigh = high;

         if(rangeLow == 0 || low < rangeLow)
            rangeLow = low;
      }
      return;
   }

   if(!rangeReady)
   {
      if(rangeHigh <= 0 || rangeLow <= 0)
      {
         Print("No valid range. Check M1 price history.");
         signalReported = true;
         return;
      }

      rangeReady = true;
      Print("Range high: ", rangeHigh,
            " Range low: ", rangeLow);
   }

   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double buffer = BreakoutBufferPoints * _Point;

   if(ask > rangeHigh + buffer)
   {
      Print("BUY BREAKOUT SIGNAL ONLY. No order placed.");
      signalReported = true;
   }
   else if(bid < rangeLow - buffer)
   {
      Print("SELL BREAKOUT SIGNAL ONLY. No order placed.");
      signalReported = true;
   }
}
