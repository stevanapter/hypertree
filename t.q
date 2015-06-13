// treetable

\d .ht

/ construct treetable
cons:{[z;t;p;a;s;g;f;l]sort[treetable[z;get t;f;g;a;l]. p;g;key s]get s}

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
sys:{update o_:i in p_ from update p_:n_ ? -1_'n_ from x}
rollup_:{[p;z;t;g;a]sys delete from z where(-1_'exec n_ from z)in get each p}
rollup:{[p;z;t;g;a]sys g xasc$[z~();cols[m]xcols root[t;g]a;cols[m]#z],m:steps[t;g;a]p}
treetable:{[z;t;f;g;a;l;p;p_]$[z~();rollup used p;count[p:used p]>count p_:used p_;rollup p except p_;rollup_ p_ except p][z;t;g](g,f)#a}

/ control columns
C:`n_`e_`l_`o_`p_`g_

/ initial instruction
I:enlist(0#`)!0#`

/ instruction state
P:(([n:I]v:enlist 1b);([n:()]v:til 0))

/ sort dictionary
S:()!()

/ open/close at a node
row:{[b;p;g;n]`n xasc'(p[0],([n:enlist(count[n]#g)!n,()]v:enlist b);p 0)}

/ rollup: first if 1=count else null
nul:{first$[1=count distinct x;x;0#x]}

/ rollup: first if 1=count else first+
seq:{$[1=count distinct x;first x;`$string[first x],"+"]}

/ type -> rollup
A:" bgxhijefcspmdznuvt"!(nul;any;nul;nul;sum;sum;sum;sum;sum;nul;nul;max;max;max;max;sum;max;max;max)

/ cast <- type
qtype:{C _ exec c!t from meta x}

/ treetable sort
sort:{[t;g;c;o]
 if[0=count g;:t[0],msort[1_t;c]o];
 if[`g_~first -1_c;c:`z_,1_c;t:update z_:?[l_>1;`;g_]from t];
 n:reverse exec i by L_ from s:dsort[t;g;c;o]where L_>0;
 delete z_ from t 0,raze$[1=count n;s[`I_]n;merge[s;g]/[();key n;get n]]}

/ multi-column non-hierarchical sort (pivot table, no grouping)
msort:{[t;c;o]t{x y z x}/[::;(`a`d`A`D!(iasc;idesc;iasc abs@;idesc abs@))o;t c]}

/ column sort
csort:{[c;o]@[flip(@;abs;c;c);i;:;c i:where o in`a`d]}

/ row sort
rsort:{[t;c;o]{x y z x}/[::;reverse o;?[t;();();enlist,reverse get c]]}

/ expression sort
esort:{[c]$[1=count c;first c;(flip;(!;enlist key c;enlist,get c))]}

/ data sort
dsort:{[t;g;c;o]
 a:!/[g,/:(`I_`L_;`i`l_)];c:c!csort[c]o;s:1=count distinct o:(<:;>:)o in`d`D;
 $[s;?[t;();0b;a;0W;(first o;esort c)];?[t;();0b;a]rsort[t;c]o]}

/ sort-level
level:{[s;g;n;i]c:((m:n&count g)#g),`I_;(delete I_ from t)!flip enlist(t:(c#s)i)`I_}

/ merge sort-levels
merge:{[s;g;x;n;i]v:level[s;g;n;i];$[count x;@[v;(keys v)#key x;,;get x];v]}
