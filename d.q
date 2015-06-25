// default data script

\e 1

sym:50
per:.005

traders:get`:pnl/traders
stocks:1!sym?get`:pnl/stocks
strategies:`statarb`pairs`mergerarb`chart`other`distressed`arbitrage
groups:{z,(1#x)!enlist(neg 1+rand count[y])?y}
traders:ungroup groups[`strategy;strategies]each traders
traders:ungroup groups[`symbol;exec symbol from stocks]each traders
traders:1!`id`unit`trader`strategy`symbol xcols update id:til count traders from traders

trade:{[st;tr;d;t]
 m:floor per*c:count tr;
 i:exec id from tr where i in neg[m]?c;
 s:tr[flip enlist i;`symbol];
 p:(exec symbol!oprice from st)s;
 p+:(m?-1 0 1)*(m?.001)*p;
 q:(m?-1 1.)*100*1+m?10;
 r:([]id:i;symbol:s;date:d;time:t;price:p;qty:q);
 o:0!select symbol:`HEDGE,first date,first time,price:5.0,qty:neg(sum price*qty)%5.0*0.9995 by id from r;
 r,o}

calc:{[stocks;traders;date;time]
 trades,:trade[stocks;traders;date;time];
 t:select trades:count id,qty:sum qty,cprice:last price,vwap:qty wavg price by id,symbol from trades;
 u:(0!traders lj update real:qty*vwap,unreal:qty*cprice from t)lj stocks;
 u:update"j"$qty,pnl:real+unreal from select from u where not null qty;
 pnl::update vwap:0n from u where 0w=abs vwap;
 }

calc[stocks;traders;.z.D].z.T

T:`pnl
Z:`z

G:`strategy`unit`trader`symbol
F:`pnl`real`unreal`qty`volume`trades`vwap

L:0b

A:()!()
A[`N_]:(count;`qty)
A[`qty]:(sum;`qty)
A[`volume]:(sum;(abs;`qty))
A[`trades]:(sum;`trades)
A[`pnl]:(sum;`pnl)
A[`real]:(sum;`real)
A[`unreal]:(sum;`unreal)
A[`oprice]:(avg;`oprice)
A[`cprice]:(avg;`cprice)
A[`vwap]:(avg;`vwap)

S:()!()
S[`pnl]:`D

O.columns.pnl:`USD
O.columns.oprice:`USD
O.columns.cprice:`USD
O.columns.vwap:`USD
O.columns.real:`USD
O.columns.unreal:`USD
O.columns.qty:`QTY
O.columns.volume:`QTY

.z.ts:{calc[stocks;traders;.z.D].z.T;.js.upd`;}
\t 5000

\

/ alternate example

symbol:`msft`amat`csco`intc`yhoo`aapl
trader:`chico`harpo`groucho`zeppo`moe`larry`curly`shemp`abbott`costello
sector:`energy`materials`industrials`financials`healthcare`utilities`infotech
strategy:`statarb`pairs`mergerarb`house`chart`indexarb

n:100000
t:([N:til n]
 symbol:n?symbol;
 sector:n?sector;
 trader:n?trader;
 strategy:n?strategy;
 price:{0.01*"i"$100*x}20+n?400.;
 quantity:-1 1[n?2]*n?100;
 date:2000.01.01+asc n?5;
 time:09:30:00.0+n?06:30)

L:1b
T:`t
Z:`z
G:`trader`sector`strategy`symbol`date`time
F:`N_`price`wprice`quantity
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
