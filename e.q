// hypergrid events

/ events
.hg.row:{[d].hg.set$[0=count W 0;.hg.drill_ d;X<>last G;.hg.row_ d;d]}
.hg.col:{[d].hg.set .hg.col_ d}
.hg.cell:{[d].hg.col_ d;.hg.row`col _ d}
.hg.sorts:{[d]`K`S set'.ht.sorts[get Z;G;Q;S;W]d`col;.hg.ret d}
.hg.groups:{[d]`F`G set'.hg.sym d`visible`groups;`P set .ht.valid[P]G;Z set();.hg.set d}
.hg.execute:{[d].hg.set d}

/ event functions
.hg.row_:{[d]`P set .ht.paths;(Z,`W`G`S)set'.ht.row[get Z;X;W;G;Q;S].(Y;first d`row);d}
.hg.col_:{[d]`P set .ht.paths;(Z,`W`G`S)set'.ht.col[get Z;W;G;Q;S]d`col;d}
.hg.pivot_:{[x;d]`P set .ht.paths;(Z,`W`G`S)set'.ht.pivot[get Z;W;G;Q;S;F]x;.hg.set d}
.hg.drill_:{[d]if[(L|m<h)&(h:count G)&0<m:count n:.hg.cnv[G;Q]d`row;if[count[get Z]>r:Z[`n_]?n;`P set .ht.drill[not Z[`o_]r;P;G]n;:d]]}

/ buttons
.hg.Reset:{[d](Z,`G`F`S`P`W`U)set'(();G_;F_;S_;P_;W_;U_);.hg.set d}
.hg.Expand:{[d](Z,`P)set'(();.ht.expand[0!get T]G);.hg.set d}
.hg.Collapse:{[d](Z,`P)set'(();.ht.paths);.hg.set d}
.hg.Back:.hg.pivot_ -1
.hg.Forth:.hg.pivot_ 1
.hg.Swap:{[d]$[0=count W 0;[`G set G[1 0],2_G;`P set .ht.valid[P]G;Z set()];@[`G;G?Y,X;:;G G?X,Y]];.hg.set d}
.hg.Up:{[d]`G set 1 rotate G;`P set .ht.valid[P]G;Z set();.hg.set d}
.hg.Down:{[d]`G set -1 rotate G;`P set .ht.valid[P]G;Z set();.hg.set d}
.hg.Pause:{[d]`U set 0b;.hg.ret d}
.hg.Play:{[d]`U set 1b;.hg.ret d}

/ scrolling
.hg.get:{[d]`R set`start`end!"j"$d`start`end;.hg.ret d}

/ event utilities
.hg.sad:{$[count k:key y;k!{$[z in`a`d;z;not x[y]in"sc";z;lower z]}[x]'[k;get y];()!()]}
.hg.cnv:{raze@[flip enlist z;i;{y$string x};upper q i:where"s"<>q:y count[z]#x]}
.hg.exe:{E .hg[x`fn]x}
.hg.val:{$[.hg.var x;get x;()]}
.hg.vse:{$[(t:type y)>99h;{$[11h=type x;0!get x;0!x]}y x;t in 6 7h;(0!get x)y;0!get x]}
.hg.set:{Z set .ht.cons[.hg.val Z;.hg.vse[T]V;J;L;P;.ht.rollups[T;A;G]F;G]W;`Z set Z;`K set .ht.sort[get Z;G;S]W;.hg.ret x}
