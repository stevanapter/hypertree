// hypertree server

\p 12346

\l t.q
\l x.q
\l a.q
\l d.q
\l e.q
\l i.q
\l l.q

/ connect to client
.js.K:0Ni
.z.po:{[w].js.K:w;neg[.js.K](`.js.ini;.js.obj`);}
.z.pc:{[w].js.K:0Ni}
.z.ps:{t:.z.z;.js.snd .js.exe x;.js.log[t]x}

/ utilities
.js.snd:{neg[.js.K](`.js.exe;x)}
.js.obj:{{x!get each x}Z,`$'"ABCDEFGHIJKLMNOPQRSTUVWXYZ"}
.js.ret:{(x;.js.obj[])}
.js.upd:{if[U;if[not null .js.K;Z set();P[1]:.ht.P 1;.js.snd .js.set()!()]]}

/ define Z
.js.set();
