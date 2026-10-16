
#property strict
#property version "1.00"
#property description "XAUUSD News EA - starter template"

#include <Trade/Trade.mqh>

CTrade trade;

input double LotSize = 0.01;
input int StopLossPoints = 500;
input int TakeProfitPoints = 1000;
input int MaxSpreadPoints = 50;

int OnInit()
{
   Print("GoldNewsEA initialized. Trading is disabled in this starter.");
   return(INIT_SUCCEEDED);
}

void OnTick()
{
   // Safety starter: no orders are placed.
   // We will add news filters and risk controls after test
ing.
}
