#property description "免责声明：EA不能保证客户赢利,市场有风险\r\r"
#property description "计算机及网络也存在间接风险,任何因素导致\r\r"
#property description "的一切可能的风险及损失均由客户自己承担"
int 帐号限制 = 0;//只修改等号右边的数字  标点符号不要动 0=不限制帐号

////////////////////////////////////////////////////////////////////////

//int   绑定真实账号=2090062238;
//datetime 使用期限=D'2037.10.18 09:00:00';
//string bdzhts="没有绑定该账号";
//string sjdqts="使用期限已到  该交钱。结算了";
///////////////////////////////////////////////////////////////////////

extern string 加载货币M5 = "EURUSD";
enum BuyOrSell0 {只做多 = 0,只做空 = 1,多空都做 = 2};
input BuyOrSell0 多空方向 = 2;
extern bool   显示图表信息 = false;//在图表上显示持仓订单信息
extern bool   显示止盈价格 = true;//在订单上显示止盈价格
extern bool   启用区间控制 = false;//价格突破最近多少k线的高低点逆势下单
extern bool   启用顺势加码 = false;
extern bool   启用虚拟下单 = false;//强制隐藏前几单,可以不直接下在平台里,达到隐藏单数而且下单量大于平台最小下单量才会下在平台里
extern int    显示浮亏单数 = 7;//达到设定单数开始记录此轮加码最大浮亏金额并且显示在图表上
extern int    虚拟下单单数 = 10;//第一单开始多少单以内强制隐藏,不直接下在平台里,最大30
extern int    单向最大单数 = 15;//单向加码达到30单不再下同向,包括虚拟单
extern int    顺势最大单数 = 15;
extern double 资金5W单笔最大下单量 = 3;////按比例自动计算,如2w最大3手,2k最大就是0.3手,计算超过此单量按此单量下单
extern string 下单量参数说明0 = "按5000本金下0.001的比例起步,下单量";
extern string 下单量参数说明1 = "小的时候内部自动启用虚拟下单,当计";
extern string 下单量参数说明2 = "算得到的下单量大于平台最小下单量自";
extern string 下单量参数说明3 = "然会下单到平台里,别再问为什么不下单";
extern double 起始下单量 = 0.01;//小资金可设置低于平台最小下单量,比如5000本金下0.001起步,内部自动启用虚拟下单
extern double 翻倍 = 1.3;
extern int    区间K线数 = 8;//计算区间高低点
extern double 逆势回调点数 = 1;//行情向逆势方向波动后再向盈利方向回调多少点下单
extern double 逆势加码间隔 = 8;
extern double 逆势加码间隔递减 = 0;//每加码一单,间隔递减多少点
extern double 逆势加码间隔最小 = 8;
extern double 顺势加码间隔 = 9;
extern double 逆势盈利点数 = 3;//点差2个点左右默认5  超过的话相应降低1到2个点盈利为4或3
extern double 逆势盈利点数递减 = 0.1;//每加码一单,逆势盈利点数递减多少点
extern double 逆势盈利点数最小 = 0.5;
extern double 顺势盈利点数 = 10;
extern double 整体移动止损点数 = 0;
extern double 总亏损平仓 = 0.0;//当前货币当前EA下的单子总亏损金额平仓
extern double 总盈利平仓 = 0.0;
extern int    滑点 = 5;
extern int    定单识别码 = 10533;
extern string 定单注释 = "ok";
extern string TimeC = "====电脑时间参数====";
extern bool   启用时间控制 = false;
extern int    开始小时 = 8;
extern int    开始分钟 = 0;
extern int    结束小时 = 19;
extern int    结束分钟 = 0;
extern string temp1 = "iBands参数,上轨做空,下轨做多";
extern bool   启用iBands控制 = false;
extern int iBands_平均周期 = 20;
extern double iBands_偏差 = 2;
extern int iBands_平移 = 0;
input ENUM_APPLIED_PRICE iBands_应用于 = PRICE_CLOSE;
extern string temp3 = "iRSI参数,上轨做空,下轨做多";
extern bool   启用iRSI控制 = false;
extern int iRSI_平均周期 = 14;
input ENUM_APPLIED_PRICE iRSI_应用于 = PRICE_CLOSE;
extern double iRSI_上线 = 70;
extern double iRSI_下线 = 30;
extern string temp5 = "iStochastic参数,上轨做空,下轨做多";
extern bool   启用iStochastic控制 = false;
extern int iStoc_K周期 = 5;
extern int iStoc_D周期 = 3;
extern int iStoc_慢速 = 3;
input ENUM_MA_METHOD iStoc_移动平均 = MODE_SMA;
input ENUM_STO_PRICE iStoc_价格字段 = STO_LOWHIGH;
extern double iStoc_上线 = 80;
extern double iStoc_下线 = 20;
extern string temp6 = "iCCI参数,上轨做空,下轨做多";
extern bool   启用iCCI控制 = false;
extern int iCCI_平均周期 = 14;
input ENUM_APPLIED_PRICE iCCI_应用于 = PRICE_CLOSE;
extern double iCCI_上线 = 100;//CCI上线
extern double iCCI_下线 = -100;//CCI下线
double diancha=MarketInfo(Symbol(),MODE_SPREAD);
input int Spread=25;//点差限制

int Gi_144 = 0;
int Gi_148 = 0;
double G_order_open_price_150;
double G_order_open_price_158;
double G_order_open_price_151;
double G_order_open_price_159;
double G_order_open_price_152;
double G_order_open_price_153;
double G_order_open_price_160;
double G_order_open_price_161;
double Gd_168;
double Gd_176;
double Gd_184;
double Gd_192;
double Gd_200;
double Gd_208;
double Gd_216;
double Gd_217;
double Gd_218;
double Gd_219;
double G_price_232;
bool Gi_256;
bool TrackZoer0 = true;
bool TrackZoer1 = true;
bool TrackZoerXuNi0;
bool TrackZoerXuNi1;
int G_pos_260;
int G_ticket_264;
int Gi_260;
int Gi_261;
int Gi_268;
int Gi_269;
int Gi_272;
int Time0 = 1;
int Time1 = 1;
int Gi_276 = 1;
int Gi_280;
double Gd_284;
double G_lots_290 = 0.02;
double G_lots_292 = 0.02;
double Gd_300 = 1.5;
int Gi_306 = 7;
int Gi_307 = 4;
int Gi_308 = 20;
double Gi_311 = 7;
double Gi_312 = 7;
double Gi_320 = 7;
double Gi_321 = 7;
double Gi_313 = 7;
bool Gi_315;
double Gi_316 = 2;
double Gi_318 = 2;
double Gi_319 = 2;
double Gi_317 = 10;
double icustom0;
double icustom1;
double icustom2;
double icustom3;
double icustom4;
double NewOpenPrice;
double STOPLEVEL;
double LowPrice = 0;
double HighPrice = 10000;
double Gd_320 = 0.0;
double Gd_328 = 0.0;
int Day0 = -1;
int Gi_336 = 3;
int G_magic_340 = 10533;
string G_comment_300 = "";
string G_comment_344 = "";
string Gsa_720[14];
int OpenMode = 0;
int Gi_265;
double HighPrice0;
double LowPrice0;
bool Use_Time;
bool Use_Zone;
bool Use_Msg;
bool BoolClose;
bool Gi_310;
int StartHour;
int StartMinit;
int EndHour;
int EndMinit;
int l_pod_110;
double LotsAll;
double Lots0;
double LotsC0;
double MinLot;
double MaxLot;
int Bands_period;
int deviation;
int bands_shift;
int Bands_applied_price;
int rsi_period;
int rsi_applied_price;
double RSI_High;
double RSI_Low;
int Kperiod;
int Dperiod;
int kd_slowing;
int kd_method;
int kd_price_field;
double KD_High;
double KD_Low;
int cci_period;
int cci_applied_price;
double CCI_High;
double CCI_Low;
bool booliBands;
bool booliRSI;
bool booliStochastic;
bool booliCCI;
double Gd_720[30];
double Gd_730[30];
double Gd_721[30];
double Gd_731[30];
int Gi_720 = 0;
int Gi_721 = 0;
int Gi_309 = 0;
bool TrackXuNi;
int Gi_322;
int Gi_323 = 0;
int Gi_324 = 0;
double STTPPrice0 = 0;
double STTPPrice1 = 100000;
bool OpenNew = true;
bool OpenAdd0;
bool OpenAdd1;

int OnInit() {
   ArrayInitialize(Gd_720,0);
   ArrayInitialize(Gd_721,0);
   ArrayInitialize(Gd_730,0);
   ArrayInitialize(Gd_731,0);
   TrackXuNi = 启用虚拟下单;
   booliBands = 启用iBands控制;
   booliRSI = 启用iRSI控制;
   booliStochastic = 启用iStochastic控制;
   booliCCI = 启用iCCI控制;
   cci_period = iCCI_平均周期;
   cci_applied_price = iCCI_应用于;
   CCI_High = iCCI_上线;
   CCI_Low = iCCI_下线;
   Kperiod = iStoc_K周期;
   Dperiod = iStoc_D周期;
   kd_slowing = iStoc_慢速;
   kd_method = iStoc_移动平均;
   kd_price_field = iStoc_价格字段;
   KD_High = iStoc_上线;
   KD_Low = iStoc_下线;
   rsi_period = iRSI_平均周期;
   rsi_applied_price = iRSI_应用于;
   RSI_High = iRSI_上线;
   RSI_Low = iRSI_下线;
   Bands_period = iBands_平均周期;
   deviation = iBands_偏差;
   bands_shift = iBands_平移;
   Bands_applied_price = iBands_应用于;
   Gi_269 = 多空方向;
   Use_Zone = 启用区间控制;
   Use_Msg = 显示图表信息;
   Gi_265 = 区间K线数;
   G_lots_292 = 起始下单量;
   Gd_300 = 翻倍;
   Gi_306 = 显示浮亏单数;
   Gi_309 = 虚拟下单单数;
   Gi_308 = 单向最大单数;
   Gi_307 = 顺势最大单数;
   Gi_311 = 逆势回调点数;
   Gi_310 = 启用顺势加码;
   Gi_312 = 逆势加码间隔;
   Gi_320 = 逆势加码间隔递减;
   Gi_321 = 逆势加码间隔最小;
   Gi_313 = 顺势加码间隔;
   Gi_315 = 显示止盈价格;
   Gi_317 = 顺势盈利点数;
   Gi_322 = 整体移动止损点数;
   Gi_316 = 逆势盈利点数;
   Gi_318 = 逆势盈利点数递减;
   Gi_319 = 逆势盈利点数最小;
   Gd_320 = 总亏损平仓;
   Gd_328 = 总盈利平仓;
   Gi_336 = 滑点;
   G_magic_340 = 定单识别码;
   G_comment_344 = 定单注释;
   Use_Time = 启用时间控制;
   StartHour = 开始小时;
   StartMinit = 开始分钟;
   EndHour = 结束小时;
   EndMinit = 结束分钟;
   if(StringFind(G_comment_344,"_",0) >= 0) {
     Alert("禁止注释带_符号");
     ExpertRemove();
     return(0);
     }
   G_comment_344 = G_comment_344 + "_";
   Gd_284 = MathPow(0.1, Digits);
   if (Digits == 5 || Digits == 3) Gi_276 = 10;
   if (StringFind(Symbol(), "XAU", 0) >= 0 || StringFind(Symbol(), "GOLD", 0) >= 0) {
      if (Digits == 2) Gi_276 = 10;
      if (Digits == 3) Gi_276 = 100;
   }
   EventSetMillisecondTimer(300);
   LowPrice = Ask;
   HighPrice = Bid;
   Day0 = Day();
   STOPLEVEL = MarketInfo(Symbol(),MODE_STOPLEVEL);
   MinLot = MarketInfo(Symbol(),MODE_MINLOT);
   MaxLot = MarketInfo(Symbol(),MODE_MAXLOT);
   Gi_280 = MathRound((-MathLog(MarketInfo(Symbol(), MODE_LOTSTEP))) / 2.302585093);
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
   Comment("");
   EventKillTimer();
   ObjectsDeleteAll(0, OBJ_LABEL);
   ObjectsDeleteAll(0,"Button");
   return;
}

double OnTester() {
ButtonCreate("Button3","停止EA","停止EA",80,30,75,25,CORNER_RIGHT_LOWER,clrWhite,clrDarkOrange,clrOrange,false);
if(ObjectGetInteger(0,"Button3",OBJPROP_STATE)==1) {
  ExpertRemove();
  return(0);
  }
ButtonCreate("Button4","暂停下单","正常下单",80,60,75,25,CORNER_RIGHT_LOWER,clrWhite,clrDarkOrange,clrOrange,false);
if(ObjectGetInteger(0,"Button4",OBJPROP_STATE)==1) {
  OpenNew = false;
  }
else OpenNew = true;
ButtonCreate("Button0","全部平仓","正在执行",80,90,75,25,CORNER_RIGHT_LOWER,clrWhite,clrRoyalBlue,clrDodgerBlue,false);
if(ObjectGetInteger(0,"Button0",OBJPROP_STATE)==1) {
  CloseOrders(OP_BUY);
  CloseOrders(OP_SELL);
  ObjectSetInteger(0,"Button0",OBJPROP_STATE,0);
  }
ButtonCreate("Button1","空单平仓","正在执行",80,120,75,25,CORNER_RIGHT_LOWER,clrWhite,clrFireBrick,clrRed,false);
if(ObjectGetInteger(0,"Button1",OBJPROP_STATE)==1) {
  CloseOrders(OP_SELL);
  ObjectSetInteger(0,"Button1",OBJPROP_STATE,0);
  }
ButtonCreate("Button2","多单平仓","正在执行",80,150,75,25,CORNER_RIGHT_LOWER,clrWhite,clrForestGreen,clrLimeGreen,false);
if(ObjectGetInteger(0,"Button2",OBJPROP_STATE)==1) {
  CloseOrders(OP_BUY);
  ObjectSetInteger(0,"Button2",OBJPROP_STATE,0);
  }
ButtonCreate("Button5","手工加空","正在执行",80,180,75,25,CORNER_RIGHT_LOWER,clrWhite,clrFireBrick,clrRed,false);
if(ObjectGetInteger(0,"Button5",OBJPROP_STATE)==1) {
  OpenAdd1 = true;
  ObjectSetInteger(0,"Button5",OBJPROP_STATE,0);
  }
ButtonCreate("Button6","手工加多","正在执行",80,210,75,25,CORNER_RIGHT_LOWER,clrWhite,clrForestGreen,clrLimeGreen,false);
if(ObjectGetInteger(0,"Button6",OBJPROP_STATE)==1) {
  OpenAdd0 = true;
  ObjectSetInteger(0,"Button6",OBJPROP_STATE,0);
  }
  return(0);
}

void OnTimer() {
ButtonCreate("Button3","停止EA","停止EA",80,30,75,25,CORNER_RIGHT_LOWER,clrWhite,clrDarkOrange,clrOrange,false);
if(ObjectGetInteger(0,"Button3",OBJPROP_STATE)==1) {
  ExpertRemove();
  return;
  }
ButtonCreate("Button4","暂停下单","正常下单",80,60,75,25,CORNER_RIGHT_LOWER,clrWhite,clrDarkOrange,clrOrange,false);
if(ObjectGetInteger(0,"Button4",OBJPROP_STATE)==1) {
  OpenNew = false;
  }
else OpenNew = true;
ButtonCreate("Button0","全部平仓","正在执行",80,90,75,25,CORNER_RIGHT_LOWER,clrWhite,clrRoyalBlue,clrDodgerBlue,false);
if(ObjectGetInteger(0,"Button0",OBJPROP_STATE)==1) {
  CloseOrders(OP_BUY);
  CloseOrders(OP_SELL);
  ObjectSetInteger(0,"Button0",OBJPROP_STATE,0);
  }
ButtonCreate("Button1","空单平仓","正在执行",80,120,75,25,CORNER_RIGHT_LOWER,clrWhite,clrFireBrick,clrRed,false);
if(ObjectGetInteger(0,"Button1",OBJPROP_STATE)==1) {
  CloseOrders(OP_SELL);
  ObjectSetInteger(0,"Button1",OBJPROP_STATE,0);
  }
ButtonCreate("Button2","多单平仓","正在执行",80,150,75,25,CORNER_RIGHT_LOWER,clrWhite,clrForestGreen,clrLimeGreen,false);
if(ObjectGetInteger(0,"Button2",OBJPROP_STATE)==1) {
  CloseOrders(OP_BUY);
  ObjectSetInteger(0,"Button2",OBJPROP_STATE,0);
  }
ButtonCreate("Button5","手工加空","正在执行",80,180,75,25,CORNER_RIGHT_LOWER,clrWhite,clrFireBrick,clrRed,false);
if(ObjectGetInteger(0,"Button5",OBJPROP_STATE)==1) {
  OpenAdd1 = true;
  ObjectSetInteger(0,"Button5",OBJPROP_STATE,0);
  }
ButtonCreate("Button6","手工加多","正在执行",80,210,75,25,CORNER_RIGHT_LOWER,clrWhite,clrForestGreen,clrLimeGreen,false);
if(ObjectGetInteger(0,"Button6",OBJPROP_STATE)==1) {
  OpenAdd0 = true;
  ObjectSetInteger(0,"Button6",OBJPROP_STATE,0);
  }
}

void OnTick() {

if(!IsTesting() && MathAbs(Day() - Day0) > 5) {
  ObjectsDeleteAll();
  Day0 = Day();
  }
if(IsTesting()) OnTester();
else OnTimer();
CountOrders();
if(Use_Zone && Gi_268 == 0) {
  LowPrice0 = Low[iLowest(NULL,0,MODE_LOW,Gi_265,2)];
  if(Bid < LowPrice0) {
    if (Ask < LowPrice) LowPrice = Ask;
    }
  else LowPrice = Ask;
 }
else if (Ask < LowPrice) LowPrice = Ask;
if(Use_Zone && Gi_272 == 0) {
  HighPrice0 = High[iHighest(NULL,0,MODE_HIGH,Gi_265,2)];
  if(Bid > HighPrice0) {
    if(Bid > HighPrice) HighPrice = Bid;
    }
  else HighPrice = Bid;
 }
else if (Bid > HighPrice) HighPrice = Bid;
if(Use_Msg) CommentMsg();
if(Gi_268 != Gi_144) {
  Gi_144 = Gi_268;
  if(Gi_315) O_Modify(0);
  else {
    if(Gi_268 > 0) ObjectCreat1("xxxxx1",Gd_168 + MathMax(Gi_319,Gi_316 - Gi_318*(Gi_268 - 1)) * Gi_276 * Gd_284,Blue);
    else if(ObjectFind("xxxxx1") >= 0) ObjectDelete("xxxxx1");
    }
  }
if(Gi_272 != Gi_148) {
  Gi_148 = Gi_272;
  if(Gi_315) O_Modify(1);
  else {
    if (Gi_272 > 0) ObjectCreat1("xxxxx2",Gd_176 - MathMax(Gi_319,Gi_316 - Gi_318*(Gi_272 - 1)) * Gi_276 * Gd_284,Red);
    else if(ObjectFind("xxxxx2") >= 0) ObjectDelete("xxxxx2");
    }
  }
icustom0 = iBands(NULL,0,Bands_period, deviation,bands_shift,Bands_applied_price,1,0);
icustom1 = iBands(NULL,0,Bands_period, deviation,bands_shift,Bands_applied_price,2,0);
icustom2 = iRSI(NULL,0,rsi_period,rsi_applied_price,0);
icustom3 = iStochastic(NULL,0,Kperiod,Dperiod,kd_slowing,kd_method,kd_price_field,0,0);
icustom4 = iCCI(NULL,0,cci_period,cci_applied_price,0);
HideTestIndicators(true);
if(Gi_322 > 0) {
  if (Gi_268 == 0) STTPPrice0 = 0;
  if (Gi_268 > 0 && Bid > Gd_168 + Gi_322 * Gi_276 * Gd_284) {
     STTPPrice0 = MathMax(STTPPrice0,Bid - Gi_322 * Gi_276 * Gd_284);
     O_Modify1(0,Bid - Gi_322 * Gi_276 * Gd_284);
     }
  if (Gi_272 == 0) STTPPrice1 = 100000;
  if (Gi_272 > 0 && Ask < Gd_176 - Gi_322 * Gi_276 * Gd_284) {
     STTPPrice1 = MathMin(STTPPrice1,Ask + Gi_322 * Gi_276 * Gd_284);
     O_Modify1(1,Ask + Gi_322 * Gi_276 * Gd_284);
     }
  if (Gi_268 > 0 && Bid < STTPPrice0) CloseOrders(OP_BUY);
  if (Gi_272 > 0 && Ask > STTPPrice1) CloseOrders(OP_SELL);
  }
BoolClose = false;
if ((Gd_328 > 0.0 && Gd_216 >= Gd_328) || (Gd_320 > 0.0 && Gd_216 <= (-Gd_320))) CloseOrders(OP_BUY);
if ((Gd_328 > 0.0 && Gd_218 >= Gd_328) || (Gd_320 > 0.0 && Gd_218 <= (-Gd_320))) CloseOrders(OP_SELL);
if (Gi_268 > 0 && ((Gi_268 > 1 && G_order_open_price_150 != G_order_open_price_153 && Bid > Gd_168 + MathMax(Gi_319,Gi_316 - Gi_318*(Gi_268 - 1)) * Gi_276 * Gd_284) || (G_order_open_price_150 == G_order_open_price_153 && Bid > Gd_168 + Gi_317 * Gi_276 * Gd_284))) CloseOrders(OP_BUY);
if (Gi_272 > 0 && ((Gi_272 > 1 && G_order_open_price_158 != G_order_open_price_161 && Ask < Gd_176 - MathMax(Gi_319,Gi_316 - Gi_318*(Gi_272 - 1)) * Gi_276 * Gd_284) || (G_order_open_price_158 == G_order_open_price_161 && Ask < Gd_176 - Gi_317 * Gi_276 * Gd_284))) CloseOrders(OP_SELL);
if (BoolClose) return;
G_lots_290 = NormalizeDouble(AccountBalance() / 50000 * 资金5W单笔最大下单量,Gi_280);
if (OpenMode == 0) {
   if (Gi_268 == 0 && (Gi_269 == 0 || Gi_269 == 2) && (OpenAdd0 || (OpenNew && CheckTime() && Ask - LowPrice >= Gi_311 * Gi_276 * Gd_284 && (!booliBands || Bid < icustom1) && (!booliRSI || icustom2 < RSI_Low) && (!booliStochastic || icustom3 < KD_Low) && (!booliCCI || icustom4 < CCI_Low)))) {
      OpenAdd0 = false;
      if((TrackXuNi && Gi_720 < Gi_309) || G_lots_292 < MinLot) {
        Gi_323++;
        ObjectCreat3("xxxxxxx0" + IntegerToString(Gi_720),Ask,clrLime);
        ObjectCreat4("xxxxxxx2" + IntegerToString(Gi_720),"#" + IntegerToString(Gi_720) + " buy " + DoubleToStr(G_lots_292,4),Time[0],2*Ask - Bid,clrWhite);
        ShowArrow0(0,Gi_720);
        Gd_720[Gi_720] = G_lots_292;
        Gd_730[Gi_720] = Ask;
        Gi_720++;
        }
      else {
        LotsAll = NormalizeDouble(G_lots_292, Gi_280);
        if(diancha<Spread){
        G_ticket_264 = OrderSend(Symbol(), OP_BUY, LotsAll, Ask, Gi_336 * Gi_276, 0, 0, G_comment_344 + DoubleToStr(Gi_268,0), G_magic_340, 0, Blue);
        }
        }
      }
   if (Gi_272 == 0 && (Gi_269 == 1 || Gi_269 == 2) && (OpenAdd1 || (OpenNew && CheckTime() && HighPrice - Bid >= Gi_311 * Gi_276 * Gd_284 && (!booliBands || Bid > icustom0) && (!booliRSI || icustom2 > RSI_High) && (!booliStochastic || icustom3 > KD_High) && (!booliCCI || icustom4 > CCI_High)))) {
      OpenAdd1 = false;
      if((TrackXuNi && Gi_721 < Gi_309) || G_lots_292 < MinLot) {
        Gi_324++;
        ObjectCreat3("xxxxxxx1" + IntegerToString(Gi_721),Bid,clrLime);
        ObjectCreat4("xxxxxxx3" + IntegerToString(Gi_721),"#" + IntegerToString(Gi_721) + " sell " + DoubleToStr(G_lots_292,4),Time[0],Ask,clrWhite);
        ShowArrow0(1,Gi_721);
        Gd_721[Gi_721] = G_lots_292;
        Gd_731[Gi_721] = Bid;
        Gi_721++;
        }
      else {
        LotsAll = NormalizeDouble(G_lots_292, Gi_280);
        if(diancha<Spread){
        G_ticket_264 = OrderSend(Symbol(), OP_SELL, LotsAll, Bid, Gi_336 * Gi_276, 0, 0, G_comment_344 + DoubleToStr(Gi_272,0), G_magic_340, 0, Red);
        }
        }
      }
   if (Gi_268 > 0 && (Gi_269 == 0 || Gi_269 == 2) && (OpenAdd0 || (OpenNew && ((Gi_268 < Gi_308 && Ask - LowPrice >= Gi_311 * Gi_276 * Gd_284 && G_order_open_price_152 - Ask >= MathMax(Gi_321,Gi_312 - Gi_320 * (Gi_268 - 1)) * Gi_276 * Gd_284) || (Gi_310 && G_order_open_price_150 == G_order_open_price_153 && Gi_268 < Gi_307 && Ask - G_order_open_price_153 >= Gi_313 * Gi_276 * Gd_284))))) {
      OpenAdd0 = false;
      LotsC0 = 0;
      l_pod_110 = 0;
      LotsAll = MathMin(G_lots_290,NormalizeDouble(G_lots_292 * MathPow(Gd_300, Gi_268), 4));
      if((TrackXuNi && Gi_720 < Gi_309) || LotsAll < MinLot) {
        Gi_323++;
        ObjectCreat3("xxxxxxx0" + IntegerToString(Gi_720),Ask,clrLime);
        ObjectCreat4("xxxxxxx2" + IntegerToString(Gi_720),"#" + IntegerToString(Gi_720) + " buy " + DoubleToStr(LotsAll,4),Time[0],2*Ask - Bid,clrWhite);
        ShowArrow0(0,Gi_720);
        Gd_720[Gi_720] = LotsAll;
        Gd_730[Gi_720] = Ask;
        Gi_720++;
        }
      else {
      LotsAll = NormalizeDouble(LotsAll, Gi_280);
      while(LotsC0 < LotsAll && l_pod_110 < 10) {
         RefreshRates();
         Lots0 = MathMin(LotsAll - LotsC0,MaxLot);
         if(diancha<Spread){
         G_ticket_264 = OrderSend(Symbol(), OP_BUY, Lots0, Ask, Gi_336 * Gi_276, 0, 0, G_comment_344 + DoubleToStr(Gi_268,0), G_magic_340, 0, Blue);
         }
         if(G_ticket_264 >= 0) {
           LowPrice = Ask;
           LotsC0 += Lots0;
           }
         else {
           l_pod_110++;
           Print("下单错误 = ",GetLastError());
           }
        }
      }
   }
   if (Gi_272 > 0 && (Gi_269 == 1 || Gi_269 == 2) && (OpenAdd1 || (OpenNew && ((Gi_272 < Gi_308 && HighPrice - Bid >= Gi_311 * Gi_276 * Gd_284 && Bid - G_order_open_price_160 >= MathMax(Gi_321,Gi_312 - Gi_320 * (Gi_272 - 1)) * Gi_276 * Gd_284) || (Gi_310 && G_order_open_price_158 == G_order_open_price_161 && Gi_272 < Gi_307 && G_order_open_price_161 - Bid >= Gi_313 * Gi_276 * Gd_284))))) {
      OpenAdd1 = false;
      LotsC0 = 0;
      l_pod_110 = 0;
      LotsAll = MathMin(G_lots_290,NormalizeDouble(G_lots_292 * MathPow(Gd_300, Gi_272), 4));
      if((TrackXuNi && Gi_721 < Gi_309) || LotsAll < MinLot) {
        Gi_324++;
        ObjectCreat3("xxxxxxx1" + IntegerToString(Gi_721),Bid,clrLime);
        ObjectCreat4("xxxxxxx3" + IntegerToString(Gi_721),"#" + IntegerToString(Gi_721) + " sell " + DoubleToStr(LotsAll,4),Time[0],Ask,clrWhite);
        ShowArrow0(1,Gi_721);
        Gd_721[Gi_721] = LotsAll;
        Gd_731[Gi_721] = Bid;
        Gi_721++;
        }
      else {
      LotsAll = NormalizeDouble(LotsAll, Gi_280);
      while(LotsC0 < LotsAll && l_pod_110 < 10) {
         RefreshRates();
         Lots0 = MathMin(LotsAll - LotsC0,MaxLot);
         if(diancha<Spread){
         G_ticket_264 = OrderSend(Symbol(), OP_SELL, Lots0, Bid, Gi_336 * Gi_276, 0, 0, G_comment_344 + DoubleToStr(Gi_272,0), G_magic_340, 0, Red);
         }
         if(G_ticket_264 >= 0) {
           HighPrice = Bid;
           LotsC0 += Lots0;
           }
         else {
           l_pod_110++;
           Print("下单错误 = ",GetLastError());
           }
         }
        }
     }
  }
return;
}

void O_Modify(int Ai_0) {
   if (Ai_0 == 0) {
      if(Gi_268 > 1 && G_order_open_price_150 == G_order_open_price_152) G_price_232 = Gd_168 + MathMax(Gi_319,Gi_316 - Gi_318*(Gi_268 - 1)) * Gi_276 * Gd_284;
      if(G_order_open_price_150 == G_order_open_price_153) G_price_232 = Gd_168 + Gi_317 * Gi_276 * Gd_284;
      if (G_price_232 - Bid <= STOPLEVEL * Point) return;
      for (G_pos_260 = OrdersTotal() - 1; G_pos_260 >= 0; G_pos_260--) {
         if (OrderSelect(G_pos_260, SELECT_BY_POS, MODE_TRADES)) {
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_340)
               if (OrderType() == OP_BUY) Gi_256 = OrderModify(OrderTicket(), OrderOpenPrice(), 0, G_price_232, 0, Blue);
         }
      }
   }
   if (Ai_0 == 1) {
      if(Gi_272 > 1 && G_order_open_price_158 == G_order_open_price_160) G_price_232 = Gd_176 - MathMax(Gi_319,Gi_316 - Gi_318*(Gi_272 - 1)) * Gi_276 * Gd_284;
      if(G_order_open_price_158 == G_order_open_price_161) G_price_232 = Gd_176 - Gi_317 * Gi_276 * Gd_284;
      if (Ask - G_price_232 <= STOPLEVEL * Point) return;
      for (G_pos_260 = OrdersTotal() - 1; G_pos_260 >= 0; G_pos_260--) {
         if (OrderSelect(G_pos_260, SELECT_BY_POS, MODE_TRADES)) {
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_340)
               if (OrderType() == OP_SELL) Gi_256 = OrderModify(OrderTicket(), OrderOpenPrice(), 0, G_price_232, 0, Red);
         }
      }
   }
}

void O_Modify1(int Ai_0,double Ad_0) {
   if (Ai_0 == 0) {
      for (G_pos_260 = OrdersTotal() - 1; G_pos_260 >= 0; G_pos_260--) {
         if (OrderSelect(G_pos_260, SELECT_BY_POS, MODE_TRADES)) {
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_340)
               if (OrderType() == OP_BUY && OrderStopLoss() < Ad_0) Gi_256 = OrderModify(OrderTicket(), OrderOpenPrice(), Ad_0, OrderTakeProfit(), 0, Blue);
         }
      }
   }
   if (Ai_0 == 1) {
      for (G_pos_260 = OrdersTotal() - 1; G_pos_260 >= 0; G_pos_260--) {
         if (OrderSelect(G_pos_260, SELECT_BY_POS, MODE_TRADES)) {
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_340)
               if (OrderType() == OP_SELL && (OrderStopLoss() == 0 || OrderStopLoss() > Ad_0)) Gi_256 = OrderModify(OrderTicket(), OrderOpenPrice(), Ad_0, OrderTakeProfit(), 0, Blue);
         }
      }
   }
}

bool CheckTime() {
   if(!Use_Time) return(1);
   int Time10 = TimeLocal();
   int StartTime1 = StrToTime(TimeToStr(Time10,TIME_DATE) + " " + DoubleToStr(StartHour,0) + ":" + DoubleToStr(StartMinit,0));
   int EndTime1 = StrToTime(TimeToStr(Time10,TIME_DATE) + " " +DoubleToStr(EndHour,0) + ":" + DoubleToStr(EndMinit,0));
   if(StartTime1 < EndTime1 && Time10 > StartTime1 && Time10 < EndTime1) return(1);
   if(StartTime1 > EndTime1) {
     if(Time10 > StartTime1 || Time10 < EndTime1) return(1);
   }
   return(0);
}

void ShowArrow0(int A_cmd_0,int A_count_0) {
   string name;
   string Type;
   int Gi_325;
   int Arrow;
   color Color;
   double OpenPrice;
   double OrderLots0 = MathMin(G_lots_290,NormalizeDouble(G_lots_292 * MathPow(Gd_300, A_count_0), 4));
   if(A_cmd_0 == 0) {
     Arrow = 1;
     Color = Blue;
     Type = "buy";
     OpenPrice = Ask;
     Gi_325 = Gi_323;
     }
   if(A_cmd_0 == 1) {
     Arrow = 2;
     Color = Red;
     Type = "sell";
     OpenPrice = Bid;
     Gi_325 = Gi_324;
     }
   name = "#" + Gi_325 + " " + Type + " " + DoubleToStr(OrderLots0, 4) + " " + Symbol() + " at " + DoubleToStr(OpenPrice, Digits);
   ObjectCreate(name, OBJ_ARROW, 0, TimeCurrent(), OpenPrice);
   ObjectSet(name, OBJPROP_ARROWCODE, Arrow);
   ObjectSet(name, OBJPROP_COLOR, Color);
}

void ShowArrow1(int A_cmd_0,int A_count_0,int OpenTime) {
   string name;
   string Type;
   int Arrow;
   int Gi_325;
   color Color;
   double OpenPrice;
   double ClosePrice;
   double OrderLots0 = MathMin(G_lots_290,NormalizeDouble(G_lots_292 * MathPow(Gd_300, A_count_0), 4));
   if(A_cmd_0 == 0) {
     Arrow = 1;
     Color = Blue;
     Type = "buy";
     OpenPrice = Gd_730[A_count_0];
     ClosePrice = Bid;
     Gi_325 = Gi_323;
     }
   if(A_cmd_0 == 1) {
     Arrow = 2;
     Color = Red;
     Type = "sell";
     OpenPrice = Gd_731[A_count_0];
     ClosePrice = Ask;
     Gi_325 = Gi_324;
     }
   name = "#" + IntegerToString(Gi_325 - A_count_0) + " " + Type + " " + DoubleToStr(OrderLots0, 4) + " " + Symbol() + " at " + DoubleToStr(OpenPrice, Digits) + " close at " + DoubleToStr(ClosePrice,Digits);
   ObjectCreate(name, OBJ_ARROW, 0, TimeCurrent(), ClosePrice);
   ObjectSet(name, OBJPROP_ARROWCODE, 3);
   ObjectSet(name, OBJPROP_COLOR, Goldenrod);
   name = "#" + IntegerToString(Gi_325 - A_count_0) + " " + Type + " "  + DoubleToStr(OpenPrice,Digits) + " -> " + DoubleToStr(ClosePrice,Digits) + " Lots = " + DoubleToStr(OrderLots0, 4);
   ObjectCreate(name, OBJ_TREND, 0, OpenTime, OpenPrice, TimeCurrent(), ClosePrice);
   ObjectSet(name, OBJPROP_STYLE, STYLE_DOT);
   ObjectSet(name, OBJPROP_WIDTH, 1);
   ObjectSet(name, OBJPROP_RAY, false);
   ObjectSet(name, OBJPROP_COLOR, Color);
}

void CloseOrders(int A_cmd_0) {
   string NameObject;
   if(A_cmd_0 == 0) {
      Gi_720 = 0;
      for(int i = 0;i < ObjectsTotal();i++) {
         NameObject = ObjectName(i);
         if(StringFind(NameObject,"xxxxxxx0",0) >= 0) {
           ShowArrow1(0,StringSubstr(NameObject,8,StringLen(NameObject) - 8),ObjectGet(NameObject,OBJPROP_TIME1));
           }
         }
      ArrayInitialize(Gd_720,0);
      ArrayInitialize(Gd_730,0);
      ObjectsDeleteAll(0,OBJ_HLINE);
      ObjectsDeleteAll(0,OBJ_TEXT);
     }
   if(A_cmd_0 == 1) {
      Gi_721 = 0;
      for(i = 0;i < ObjectsTotal();i++) {
         NameObject = ObjectName(i);
         if(StringFind(NameObject,"xxxxxxx1",0) >= 0) {
           ShowArrow1(1,StringSubstr(NameObject,8,StringLen(NameObject) - 8),ObjectGet(NameObject,OBJPROP_TIME1));
           }
         }
      ArrayInitialize(Gd_721,0);
      ArrayInitialize(Gd_731,0);
      ObjectsDeleteAll(0,OBJ_HLINE);
      ObjectsDeleteAll(0,OBJ_TEXT);
     }
   BoolClose = true;
   for (int pos_4 = OrdersTotal() - 1; pos_4 >= 0; pos_4--) {
      if (OrderSelect(pos_4, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_340)
            if (OrderType() == A_cmd_0) Gi_256 = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), Gi_336 * Gi_276, Yellow);
      }
   }
}

double CountL(int A_cmd_0) {
   double awefwpijo = 0;
   if(A_cmd_0 == 0) {
     for(int i = 0;i <= 30;i++) {
        if(Gd_720[i] == 0) break;
        awefwpijo += Gd_720[i];
        }
     }
   if(A_cmd_0 == 1) {
     for(i = 0;i <= 30;i++) {
        if(Gd_721[i] == 0) break;
        awefwpijo += Gd_721[i];
        }
     }
  return(awefwpijo);
}

double CountLP(int A_cmd_0) {
   double awefwpijo = 0;
   if(A_cmd_0 == 0) {
     for(int i = 0;i <= 30;i++) {
        if(Gd_720[i] == 0) break;
        awefwpijo += Gd_720[i] * Gd_730[i];
        }
     }
   if(A_cmd_0 == 1) {
     for(i = 0;i <= 30;i++) {
        if(Gd_721[i] == 0) break;
        awefwpijo += Gd_721[i] * Gd_731[i];
        }
     }
  return(awefwpijo);
}

void CountOrders() {
   Gi_268 = Gi_720;
   Gi_272 = Gi_721;
   Gd_184 = CountL(0);
   Gd_192 = CountL(1);
   Gd_200 = CountLP(0);
   Gd_208 = CountLP(1);
   Gi_260 = 0;
   Gi_261 = 0;
   Gd_216 = 0;
   Gd_218 = 0;
   if(Gd_184 > 0) Gd_216 = Gd_184 * (Bid - (Gd_200 / Gd_184)) * MarketInfo(Symbol(),MODE_TICKVALUE);
   if(Gd_192 > 0) Gd_218 = Gd_192 * ((Gd_208 / Gd_192) - Ask) * MarketInfo(Symbol(),MODE_TICKVALUE);
   if(Gi_720 > 0) G_order_open_price_150 = Gd_730[Gi_720-1];
   G_order_open_price_151 = 0;
   if(Gi_721 > 0) G_order_open_price_158 = Gd_731[Gi_721-1];
   G_order_open_price_159 = 0;
   G_order_open_price_152 = 10000;
   G_order_open_price_153 = 0;
   if(Gd_184 > 0) {
     G_order_open_price_152 = MathMin(Gd_730[0],Gd_730[Gi_720-1]);
     G_order_open_price_153 = MathMax(Gd_730[0],Gd_730[Gi_720-1]);
     }
   G_order_open_price_160 = 0;
   G_order_open_price_161 = 10000;
   if(Gd_192 > 0) {
      G_order_open_price_160 = MathMax(Gd_731[0],Gd_731[Gi_721-1]);
      G_order_open_price_161 = MathMin(Gd_731[0],Gd_731[Gi_721-1]);
     }
   Gd_168 = 0;
   Gd_176 = 0;
   for (G_pos_260 = 0; G_pos_260 < OrdersTotal(); G_pos_260++) {
      if (OrderSelect(G_pos_260, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderSymbol() == Symbol() && OrderMagicNumber() == G_magic_340) {
            G_comment_300 = OrderComment();
            if(StringFind(G_comment_300,"_",0) < 0) {
              Alert("定单注释异常 = ",G_comment_300);
              ExpertRemove();
              break;
              }
            if (OrderType() == OP_BUY) {
               Gi_268 = StrToInteger(StringSubstr(G_comment_300,StringFind(G_comment_300,"_",0)+1,StringLen(G_comment_300)-StringFind(G_comment_300,"_",0)-1))+1;
               Gi_260++;
               Gd_184 += OrderLots();
               Gd_200 += OrderOpenPrice() * OrderLots();
               Gd_216 += OrderProfit() + OrderSwap() + OrderCommission();
               G_order_open_price_150 = OrderOpenPrice();
               G_order_open_price_151 = OrderClosePrice();
               G_order_open_price_152 = MathMin(G_order_open_price_152,OrderOpenPrice());
               G_order_open_price_153 = MathMax(G_order_open_price_153,OrderOpenPrice());
            }
            if (OrderType() == OP_SELL) {
               Gi_272 = StrToInteger(StringSubstr(G_comment_300,StringFind(G_comment_300,"_",0)+1,StringLen(G_comment_300)-StringFind(G_comment_300,"_",0)-1))+1;
               Gi_261++;
               Gd_192 += OrderLots();
               Gd_208 += OrderOpenPrice() * OrderLots();
               Gd_218 += OrderProfit() + OrderSwap() + OrderCommission();
               G_order_open_price_158 = OrderOpenPrice();
               G_order_open_price_159 = OrderClosePrice();
               G_order_open_price_160 = MathMax(G_order_open_price_160,OrderOpenPrice());
               G_order_open_price_161 = MathMin(G_order_open_price_161,OrderOpenPrice());
            }
         }
      }
   }
   if (Gi_268 == 0 && TrackZoer0) {
      TrackZoer0 = false;
      LowPrice = Ask;
      if(Gd_217 < -1) {
        ObjectCreat2("xxxxx" + DoubleToStr(TimeCurrent(),0), DoubleToStr(Gd_217,0), High[0] + 50*Point, Yellow);
        Gd_217 = 0;
        }
      }
   if (Gi_272 == 0 && TrackZoer1) {
      TrackZoer1 = false;
      HighPrice = Bid;
      if(Gd_219 < -1) {
        ObjectCreat2("xxxxx" + DoubleToStr(TimeCurrent(),0), DoubleToStr(Gd_219,0), Low[0] - 50*Point, Yellow);
        Gd_219 = 0;
        }
      }
   if (Gi_260 > 0) TrackZoerXuNi0 = true;
   if (Gi_261 > 0) TrackZoerXuNi1 = true;
   if (Gi_260 == 0 && TrackZoerXuNi0) {
      CloseOrders(OP_BUY);
      TrackZoerXuNi0 = false;
      }
   if (Gi_261 == 0 && TrackZoerXuNi1) {
      CloseOrders(OP_SELL);
      TrackZoerXuNi1 = false;
      }
   if (Gi_268 > 0) TrackZoer0 = true;
   if (Gi_272 > 0) TrackZoer1 = true;
   if (Gi_268 >= Gi_306 && Gd_216 < Gd_217) Gd_217 = Gd_216;
   if (Gi_272 >= Gi_306 && Gd_218 < Gd_219) Gd_219 = Gd_218;
   if (Gd_184 > 0.0) Gd_168 = NormalizeDouble(Gd_200 / Gd_184, Digits);
   if (Gd_192 > 0.0) Gd_176 = NormalizeDouble(Gd_208 / Gd_192, Digits);
}

void CommentMsg() {

   Gsa_720[1] = "强平比例:" + DoubleToStr(AccountStopoutLevel(), 0) + "%";
   Gsa_720[2] = "--------------";
   Gsa_720[3] = "多单单数:" + Gi_268;
   Gsa_720[4] = "多单手数:" + DoubleToStr(Gd_184, 2);
   Gsa_720[5] = "多单盈亏:" + DoubleToStr(Gd_216, 2);
   Gsa_720[6] = "--------------";
   Gsa_720[7] = "空单单数:" + Gi_272;
   Gsa_720[8] = "空单手数:" + DoubleToStr(Gd_192, 2);
   Gsa_720[9] = "空单盈亏:" + DoubleToStr(Gd_218, 2);
   Gsa_720[10] = "--------------";
   Gsa_720[11] = "净下单量:" + DoubleToStr(Gd_184 - Gd_192, 2);
   Gsa_720[12] = "浮动盈亏:" + DoubleToStr(Gd_216 + Gd_218, 2);
   Gsa_720[13] = "--------------";
   for (int index_0 = 0; index_0 < 14; index_0++) ObjectCreat0("xxxxxx" + index_0, Gsa_720[index_0], 10, 15 + 19 * index_0, Yellow);
}

void ObjectCreat0(string A_name_0, string A_text_8, double A_x_16, double A_y_24, color A_color_32) {
   if (ObjectFind(A_name_0) >= 0) {
      ObjectSetText(A_name_0, A_text_8, 14, "微软雅黑", A_color_32);
      return;
   }
   ObjectCreate(A_name_0, OBJ_LABEL, 0, 0, 0);
   ObjectSet(A_name_0, OBJPROP_XDISTANCE, A_x_16);
   ObjectSet(A_name_0, OBJPROP_YDISTANCE, A_y_24);
   ObjectSet(A_name_0, OBJPROP_COLOR, A_color_32);
   ObjectSetText(A_name_0, A_text_8, 14, "微软雅黑", A_color_32);
}

void ObjectCreat1(string Name,double Price0,color COLOR) {
if(ObjectFind(Name) >= 0) ObjectSet(Name, OBJPROP_PRICE1, Price0);
else {
  ObjectCreate(Name, OBJ_HLINE, 0, 0, Price0);
  ObjectSet(Name, OBJPROP_WIDTH, 1);
  ObjectSet(Name, OBJPROP_COLOR, COLOR);
  }
}

void ObjectCreat2(string A_name_0, string A_text_8, double A_x_16, color A_color_32) {
   if (ObjectFind(A_name_0) >= 0) {
      ObjectSetText(A_name_0, A_text_8, 25, "微软雅黑", A_color_32);
      return;
   }
   ObjectCreate(A_name_0, OBJ_TEXT, 0, Time[1], A_x_16);
   ObjectSet(A_name_0, OBJPROP_COLOR, A_color_32);
   ObjectSetText(A_name_0, A_text_8, 25, "微软雅黑", A_color_32);
}

void ObjectCreat3(string Name,double OBJPrice1,color COLOR) {
if(ObjectFind(Name) >= 0) ObjectSet(Name, OBJPROP_PRICE1, OBJPrice1);
else {
  ObjectCreate(Name, OBJ_HLINE, 0, TimeCurrent(), OBJPrice1);
  ObjectSet(Name, OBJPROP_WIDTH, 1);
  ObjectSet(Name, OBJPROP_STYLE, STYLE_DASHDOT);
  ObjectSet(Name, OBJPROP_COLOR, COLOR);
  }
}

void ObjectCreat4(string Name,string Text,int OBJTime1,double OBJPrice1,color COLOR) {
if(ObjectFind(Name) >= 0) ObjectSetText(Name, Text, 9, "汉仪旗黑-55S", COLOR);
else {
  ObjectCreate(Name, OBJ_TEXT, 0, OBJTime1, OBJPrice1);
  ObjectSet(Name, OBJPROP_COLOR, COLOR);
  ObjectSetText(Name, Text, 9, "汉仪旗黑-55S", COLOR);
  }
}

void ButtonCreate(string Name,string txt1,string txt2,int XX,int YX,int XL,int YL,int WZ,color clr,color back_clr,color border_clr,bool ZHClr) {
if(ObjectFind(0,Name)==-1) {
  ObjectCreate(0,Name,OBJ_BUTTON,0,0,0);
  ObjectSetInteger(0,Name,OBJPROP_XDISTANCE,XX);
  ObjectSetInteger(0,Name,OBJPROP_YDISTANCE,YX);
  ObjectSetInteger(0,Name,OBJPROP_XSIZE,XL);
  ObjectSetInteger(0,Name,OBJPROP_YSIZE,YL);
  ObjectSetInteger(0,Name,OBJPROP_CORNER,WZ);
  ObjectSetString(0,Name,OBJPROP_FONT,"微软雅黑");
  ObjectSetInteger(0,Name,OBJPROP_FONTSIZE,13);
  ObjectSetInteger(0,Name,OBJPROP_BORDER_COLOR,border_clr);
  }
if(ObjectGetInteger(0,Name,OBJPROP_STATE)==1) {
  if(ZHClr) {
    ObjectSetInteger(0,Name,OBJPROP_COLOR,back_clr);
    ObjectSetInteger(0,Name,OBJPROP_BGCOLOR,clr);
    }
  ObjectSetString(0,Name,OBJPROP_TEXT,txt2);
  }
else {
  ObjectSetInteger(0,Name,OBJPROP_COLOR,clr);
  ObjectSetInteger(0,Name,OBJPROP_BGCOLOR,back_clr);
  ObjectSetString(0,Name,OBJPROP_TEXT,txt1);
  }
}