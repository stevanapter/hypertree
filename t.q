// hypertree

\d .ht

/ construct treetable
cons:{[z;t;j;l;p;a;g;w]mode[w;z;orders[t;a]j;l;g;a]. used each p}
mode:{[w;z;t;l;g;a;p;q]$[count w 0;matrix[t;g;a]w;tree[z;t;l;g;a;p]q]}

/ treetable calculations:  initial, expand a node, collapse a node
tree:{[z;t;l;g;a;p;q]$[z~();rollup;count[p]>count q;expand1;collapse1][z;t;l;g;a;p]q}
rollup:{[z;t;l;g;a;p;q]sys g xasc$[z~();cols[m]xcols root[t;g]a;cols[m]#z],m:steps[t;l;g;a]p}
expand1:{[z;t;l;g;a;p;q]rollup[z;t;l;g;a;p except q]()}
collapse1:{[z;t;l;g;a;p;q]sys delete from z where(-1_'exec n_ from z)in get each q except p}

/ treetable calculation
root:{[t;g;a]g xcols flip enlist each calc[t;();();a;g],`g_`e_`n_`l_!(n;0b;0#n:t[-1;g 0];0)}
steps:{[t;l;g;a;p]raze nodes[t;l;g;a]'[key q;get q:p group key each p]}
nodes:{[t;l;g;a;k;p]key[a]xcols$[g~k;leaf;node][t;l;sel[t;k]p;g;a]k}
leaf:{[t;l;w;g;a;k]virtual[a;b;c]?[t;w;0b;({x!x}(c:cols t)inter b:key a),`g_`e_`n_`l_!(`i;1b;(flip;enlist,g,`i);1+count g)]}
node:{[t;l;w;g;a;k]h:k,first c:g except k;![calc[t;w;h!h;a]1_c;();0b;`g_`e_`n_`l_!(last h;$[l;0b;g~h];(flip;enlist,h);count h)]}
virtual:{[a;b;c;u]$[count a:(b except c)#a;![u;();0b;?[0#u;();();(first 0#),/:enlist each a]];u]}
calc:{[t;w;h;a;n]k:$[99h=type h;n,key h;n]_a;r:?[t;w;h;k];v:t[n][;0N];$[98h=type key r;@[0!r;n;:;v];r,n!v]}
sel:{[t;k;p]$[0=count k;();all b:$[not[type p]|30>count p;psel[t]p;(k#t)in p];();enlist b]}
psel:{[t;p]@[count[t]#0b;raze?[t;;();`i]each{flip(=;key x;{$[-11h=type x;enlist x;x]}each get x)}each p;:;1b]}
used:{exec n from x where min each v{(x scan)each til count x}n?({$[count x;x;()]}each -1_)each n}
sys:{update o_:i in p_ from update p_:n_?-1_'n_ from x}

/ treetable row event = drilldown
drill:{[b;p;g;n]`n xasc'(p[0],([n:enlist(count[n]#g)!n,()]v:enlist b);p 0)}

/ pivot row event = select + Y
row:{[z;x;w;g;q;s;c;r](z;@[w;1 2 3;,;(ceq[c;r]w[0;1]c;enlist g;2 enlist/()!())];k,g except k:g 1+g?x;()!())}

/ pivot col event = Y
col:{[z;w;g;q;s;c]zcol[z].$[null c;(w;g;s);c=`g_;gcol[w]g;wcol[w;g;q;s]c]}
wcol:{[w;g;q;s;c]$[0=count w 0;(((c;q;s);w 1;();());g;()!());((w 0;wsel[g;c;w 1]w[0;1];w[2],enlist g;w[3],2 enlist/s);g;()!())]}
gcol:{[w;g]$[count w 1;(0 -1 -1 -1_'w;last w 2;first last w 3);(state;g;w[0;2])]}
wsel:{[g;c;s;q]$[last[g]=k:g 1+count s;s;s,ceq[k;c]q k]}
zcol:{[z;w;g;s]($[count w 1;z;()];w;g;s)}

/ "z-axis" = pivot columns
pivot:{[z;w;g;q;s;f;d]$[0=count w 0;col[z;w;g;q;s]f 0;zcol[z;.[w;0 0;:;first(d+f?w[0;0])rotate f];g]s]}

/ pivot constraint: column = value
ceq:{[c;v;q]enlist(=;c;(1*"s"=lower q)enlist/upper[q]$string v)}

/ pivot table calculation
matrix:{[t;g;a;w]
 h:{y,x except y}[g]g[0],g 1+count w 1;c:w[0]0;u:?[t;w 1;0b;()];
 z:tree[();u;0b;h;a;exec n from opento[u;h]h 1]();
 r:flip enlist 1_cols z:`n_ xcol 0!pcalc[z;c]. 2#h;z[`n_]:enlist[0#`],flip enlist 1_z`n_;
 z[0;1_cols z]:xkey[`g_;tree[();u;0b;1_h;a;exec n from paths 0]()][r;c];
 flip flip[z],`o_`p_`g_`e_`l_!(1b;0N;last each z`n_;1b;0)}

/ pivot table (h/t: nick psaris, Q-TIPS)
pcalc:{[t;z;y;x]?[t;();y!y,:();({x#(`$string y)!z}`$string hasc distinct t x;x;z)]}

/ path constant
paths:(([n:enlist(0#`)!()]v:enlist 1b);([n:()]v:til 0))

/ pivot-state constant
state:(();();();())

/ keep valid paths
valid:{[p;g](1!(0!p 0)where til[count g]{(count[y]#x)~y}/:g?/:key each exec n from p 0;paths 1)}

/ open/close to group (h=` -> open to leaves)
opento:{[t;g;h]inst distinct(enlist(0#`)!()),raze t to/:(1+til count k)#\:k:(g?h)#g}
inst:{[m]([n:m]v:count[m]#1b)}
to:{(enlist(0#`)!0#`),y!/:flip distinct x y}
expand:{[t;g](opento[t;g]last g;paths 1)}

/ columns
visible:{[q;g;i]key[q]except g,i}
invisible:{[w;t;a;q;f;g]$[count w 0;();distinct[cols[t],key a,q]except f,g]}
groupable:{[t](exec c from meta t where t in"bhijspmdznuvt")except keys t}

/ rollups
rollups:{[t;a;g;f](f,g)#@[@[a;k;:;dru[lower qtype[t]k],'k:cols[t]except key a];g;:;nul,'g]}
nul:{first$[1=count distinct x;x;0#x]}
seq:{$[1=count distinct x;first x;`$string[first x],"+"]}
dru:" bgxhijefcspmdznuvt"!(nul;any;nul;nul;sum;sum;sum;sum;sum;nul;seq;max;max;max;max;sum;max;max;max)

/ cast <- type
qtype:{exec c!t from meta x where not(c=lower c)&c like"?_"}

/ order within nodes
orders:{[t;a;j]
 S:{t:0!z;keys[z]xkey t x t y};
 A:S[iasc abs@];D:S[idesc abs@];f:(hxasc;hxdesc;A;D)`a`d`A`D?;
 keys[t]xkey order[0!t;a;0!update f o from j;()]}

order:{[t;a;j;w]
 if[0=count j;:?[t;w;0b;()]];
 v:first j;j:1_j;c:v`c;s:v`s;n:v`n;o:v`o;
 r:?[t;w;enlist[c]!enlist c;enlist[s]!enlist a s];
 raze .z.s[t;a;j]each{x,enlist(=;y;enlist z)}[w;c]each(n&count r)#?[o[s]r;();();c]}

/ sort event
sorts:{[t;g;q;s;w;c]
 if[b:not c in key s;s[c]:`a];
 if[not b;$[null n:$[q[c]in"bspmdznuvt";`d`@`a`d?;`d`A`D`@`a`d`A`D?]s c;s:c _ s;s[c]:n]];
 (sort[t;g;s]w;s)}

/ treetable/pivot sort
sort:{[t;g;s;w]$[count s;tsort[t;$[count w 0;();g];key s]get s;(::)]}

tsort:{[t;g;c;o]
 if[0=count g;:0,1+msort[1_t;c]o];
 if[`g_~first -1_c;c:`G_,1_c;t:update G_:?[l_>1;first 0#g_;g_]from t];
 n:reverse exec i by L_ from s:dsort[t;g;c;o]where L_>0;
 0,raze$[1=count n;s[`I_]n;merge[s;g]/[();key n;get n]]}

dsort:{[t;g;c;o]
 a:!/[g,/:(`I_`L_;`i`l_)];c:c!csort[c]o;o:(hiasc;hidesc)o in`d`D;
 $[1=count distinct o;?[t;();0b;a;0W;(first o;esort c)];?[t;();0b;a]rsort[t;c]o]}

msort:{[t;c;o]{x y z x}/[::;(`a`d`A`D!(hiasc;hidesc;iasc abs@;idesc abs@))o;t c]}
csort:{[c;o]@[flip(@;abs;c;c);i;:;c i:where o in`a`d]}
rsort:{[t;c;o]{x y z x}/[::;reverse o;?[t;();();enlist,reverse get c]]}
esort:{[c]$[1=count c;first c;(flip;(!;enlist key c;enlist,get c))]}
level:{[s;g;n;i]c:((m:n&count g)#g),`I_;(delete I_ from t)!flip enlist(t:(c#s)i)`I_}
merge:{[s;g;x;n;i]v:level[s;g;n;i];$[count x;@[v;(keys v)#key x;,;get x];v]}

/ case-insensitive sort
hsort:{$[type[y]in 10 11h;x lower@;x]y}
hiasc:hsort iasc
hidesc:hsort idesc
hasc:{x hiasc x}
hdesc:{x hdesc x}
hxasc:{keys[y]xkey(0!y)hiasc?[y;();();x]}
hxdesc:{keys[y]xkey(0!y)hidesc?[y;();();x]}

