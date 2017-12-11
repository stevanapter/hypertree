// hypertree client

\p 12345
\t 2000

\l j.q

\e 1

/ connect to server
.hg.K:0Ni
.hg.K_:`::12346
.z.ts:{if[null .hg.K;.hg.K:@[hopen;.hg.K_;.hg.K]]}
.z.pc:{.hg.K::0Ni}

/ websocket communications
.hg.J:0Ni
.z.pc:{[w]if[w=.hg.K;.hg.K:0Ni]}
.z.wc:{[w]if[w=.hg.J;.hg.J:0Ni]}
.z.wo:{.hg.J:.z.w;neg[.hg.K](1#`fn)!1#`set}
.z.ws:{.hg.rcv .hg.sym .j.k x}

/ client utilities
.hg.get:{`R set`start`end!"j"$x`start`end;.hg.ret x}
.hg.ini:{key[x]set'get x;.hg.hgn .hg.obj`}
.hg.exe:{r::R;key[x 1]set'get x 1;R::r;.hg.hgn .hg.ret x 0}
.hg.rcv:{$[`get=x`fn;.hg.hgn .hg.get@;.hg.ksn]x}
.hg.hgn:{if[not(::)~x;if[not null .hg.J;neg[.hg.J].j.j x]]}
.hg.ksn:{if[not null .hg.K;neg[.hg.K]x]}
