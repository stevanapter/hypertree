// hypertree client

\p 12345
\t 2000

\l j.q
\l l.q

/ connect to server
.js.K:0Ni
.js.K_:`::12346
.z.ts:{if[null .js.K;.js.K:@[hopen;.js.K_;.js.K]]}
.z.pc:{.js.K::0Ni}

/ websocket communications
.js.J:0Ni
$[.z.K<3.3;
  [.z.pc:{[w]$[w=.js.J;.js.J:0Ni;w=.js.K;.js.K:0Ni]};
   .z.po:{.js.J:.z.w;neg[.js.K](1#`fn)!1#`set}];
  [.z.pc:{[w]if[w=.js.K;.js.K:0Ni]};
   .z.wc:{[w]if[w=.js.J;.js.J:0Ni]};
   .z.wo:{.js.J:.z.w;neg[.js.K](1#`fn)!1#`set}]];

.z.ws:{t:.z.z;.js.rcv .js.sym a:.j.k x;.js.log[t]a}

/ client utilities
.js.get:{`R set`start`end!"j"$x`start`end;.js.ret x}
.js.ini:{key[x]set'get x;.js.jsn .js.obj`}
.js.exe:{r::R;key[x 1]set'get x 1;R::r;.js.jsn .js.ret x 0}
.js.rcv:{$[`get=x`fn;.js.jsn .js.get@;.js.ksn]x}
.js.jsn:{if[not(::)~x;if[not null .js.J;neg[.js.J].j.j x]]}
.js.ksn:{if[not null .js.K;neg[.js.K]x]}
