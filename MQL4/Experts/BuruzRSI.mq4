//+------------------------------------------------------------------+
//|                                      Relative Strength Index.mq4 |
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                          clintontbruce@gmail.com |
//+------------------------------------------------------------------+
#define DEBUG

#include "..\\Include\\trade.mqh"

// Input Parameters
input int RSI_Period = 14;
input int Overbought_Level = 70;
input int Oversold_Level = 30;
input double LotSize = 0.05;
input int StopLoss_Points = 200;
input int TakeProfit_Points = 100;

CTrade trade;

// Global Variables
double lastRSI;

int OnInit() {
   lastRSI = iRSI(Symbol(), 0, RSI_Period, PRICE_CLOSE, 0);
   return(INIT_SUCCEEDED);
}

void OnTick() {
   if(trade.TradesTotal() > 0) return;
   // if(OrdersTotal()>0) return; // do not trade if there is an already opened order
   double currentRSI = iRSI(Symbol(), 0, RSI_Period, PRICE_CLOSE, 0);
   
   // Check for RSI cross over oversold or overbought levels
   if (lastRSI < Oversold_Level && currentRSI >= Oversold_Level) {
      // Buy order
      // OrderSend(Symbol(), OP_BUY, LotSize, Ask, 3, Ask-StopLoss_Points*_Point, Ask+TakeProfit_Points*_Point, "RSI Cross Over Buy", 0, clrRed);
      trade.Buy(Symbol(), LotSize, StopLoss_Points, TakeProfit_Points, "RSI Cross Over Buy");
   } else if (lastRSI > Overbought_Level && currentRSI <= Overbought_Level) {
      // Sell order
      // OrderSend(Symbol(), OP_SELL, LotSize, Bid, 3, Bid+StopLoss_Points*_Point, Bid-TakeProfit_Points*_Point, "RSI Cross Over Sell", 0, clrBlue);
      trade.Sell(Symbol(), LotSize, StopLoss_Points, TakeProfit_Points, "RSI Cross Over Sell");
   }
   
   lastRSI = currentRSI;
}


#undef DEBUG
