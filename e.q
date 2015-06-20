// js events

/ events
.js.row:{[d]if[Y;if[0=count W 0;if[h:count G;if[(L|m<h)&0<m:count n:.js.cnv[G;Q]d`row;if[count[get Z]>r:Z[`n_]?n;`P set .ht.row[not Z[`o_]r;P;G]n;:.js.set d]]]]]}
.js.col:{[d]if[X;`P set .ht.P;`S set()!();(Z,`W`G)set'.ht.col[get Z;W;G;Q]d`col;:.js.set d]}
.js.cell:{[d]if[X;`P set .ht.P;`S set()!();(Z,`W`G)set'.ht.cell[get Z;W;G;Q]. d`col`row;:.js.set d]}
.js.sorts:{[d]`S set .js.sad[Q]d[`cols]!d`sorts;`K set .ht.sort[get Z;G;S]W;.js.ret d}
.js.groups:{[d]`F`G set'.js.sym d`visible`groups;`P set .ht.valid[P]G;Z set();.js.set d}
.js.get:{[d]`R set`start`end!"j"$d`start`end;.js.ret d}
.js.reset:{[d](Z,`S`P`W`K)set'(();()!();.ht.P;(();();());::);.js.set d}
.js.expand:{[d]`P set .ht.expand[T]G;.js.set d}
.js.collapse:{[d]Z set();`P set .ht.P;:.js.set d}

/ event utilities
.js.sad:{$[count k:key y;k!{$[z in`a`d;z;not x[y]in"sc";z;lower z]}[x]'[k;get y];()!()]}
.js.cnv:{raze@[flip enlist z;i;{y$string x};upper q i:where"s"<>q:y count[z]#x]}
.js.exe:{.js[x`fn]x}
.js.val:{$[x in key[`.],raze{` sv'(`,x),/:1_key` sv`,x}each key`;get x;()]}
.js.set:{Z set .ht.cons[.js.val Z;T;L;P;A;G;F]W;`Z set Z;`K set .ht.sort[get Z;G;S]W;.js.ret x}
