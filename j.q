// js utilities

.js.nnd:{$[99=type x;.z.s each(key[x]except`)#x;x]}
.js.sub:{i:(::;.js.inf)y;flip each(i 1#x;.js.idx[i 1_x]. z`start`end)}
.js.idx:{$[0 0W~y,z;x;y>=count x;0#x;((1+z-y)&count r)#r:y _ x]}
.js.cols:{(x where not x like"*_")except`}
.js.ret:{x,.js.obj[]}
.js.sym:{$[()~x;0#`;(t:abs type x)in 0 99h;.z.s each x;10=t;`$x;x]}
.js.inf:{k:exec c!t$1%0 from meta x where t in"ijf";![x;();0b;key[k]!({@[x;where x in y,neg y;:;first 0#x]};;)'[key k;get k]]}

/ object -> js
.js.obj:{(!). flip((`Z 		;.js.sub[get Z;J]R);
                   (`G 		;G);
                   (`H 		;H);
                   (`F 		;key[Q]except G,I);
                   (`I 		;I);
                   (`Q 		;Q);
                   (`S 		;`cols`sorts!(key S;get S));
                   (`R 		;R);
                   (`N 		;count get Z);
                   (`T 		;first T);
                   (`O 		;.js.nnd O);
                   (`C        ;()!());
                   (`U 		;not U);
                   (`V 		;V);
                   (`M 		;.js.msg[G]S))}

/ state -> message
.js.msg:{[g;s]
 r:()!();
 if[count g 	;r[`Groups]:","sv string g];
 if[count s 	;r[`Sorts]:","sv string[key s]{$[x~"g_";"Hierarchy";x],"[",y,"]"}'string get s];
 (asc key r)#r}

