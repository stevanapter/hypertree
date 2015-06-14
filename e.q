// js events

/ events
.js.row:{[d]if[h:count G;if[(U|m<h)&0<m:count n:.js.cnv[G;Q]d`row;if[count[get Z]>r:Z[`n_]?n;`P set .ht.row[not Z[`o_]r;P;G]n;:.js.set d]]]}
.js.col:{[d]if[2<=count G;(Z,K)set'.ht.col[Z;K!get each K]d`col;:.js.set d]}
.js.cell:{[d]}
.js.sorts:{[d]`S set .js.sad[Q]d[`cols]!d`sorts;$[0=count S;.js.set d;[Z set .ht.sort[get Z;G;key S]get S;.js.ret d]]}
.js.groups:{[d]`F`G set'.js.sym d`visible`groups;`P set .ht.vpaths[P]G;Z set();.js.set d}
.js.get:{[d]`R set`start`end!"j"$d`start`end;.js.ret d}
.js.reset:{[d](Z,`S`P)set'(();()!();.ht.P);.js.set d}
.js.expand:{[d]if[count G;`P set .ht.expand[T]G;:.js.set d]}
.js.collapse:{[d]if[count G;Z set();`P set .ht.P;:.js.set d]}

/ event utilities
.js.sad:{k!{$[z in`a`d;z;not x[y]in"sc";z;lower z]}[x]'[k:key y;get y]}
.js.cnv:{raze@[flip enlist z;i;{y$string x};upper q i:where"s"<>q:y count[z]#x]}
.js.exe:{.js[x`fn]x}
.js.val:{$[x in key[`.],raze{` sv'(`,x),/:1_key` sv`,x}each key`;get x;()]}
.js.set:{Z set .ht.cons[.js.val Z;T;P;A;S;G]F;`Z set Z;.js.ret x}
