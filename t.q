// treetable

\d .ht

/ construct treetable
cons:{[z;t;p;a;s;c;l;w]xy[unctl z;t;p;rollups[tableof t;c 0]a;s;(c 0;req[a]raze c);l]w}

/ (t;u) -> t
tableof:{$[istable x;x;first x]}

/ (t;u) + g -> u g or t
tablefor:{[t;g]$[g in key t 1;t[1]g;t 0]}

/ table?
istable:{type[x]in 98 -11h}

/ required
req:{[a;f]distinct[f,q where -11=type each q:raze over a f]except`}

/ control columns
C:`n_`e_`l_`o_`p_`g_

/ y controls
yctl:{[p;g;l;z]ctl[z;n;isleaf[n;g]l;levelof n;isopen[n]p;parents n]@[`,last each 1_n;where isleaf[n:z`n_;g]1b;:;`]}

/ x controls
xctl:{[z]ctl[z;n;k#1b;k#0;k#0N;(k:count n)#0]`,last each 1_n:z`n_}

/ control table
ctl:{[z;n;e;l;o;p;g]0!![z;();0b;C!`$-1_'string C]}

/ uncontrol table
unctl:{[z]$[count z;1!![z;();0b;1_C];()]}

/ col = pivot down/up
col:{[z;w;g;q;c]zcol[z].$[null c;(w;g);(count[g]=2+count w 1)|c=`g_;gcol[w]g;wcol[w;g;q]c]}
wcol:{[w;g;q;c]$[0=count w 0;(((c;q);w 1;());g);((w 0;wsel[g;c;w 1]w[0;1];w[2],enlist g);g)]}
gcol:{[w;g]$[count w 1;(0 -1 -1_'w;last w 2);(W;g)]}
wsel:{[g;c;s;q]$[last[g]=k:g 1+count s;s;s,ceq[k;c]q k]}
zcol:{[z;w;g]($[count w 1;z;()];w;g)}

/ pivot constraint: column = value
ceq:{[c;v;q]enlist(=;c;(1*"s"=lower q)enlist/upper[q]$string v)}

/ cell = pivot + select
cell:{[z;w;g;q;c;r]a:col[z;w;g;q]c;$[g~h:cellof[g]. a 1;(z;w;g);cellxy[a 0;g;h;r]. a 1]}
cellxy:{[z;g;h;r;v;w;i]w,:ceq[g 0;r 0]v[1]g 0;i,:enlist g;(z;(v;w;i);h)}
cellof:{[g;v;w;i]$[0=count v;g;0=count w;g[1 0],2_g;null k:g 2+g?last[w]1;g;k,g except k]}

/ X or Y axis
xy:{[z;t;p;a;s;c;l;w]
 sort[$[0=count c 0;xctl tt[get t]a;
        0=count w 0;yctl[p 0;c 0;l]y[z;t;a]./(c;visible each p);
                    xctl x[t;a;c 0]w];$[count w 0;();c 0];key s]get s}

/ total + table
tt:{[t;a]
 t:update z_:count[t]#0 from t;a[`z_]:(first;`z_);
 s:1#y[();t;a;1#`z_;cols t]. visible each P;
 r:`n_ xcols update n_:flip enlist`$string til count t from t;
 delete z_ from s,r}

/ open/close Y axis
y:{[z;t;a;g;f;p;p_]$[count[p]>count p_;open[z;t;a;g;f;p]p_;close[z]p_ except p]}

/ open/close X axis (pivot)
x:{[t;a;g;w]
 h:{y,x except y}[g]g[0],g 1+count w 1;f:1#c:w[0]0;u:?[$[istable t;t;tablefor[t]g];w 1;0b;()];
 z:cons[();u;(opento[u;h]h 1;P 1);a;S;(h;f);0b]W;
 z:`n_ xcol 0!pivot[z;c]. 2#h;z[`n_]:enlist[()],flip enlist 1_z`n_;
 z[0;1_cols z]:xkey[`g_;cons[();u;P;a;S;(1_h;f);0b]W][flip enlist 1_cols z;c];
 z}

/ pivot (h/t: nick psaris)
pivot:{[t;z;y;x]?[t;();y!y,:();({x#(`$string y)!z}`$string asc distinct t x;x;z)]}

/ predicates
isopen:{[n;p](0!p)[`v](get each key[p]`n)?n}
isleaf:{[n;g;l]levelof[n]>count g}

/ level of each record
levelof:{[n]count each n}

/ path-list -> parent-vector
parents:{[n]m?-1_'m:`$string n}

/ path-list -> children vectors
children:{[n]@[where each p=/:til count p:parents n;0;1_]}

/ close node
close:{[z;p](0!z)where get[first p]{not$[count[y]<=count x;0b;all x=count[x]#y]}/:exec n_ from z}

/ open node
open:{[z;t;a;g;f;p;p_]delete z_ from `z_ xasc update z_:`$string n_ from 0!z,1!order[f]0!tree[t;a;g;f;p]p_}

/ compute node(s)
tree:{[t;a;g;f;p;p_]tree_[f]1!root[t;g;a;p_]block[t;g;a]/p except p_}
tree_:{[f;z]key[z]!flip f!get[z]f}

/ construct a block = node or leaf
block:{[t;g;a;r;p]r,order[g]$[g~key p;leaf;node 1#g(`,g)?last key p][t;g;a]constraint p}

/ construct root block
root:{[t;g;a;p_]$[0<count p_;();order[g]node_[g;`]root_[t;g]a]}
root_:{[t;g;a]$[istable t;rollup[t;();0b]a;?[tablefor[t]g;enlist(=;`i;0);0b;k!k:key a]]}

/ construct node block
node:{[c;t;g;a;p]node_[g;c 0]$[istable t;get rollup[t;p;c!c]a;?[tablefor[t]g;selection[p;g]c 0;0b;k!k:key a]]}
node_:{[g;c;t]![t;();0b;enlist[`n_]!2 enlist/$[null[c]|not count g;enlist();(1+g?c)#/:flip t g]]}

/ construct leaf block
leaf:{[t;g;a;p]leaf_[g;`$string til count u]u:0!?[tableof t;p;0b;@[last each a;g;:;g]]}
leaf_:{[g;i;t]unrollup[cols t]![t;();0b;enlist[`n_]!2 enlist/$[count g;flip[flip[t]g],'i;flip enlist i]]}

/ null leaves of virtual rollups
unrollup:{[c;t]![t;();0b;c!(first 0#;)each c@:where"_"=last each string c]}

/ rollup with dummy
rollup:{[t;w;g;a]delete z_ from?[t;w;g;((1#`z_)!enlist(count;first key a)),a]}

/ instruction -> constraint
constraint:{[p]flip(=;key p;ensym each get p)}

/ constraint + dimension -> selection
selection:{[p;g;c]p,(enlist(not;(null;c))),$[null h:g 1+g?c;();enlist(null;h)]}

/ order cols
order:{[g;t](`n_,g)xcols t}

/ initial instruction
I:enlist(0#`)!0#`

/ instruction state
P:(([n:I]v:enlist 1b);([n:()]v:til 0))

/ sort dictionary
S:()!()

/ pivot state
W:(();();())

/ visible paths
visible:{[p]n where all each(exec v from p)(reverse q scan)each til count q:parents n:exec n from p}

/ keep valid paths
vpaths:{[p;g](1!(0!p 0)where til[count g]{(count[y]#x)~y}/:g?/:key each exec n from p 0;P 1)}

/ symbol -> enlist symbol
ensym:{[e]$[-11h=type e;enlist e;e]}

/ open/close to group (h=` -> open to leaves)
opento:{[t;g;h]inst distinct I,raze t to/:(1+til count k)#\:k:(g?h)#g}

/ instruction
to:{I,y!/:flip distinct x y}

/ expand to leaves-1
expand:{[t;g](opento[$[istable t;t;tablefor[t]g];g]last g;P 1)}

/ instruction table
inst:{[m]([n:m]v:count[m]#1b)}

/ open/close at a node
row:{[b;p;g;n]`n xasc'(p[0],([n:enlist(count[n]#g)!n,()]v:enlist b);p 0)}

/ rollup: first if 1=count else null
nul:{first$[1=count distinct x;x;0#x]}

/ rollup: first if 1=count else first+
seq:{$[1=count distinct x;first x;`$string[first x],"+"]}

/ type -> rollup
A:" bgxhijefcspmdznuvt"!(nul;any;nul;nul;sum;sum;sum;sum;sum;nul;nul;max;max;max;max;sum;max;max;max)

/ rollups
rollups:{[t;g;a]reorder@[@[a;k;:;A[lower qtype[t]k],'k:cols[t]except key a];g;:;nul,'g]}

/ order dictionary of parse trees by reference
reorder:{[d](deps refs each d)#d}
deps:{flatten[reverse(flatten x@)scan key x]inter key x}
flatten:distinct raze over
refs:flatten{$[-11=t:type x;x;t;();.z.s each x]}@

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
