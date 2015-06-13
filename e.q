// js events

.js.row:{[d]if[Y;if[count G;if[0<count n:.js.cnv[G;Q]d`row;if[count[get Z]>r:Z[`n_]?n;`P set .ht.row[not Z[`o_]r;P;G]n;:.js.set d]]]]}
.js.col:{[d]}
.js.cell:{[d]}
.js.sorts:{[d]}
.js.groups:{[d]}
.js.get:{[d]`R set`start`end!"j"$d`start`end;.js.ret d}
.js.reset:{[d]}
.js.expand:{[d]}
.js.collapse:{[d]}

/ event utilities
.js.sad:{k!{$[z in`a`d;z;not x[y]in"sc";z;lower z]}[x]'[k:key y;get y]}
.js.cnv:{raze@[flip enlist z;i;{y$string x};upper q i:where"s"<>q:y count[z]#x]}
.js.exe:{.js[x`fn]x}
.js.val:{$[x in key[`.],raze{` sv'(`,x),/:1_key` sv`,x}each key`;get x;()]}
.js.set:{Z set .ht.cons[.js.val Z;T;P;A;S;G;F]L;`Z set Z;.js.ret x}
