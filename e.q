// js events

/ events
.js.row:{[d]if[0=count W 0;if[h:count G;if[(L|m<h)&0<m:count n:.js.cnv[G;Q]d`row;if[count[get Z]>r:Z[`n_]?n;`P set .ht.row[not Z[`o_]r;P;G]n;:.js.set d]]]]}
.js.col:{[d]`P`S set'(.ht.P;()!());(Z,`W`G)set'.ht.col[get Z;W;G;Q]d`col;.js.set d}
.js.cell:{[d]`P`S set'(.ht.P;()!());(Z,`W`G)set'.ht.cell[get Z;W;G;Q]. d`col`row;.js.set d}
.js.sorts:{[d]`S set .js.sad[Q]d[`cols]!d`sorts;`K set .ht.sort[get Z;G;S]W;.js.ret d}
.js.groups:{[d]`F`G set'.js.sym d`visible`groups;`P set .ht.valid[P]G;Z set();.js.set d}
.js.get:{[d]`R set`start`end!"j"$d`start`end;.js.ret d}
.js.reset:{[d](Z,`G`F`S`P`W`V)set'(();G_;F_;S_;P_;W_;V_);.js.set d}
.js.expand:{[d]`P set .ht.expand[0!get T]G;.js.set d}
.js.collapse:{[d](Z,`P)set'(();.ht.P);.js.set d}
.js.swap:{[d]$[0=count W 0;[`G set G[1 0],2_G;`P set .ht.valid[P]G;Z set()];@[`G;G?Y,X;:;G G?X,Y]];.js.set d}
.js.up:{[d]`G set 1 rotate G;`P set .ht.valid[P]G;Z set();.js.set d}
.js.down:{[d]`G set -1 rotate G;`P set .ht.valid[P]G;Z set();.js.set d}
.js.pause:{[d]`U set not U;.js.ret d}

/ event utilities
.js.sad:{$[count k:key y;k!{$[z in`a`d;z;not x[y]in"sc";z;lower z]}[x]'[k;get y];()!()]}
.js.cnv:{raze@[flip enlist z;i;{y$string x};upper q i:where"s"<>q:y count[z]#x]}
.js.exe:{.js[x`fn]x}
.js.var:{x in key[`.],raze{` sv'(`,x),/:1_key` sv`,x}each key`}
.js.val:{$[.js.var x;get x;()]}
.js.set:{Z set .ht.cons[.js.val Z;0!get T;L;P;A;G;F]W;`Z set Z;`K set .ht.sort[get Z;G;S]W;.js.ret x}
