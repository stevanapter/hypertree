// js events

/ events
.js.row:{[d].js.set$[0=count W 0;.js.drill_ d;X<>last G;.js.row_ d;d]}
.js.col:{[d].js.set .js.col_ d}
.js.cell:{[d].js.col_ d;.js.row`col _ d}
.js.sorts:{[d]`S set .js.sad[Q]d[`cols]!d`sorts;`K set .ht.sort[get Z;G;S]W;.js.ret d}
.js.groups:{[d]`F`G set'.js.sym d`visible`groups;`P set .ht.valid[P]G;Z set();.js.set d}

/ event functions
.js.row_:{[d]`P set .ht.P;(Z,`W`G`S)set'.ht.row[get Z;X;W;G;Q;S].(Y;first d`row);d}
.js.col_:{[d]`P set .ht.P;(Z,`W`G`S)set'.ht.col[get Z;W;G;Q;S]d`col;d}
.js.drill_:{[d]if[(L|m<h)&(h:count G)&0<m:count n:.js.cnv[G;Q]d`row;if[count[get Z]>r:Z[`n_]?n;`P set .ht.drill[not Z[`o_]r;P;G]n;:d]]}
.js.pivot_:{[x;d]`P set .ht.P;(Z,`W`G`S)set'.ht.pivot[get Z;W;G;Q;S;F]x;.js.set d}

/ buttons
.js.Reset:{[d](Z,`G`F`S`P`W`U)set'(();G_;F_;S_;P_;W_;U_);.js.set d}
.js.Expand:{[d]`P set .ht.expand[0!get T]G;.js.set d}
.js.Collapse:{[d](Z,`P)set'(();.ht.P);.js.set d}
.js.Back:.js.pivot_ -1
.js.Forth:.js.pivot_ 1
.js.Swap:{[d]$[0=count W 0;[`G set G[1 0],2_G;`P set .ht.valid[P]G;Z set()];@[`G;G?Y,X;:;G G?X,Y]];.js.set d}
.js.Up:{[d]`G set 1 rotate G;`P set .ht.valid[P]G;Z set();.js.set d}
.js.Down:{[d]`G set -1 rotate G;`P set .ht.valid[P]G;Z set();.js.set d}
.js.Pause:{[d]`U set 0b;.js.ret d}
.js.Play:{[d]`U set 1b;.js.ret d}

/ scrolling
.js.get:{[d]`R set`start`end!"j"$d`start`end;.js.ret d}

/ event utilities
.js.sad:{$[count k:key y;k!{$[z in`a`d;z;not x[y]in"sc";z;lower z]}[x]'[k;get y];()!()]}
.js.cnv:{raze@[flip enlist z;i;{y$string x};upper q i:where"s"<>q:y count[z]#x]}
.js.exe:{.js[x`fn]x}
.js.var:{x in key[`.],raze{` sv'(`,x),/:1_key` sv`,x}each key`}
.js.val:{$[.js.var x;get x;()]}
.js.set:{Z set .ht.cons[.js.val Z;0!get T;L;P;A;G;F]W;`Z set Z;`K set .ht.sort[get Z;G;S]W;.js.ret x}
