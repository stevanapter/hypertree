// hypertree

\d .ht

/ construct treetable
cons:{[z;t;l;p;a;g;f;w]mode[w;z;t;l;g;rollups[t;a;g]f]. used each p}
mode:{[w;z;t;l;g;a;p;q]$[count w 0;pivot[t;a;g]w;tree[z;t;l;g;a;p]q]}

/ treetable calculations:  initial, expand a node, collapse a node
tree:{[z;t;l;g;a;p;q]$[z~();rollup;count[p]>count q;expand1;collapse1][z;t;l;g;a;p]q}
rollup:{[z;t;l;g;a;p;q]sys g xasc$[z~();cols[m]xcols root[t;g]a;cols[m]#z],m:steps[t;l;g;a]p}
expand1:{[z;t;l;g;a;p;q]rollup[z;t;l;g;a;p except q]()}
collapse1:{[z;t;l;g;a;p;q]sys delete from z where(-1_'exec n_ from z)in get each q except p}

/ treetable calculation
root:{[t;g;a]g xcols flip enlist each calc[t;();();a;g],`g_`e_`n_`l_!(`;0b;0#`;0)}
steps:{[t;l;g;a;p]raze nodes[t;l;g;a]'[key q;get q:p group key each p]}
nodes:{[t;l;g;a;k;p]key[a]xcols$[g~k;leaf;node][t;l;sel[t;k]p;g;a]k}
leaf:{[t;l;w;g;a;k]virtual[(b except c)#a]?[t;w;0b;({x!x}(c:cols t)inter b:key a),`g_`e_`n_`l_!(`i;1b;(flip;enlist,g,`i);1+count g)]}
node:{[t;l;w;g;a;k]h:k,first c:g except k;![calc[t;w;h!h;a]1_c;();0b;`g_`e_`n_`l_!(last h;$[l;0b;g~h];(flip;enlist,h);count h)]}
virtual:{[a;u]$[count a;![u;();0b;?[0#u;();();(first 0#),/:enlist each a]];u]}
calc:{[t;w;h;a;n]k:$[99h=type h;n,key h;n]_a;r:?[t;w;h;k];v:t[n][;0N];$[98h=type key r;@[0!r;n;:;v];r,n!v]}
sel:{[t;k;p]$[0=count k;();all b:$[not[type p]|30>count p;psel[t]p;(k#t)in p];();enlist b]}
psel:{[t;p]@[count[t]#0b;raze?[t;;();`i]each{flip(=;key x;sym each get x)}each p;:;1b]}
used:{exec n from x where min'[v{x\'[til count x]}n?-1_'n]}
sys:{update o_:i in p_ from update p_:n_?-1_'n_ from x}
sym:{$[-11h=type x;enlist x;x]}

/ treetable row event = drilldown
drill:{[b;p;g;n]`n xasc'(p[0],([n:enlist(count[n]#g)!n,()]v:enlist b);p 0)}

/ pivot table calculation
pivot:{[t;a;g;w]
 h:{y,x except y}[g]g[0],g 1+count w 1;f:1#c:w[0]0;u:?[t;w 1;0b;()];
 z:tree[();u;0b;h;a;exec n from opento[u;h]h 1]();
 r:flip enlist 1_cols z:`n_ xcol 0!pcalc[z;c]. 2#h;z[`n_]:enlist[0#`],flip enlist 1_z`n_;
 z[0;1_cols z]:xkey[`g_;tree[();u;0b;1_h;a;exec n from P 0]()][r;c];
 flip flip[z],`o_`p_`g_`e_`l_!(1b;0N;last each z`n_;1b;0)}

/ pivot table (h/t: nick psaris, Q-TIPS)
pcalc:{[t;z;y;x]?[t;();y!y,:();({x#(`$string y)!z}`$string asc distinct t x;x;z)]}

/ pivot row event = select + Y
row:{[z;x;w;g;q;c;r](z;@[w;1 2;,;(ceq[c;r]w[0;1]c;enlist g)];k,g except k:g 1+g?x)}

/ pivot col event = Y
col:{[z;w;g;q;c]zcol[z].$[null c;(w;g);c=`g_;gcol[w]g;wcol[w;g;q]c]}
wcol:{[w;g;q;c]$[0=count w 0;(((c;q);w 1;());g);((w 0;wsel[g;c;w 1]w[0;1];w[2],enlist g);g)]}
gcol:{[w;g]$[count w 1;0N!(0 -1 -1_'w;last w 2);((();();());g)]}
wsel:{[g;c;s;q]$[last[g]=k:g 1+count s;s;s,ceq[k;c]q k]}
zcol:{[z;w;g]($[count w 1;z;()];w;g)}

/ pivot constraint: column = value
ceq:{[c;v;q]enlist(=;c;(1*"s"=lower q)enlist/upper[q]$string v)}

/ path constant
P:(([n:enlist(0#`)!0#`]v:enlist 1b);([n:()]v:til 0))

/ keep valid paths
valid:{[p;g](1!(0!p 0)where til[count g]{(count[y]#x)~y}/:g?/:key each exec n from p 0;P 1)}

/ open/close to group (h=` -> open to leaves)
opento:{[t;g;h]inst distinct(enlist(0#`)!0#`),raze t to/:(1+til count k)#\:k:(g?h)#g}
inst:{[m]([n:m]v:count[m]#1b)}
to:{(enlist(0#`)!0#`),y!/:flip distinct x y}
expand:{[t;g](opento[t;g]last g;P 1)}

/ columns
visible:{[q;g;i]key[q]except g,i}
invisible:{[w;t;a;q;f;g]$[count w 0;();distinct[cols[t],key a,q]except f,g]}
groupable:{[t](exec c from meta t where t in"bhijspmdznuvt")except keys t}

/ rollups
rollups:{[t;a;g;f](f,g)#@[@[a;k;:;A[lower qtype[t]k],'k:cols[t]except key a];g;:;nul,'g]}
nul:{first$[1=count distinct x;x;0#x]}
seq:{$[1=count distinct x;first x;`$string[first x],"+"]}
A:" bgxhijefcspmdznuvt"!(nul;any;nul;nul;sum;sum;sum;sum;sum;nul;seq;max;max;max;max;sum;max;max;max)

/ cast <- type
qtype:{exec c!t from meta x where not(c=lower c)&c like"?_"}

/ treetable sort
sort:{[t;g;s;w]$[count s;tsort[t;$[count w 0;();g];key s]get s;(::)]}

tsort:{[t;g;c;o]
 if[0=count g;:0,1+msort[1_t;c]o];
 if[`g_~first -1_c;c:`g__,1_c;t:update g__:?[l_>1;`;g_]from t];
 n:reverse exec i by l__ from s:dsort[t;g;c;o]where l__>0;
 0,raze$[1=count n;s[`i__]n;merge[s;g]/[();key n;get n]]}

dsort:{[t;g;c;o]
 a:!/[g,/:(`i__`l__;`i`l_)];c:c!csort[c]o;s:1=count distinct o:(<:;>:)o in`d`D;
 $[s;?[t;();0b;a;0W;(first o;esort c)];?[t;();0b;a]rsort[t;c]o]}

msort:{[t;c;o]{x y z x}/[::;(`a`d`A`D!(iasc;idesc;iasc abs@;idesc abs@))o;t c]}
csort:{[c;o]@[flip(@;abs;c;c);i;:;c i:where o in`a`d]}
rsort:{[t;c;o]{x y z x}/[::;reverse o;?[t;();();enlist,reverse get c]]}
esort:{[c]$[1=count c;first c;(flip;(!;enlist key c;enlist,get c))]}
level:{[s;g;n;i]c:((m:n&count g)#g),`i__;(delete i__ from t)!flip enlist(t:(c#s)i)`i__}
merge:{[s;g;x;n;i]v:level[s;g;n;i];$[count x;@[v;(keys v)#key x;,;get x];v]}
