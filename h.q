// single-process treetable

\p 12345

\l t.q
\l x.q
\l a.q
\l d.q
\l j.q
\l e.q
\l i.q

/ websocket communications
.hg.J:0Ni

$[.z.K<3.3;
  [.z.pc:{[w]if[w=.hg.J;.hg.J:0Ni]};
   .z.po:{.hg.J:.z.w;.hg.set()!()}];
  [.z.wc:{[w]if[w=.hg.J;.hg.J:0Ni]};
   .z.wo:{.hg.J:.z.w;.hg.set()!()}]];

.z.ws:{.hg.snd .hg.exe .hg.sym .j.k x}

/ q -> js
.hg.snd:{if[not(::)~x;neg[.hg.J].j.j x]}

/ update
.hg.upd:{if[U;if[not null .hg.J;t:.z.z;Z set();P[1]:.ht.paths 1;`T set T;.hg.snd .hg.set()!()]]}
