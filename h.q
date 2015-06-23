// single-process treetable

\p 12345

\l t.q
\l x.q
\l a.q
\l d.q
\l i.q
\l j.q
\l e.q
\l l.q

/ websocket communications
.js.J:0Ni
$[.z.K<3.3;
  [.z.pc:{[w]if[w=.js.J;.js.J:0Ni]};
   .z.po:{.js.J:.z.w;.js.set()}];
  [.z.wc:{[w]if[w=.js.J;.js.J:0Ni]};
   .z.wo:{.js.J:.z.w;.js.set()}]];

.z.ws:{t:.z.z;.js.snd .js.exe .js.sym a:.j.k x;.js.log[t]a}

/ update
.js.upd:{if[not null .js.J;t:.z.z;Z set();P[1]:.ht.P 1;.js.snd .js.set();.js.log[t]`upd]}
