/ faster core algorithm

C_:`g_`e_`n_`l_!
root:{[t;g;a]g xcols flip enlist each calc[t;();();a;g],C_(`;0b;0#`;0)}
node:{[t;w;g;a;k]h:k,first c:g except k;![calc[t;w;h!h;a]1_c;();0b;C_(last h;0b;(flip;enlist,h);count h)]}
leaf:{[t;w;g;a;k]virt[(b except c)#a]?[t;w;0b;({x!x}(c:cols t)inter b:key a),C_(`i;1b;(flip;enlist,g,`i);1+count g)]}
virt:{[a;u]![u;();0b;?[0#u;();();(first 0#),/:enlist each a]]}
nodes:{[t;g;a;k;p]key[a]xcols$[g~k;leaf;node][t;find[t;k]p;g;a]k}
steps:{[t;g;a;p]raze nodes[0!t;g;a]'[key q;get q:p group key each p]}
findp:{[t;p]@[count[t]#0b;raze?[t;;();`i]'[{flip(=;key x;flip enlist get x)}each p];:;1b]}
find:{[t;k;p]$[0=count k;();all b:$[not[type p]|30>count p;findp[t]p;(k#t)in p];();enlist b]}
calc:{[t;w;h;a;n]k:$[99h=type h;n,key h;n]_a;r:?[t;w;h;k];v:t[n][;0N];$[98h=type key r;@[0!r;n;:;v];r,n!v]}
used:{exec n from x where min'[v{x\'[til count x]}n?-1_'n]}
parent:{update o_:i in p_ from update p_:n_ ? -1_'n_ from x}
rollup_:{[p;z;t;g;a]parent delete from z where(-1_'exec n_ from z)in get each p}
rollup:{[p;z;t;g;a]parent g xasc$[z~();cols[m]xcols root[t;g]a;cols[m]#z],m:steps[t;g;a]p}
treetable:{[z;t;f;g;a;p;p_]$[z~();rollup used p;count[p:used p]>count p_:used p_;rollup p except p_;rollup_ p_ except p][z;t;g](g,f)#a}

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
 f:n?100;
 g:n?100;
 price:{0.01*"i"$100*x}20+n?400.;
 quantity:-1 1[n?2]*n?100)

T:`t
G:`trader`sector`strategy
F:`price`quantity`N_
A:()!()
A[`N_]:(count;`price)
A[`price]:(sum;`price)
A[`quantity]:(sum;`quantity)
A[`f]:(sum;`f);
A[`g]:(sum;`g);
A[`symbol]:(first;`symbol)
A[`sector]:(first;`sector)
A[`trader]:(first;`trader)
A[`strategy]:(first;`strategy)

P_:P:([n:enlist(0#`)!0#`]v:enlist 1b)
p:treetable[();t;F;G;A;P]()

P:([n:((0#`)!0#`;(1#`trader)!1#`costello)]v:11b)
q:treetable[p;t;F;G;A;P]P_

P_:P
P:update v:10b from P
r:treetable[q;t;F;G;A;P]P_





