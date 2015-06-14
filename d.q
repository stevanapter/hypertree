// default data script (-ds)

\e 1

/ example 0

symbol:`msft`amat`csco`intc`yhoo`aapl
trader:`chico`harpo`groucho`zeppo`moe`larry`curly`shemp`abbott`costello
sector:`energy`materials`industrials`financials`healthcare`utilities`infotech
strategy:`statarb`pairs`mergerarb`house`chart`indexarb

n:1000
t:([]
 symbol:n?symbol;
 sector:n?sector;
 trader:n?trader;
 strategy:n?strategy;
 price:{0.01*"i"$100*x}20+n?400.;
 quantity:-1 1[n?2]*n?100;
 date:2000.01.01+asc n?5;
 time:09:30:00.0+n?06:30)

T:`t
Z:`z
G:`trader`sector`strategy`symbol`date
F:`N_`price`wprice`quantity`time
A:()!()
A[`N_]:(count;`price)
A[`wprice]:(wavg;`quantity;`price)

O.columns.price:`USD
O.columns.pnl:`USD

/ update
.z.ts:{
 t[::;`quantity]+:-1 1[n?2]*n?100;t[::;`price]+:-.5+n?1.;
 t[::;`strategy]:n?strategy;
 t::update pnl:quantity*price-prev price by symbol from t;
 .js.upd`;
 }

\

/ restore state
k)P:((+(,`n)!,`s#((`symbol$())!();(,`trader)!,`chico;`trader`sector!`chico`energy;`trader`sector`strategy!`chico`energy`house;(,`trader)!,`larry;`trader`sector!`larry`energy;`trader`sector`strategy!`larry`energy`house))!+(,`v)!,1111111b;(+(,`n)!,())!+(,`v)!,`long$())

k)P:((+(,`n)!,((`symbol$())!();(,`trader)!,`abbott;(,`trader)!,`curly;(,`trader)!,`shemp;(,`trader)!,`larry;(,`trader)!,`moe;(,`trader)!,`chico;(,`trader)!,`zeppo;(,`trader)!,`harpo;(,`trader)!,`groucho;(,`trader)!,`costello))!+(,`v)!,11111111111b;(+(,`n)!,())!+(,`v)!,`long$())

\

/ example 1

t:get`:eg/itunes

T:`t
G:`Genre`Album`Artist`Name
F:`Size`Total_Time`Disc_Number`Disc_Count`Track_Number`Track_Count`Year`Bit_Rate`Sample_Rate`Date_Added`Date_Modified

Max:{max 0^x}
A[`Year]:(Max;`Year)
A[`Disc_Number]:(Max;`Disc_Number)
A[`Bit_Rate]:(Max;`Bit_Rate)
A[`Sample_Rate]:(Max;`Sample_Rate)

\

/ example 2

traders:(`$read0`:eg/yahoo/traders.txt)except`
stocks:`sym`name`lastsale`marketcap`ipoyear`sector`industry xcol("SSFSSSS";1#",")0:`:eg/yahoo/stocks.csv

yahoo:{[offset;stocks]
 tbl:();i:0;zs:(ze:.z.d)-offset;
 parms:"&d=",(string -1+`mm$ze),"&e=",(string`dd$ze),"&f=",(string`year$ze),"&g=d&a=",(string -1+`mm$zs),"&b=",(string`dd$zs),"&c=",(string`year$zs),"&ignore=.csv";
 do[count stocks:distinct stocks,();
  txt:`:http://ichart.finance.yahoo.com "GET /table.csv?s=",(string stock:stocks[i]),parms," http/1.0\r\nhost:ichart.finance.yahoo.com\r\n\r\n";
  if[0=count ss[txt;"404 Not Found"];tbl,:update Sym:stock from select from ("DEEEEI ";1#",")0:(txt ss"Date,Open")_ txt];
  i+:1];
 (lower cols tbl)xcol`Date`Sym xasc select from tbl where not null Volume}  

t:update N:1 from yahoo[30]exec sym from stocks where i in neg[rand 200]?count sym
t:t lj 1!stocks
t:raze{update trader:count[sym]#x from select from t where i in neg[rand count sym]?count sym}each traders
t:update mpl:sum pnl by"m"$date,sym from update pnl:0^volume*close-prev close by sym from t
t:update row:i from t

/ connect to hypertable:
T:`t
G:`sym`date`trader
F:`N`row`sector`industry`open`high`low`close`volume`pnl`mpl`lastsale`marketcap`ipoyear
A[f]:avg,/:f:`open`high`low`close`pnl`mpl
A[`volume]:(max;`volume)
A[`row]:(last;`row)
O.price:`USD
O.quantity:`TEST
L:0b

/ update
.z.ts:{
 n:count t;
 t[::;`volume]+:-1 1[n?2]*n?100;
 t::update mpl:sum pnl by"m"$date,sym from update pnl:0^volume*close-prev close by sym,trader from t;
 .js.upd`;
 }

\

/ example 4 - batting averages

t:select from get`:eg/baseball where year>1990
G:`year`league`player
F:`atbats`hits`bavg
A[`bavg]:parse"floor 1000*sum[hits]%sum atbats"
L:0b

\


