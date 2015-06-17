// treetable

\d .ht

/ construct treetable
cons:{[z;t;l;p;as;gf;vwxy]sort[tree[z;t;l;gf 0;rollups[t;as 0]. gf]. used each p;gf 0;key as 1]get as 1}

/ treetable calculations:  initial, expand a node, collapse a node
tree:{[z;t;l;g;a;p;p_]$[z~();initial;count[p]>count p_;expand1;collapse1][z;t;l;g;a;p]p_}
initial:{[z;t;l;g;a;p;p_]rollup[z;t;l;g;a]p}
expand1:{[z;t;l;g;a;p;q]rollup[z;t;l;g;a]p except q}
rollup:{[z;t;l;g;a;p]op g xasc$[z~();cols[m]xcols root[t;g]a;cols[m]#z],m:steps[t;l;g;a]p}
collapse1:{[z;t;l;g;a;p;q]op delete from z where(-1_'exec n_ from z)in get each q except p}

/ treetable calculation
root:{[t;g;a]g xcols flip enlist each calc[t;();();a;g],`g_`e_`n_`l_!(`;0b;0#`;0)}
steps:{[t;l;g;a;p]raze nodes[get t;l;g;a]'[key q;get q:p group key each p]}
nodes:{[t;l;g;a;k;p]key[a]xcols$[g~k;leaf;node][t;l;find[t;k]p;g;a]k}
leaf:{[t;l;w;g;a;k]virtual[(b except c)#a]?[t;w;0b;({x!x}(c:cols t)inter b:key a),`g_`e_`n_`l_!(`i;1b;(flip;enlist,g,`i);1+count g)]}
node:{[t;l;w;g;a;k]h:k,first c:g except k;![calc[t;w;h!h;a]1_c;();0b;`g_`e_`n_`l_!(last h;$[l;0b;g~h];(flip;enlist,h);count h)]}
virtual:{[a;u]![u;();0b;?[0#u;();();(first 0#),/:enlist each a]]}
calc:{[t;w;h;a;n]k:$[99h=type h;n,key h;n]_a;r:?[t;w;h;k];v:t[n][;0N];$[98h=type key r;@[0!r;n;:;v];r,n!v]}
find:{[t;k;p]$[0=count k;();all b:$[not[type p]|30>count p;findp[t]p;(k#t)in p];();enlist b]}
findp:{[t;p]@[count[t]#0b;raze?[t;;();`i]each{flip(=;key x;sym each get x)}each p;:;1b]}
used:{exec n from x where min'[v{x\'[til count x]}n?-1_'n]}
op:{update o_:i in p_ from update p_:n_?-1_'n_ from x}
sym:{$[-11h=type x;enlist x;x]}

/ pivot events (incomplete)
pivot:{[u;k;c;r]$[c=`g_;unpivot u;prepivot[u;k;c]r]}
unpivot:{[u](-1_u;last u)}

prepivot:{[u;k;c;r]
 u,:enlist k;
 k[`X]:k[`G]1;k[`G]:k[`G]except k`X;
 if[n:null k`V;k[`V]:c];
 $[m:null r:first r;k[`Y]:`;[k[`Y]:k[`G]0;k[`G]:1_k`G]];
 if[m&not n;k[`W]:enlist(=;k`X;sym c)];
 if[n&not m;k[`W]:enlist(=;k`Y;sym r)];
 if[not n|m;k[`W]:((=;k`X;c);(=;k`Y;sym r))];
 k[`S]:()!();k[`P]:P;
 (u;k)}

/ pivot (h/t: nick psaris)
pcalc:{[t;z;y;x]?[t;();y!y,:();({x#(`$string y)!z}`$string asc distinct t x;x;z)]}

/ system constants
I:enlist(0#`)!0#`
P:(([n:I]v:enlist 1b);([n:()]v:til 0))

/ open/close at a node
row:{[b;p;g;n]`n xasc'(p[0],([n:enlist(count[n]#g)!n,()]v:enlist b);p 0)}

/ keep valid paths
vpaths:{[p;g](1!(0!p 0)where til[count g]{(count[y]#x)~y}/:g?/:key each exec n from p 0;P 1)}

/ open/close to group (h=` -> open to leaves)
opento:{[t;g;h]inst distinct I,raze t to/:(1+til count k)#\:k:(g?h)#g}
inst:{[m]([n:m]v:count[m]#1b)}
to:{I,y!/:flip distinct x y}
expand:{[t;g](opento[t;g]last g;P 1)}

/ rollups
rollups:{[t;a;g;f]f#@[@[a;k;:;A[lower qtype[t]k],'k:cols[t]except key a];g;:;nul,'g]}
nul:{first$[1=count distinct x;x;0#x]}
seq:{$[1=count distinct x;first x;`$string[first x],"+"]}
A:" bgxhijefcspmdznuvt"!(nul;any;nul;nul;sum;sum;sum;sum;sum;nul;nul;max;max;max;max;sum;max;max;max)

/ cast <- type
qtype:{exec c!t from meta x where not(c=lower c)&c like"?_"}

/ treetable sort
sort:{[t;g;c;o]
 if[0=count g;:t[0],msort[1_t;c]o];
 if[`g_~first -1_c;c:`z_,1_c;t:update z_:?[l_>1;`;g_]from t];
 n:reverse exec i by L_ from s:dsort[t;g;c;o]where L_>0;
 delete z_ from t 0,raze$[1=count n;s[`I_]n;merge[s;g]/[();key n;get n]]}

dsort:{[t;g;c;o]
 a:!/[g,/:(`I_`L_;`i`l_)];c:c!csort[c]o;s:1=count distinct o:(<:;>:)o in`d`D;
 $[s;?[t;();0b;a;0W;(first o;esort c)];?[t;();0b;a]rsort[t;c]o]}

msort:{[t;c;o]t{x y z x}/[::;(`a`d`A`D!(iasc;idesc;iasc abs@;idesc abs@))o;t c]}
csort:{[c;o]@[flip(@;abs;c;c);i;:;c i:where o in`a`d]}
rsort:{[t;c;o]{x y z x}/[::;reverse o;?[t;();();enlist,reverse get c]]}
esort:{[c]$[1=count c;first c;(flip;(!;enlist key c;enlist,get c))]}
level:{[s;g;n;i]c:((m:n&count g)#g),`I_;(delete I_ from t)!flip enlist(t:(c#s)i)`I_}
merge:{[s;g;x;n;i]v:level[s;g;n;i];$[count x;@[v;(keys v)#key x;,;get x];v]}




