// hypergrid utilities

.hg.nnd:{$[99=type x;.z.s each(key[x]except`)#x;x]}
.hg.sub:{flip each(1#x;.hg.idx[1_x]. y`start`end)}
.hg.idx:{$[0 0W~y,z;x;y>=count x;0#x;.hg.gsy((1+z-y)&count r)#r:y _ x]}
.hg.gsy:{update g_:{$[11h=type x;x;`$string x]}g_ from x}
.hg.ret:{if[99h=type x;:x,.hg.obj[]]}
.hg.sym:{$[()~x;0#`;(t:abs type x)in 0 99h;.z.s each x;10=t;`$x;x]}
.hg.inf:{k:exec c!t$1%0 from meta x where t in"ijf";![x;();0b;key[k]!({@[x;where x in y,neg y;:;first 0#x]};;)'[key k;get k]]}
.hg.opt:{$[0=count x 0;z;not`columns in key z;z;not x[0;0]in key z`columns;z;@[z;`columns;:;y!count[y]#z[`columns]x[0;0]]]}
.hg.var:{x in key[`.],raze{` sv'(`,x),/:1_key` sv`,x}each key`}

/ object -> hypergrid
.hg.obj:{(!). flip((`hypertree      ;.hg.sub[get[Z]K]R);
                   (`visible        ;C);
                   (`groups 		;G);
                   (`groupable      ;H);
                   (`invisible      ;I);
                   (`qtypes 		;exec c!t from meta Z);
                   (`sorts 		;`cols`sorts!reverse each(key S;get S));
                   (`rows 		;R);
                   (`count 		;count get Z);
                   (`table 		;first T);
                   (`properties     ;.hg.nnd .hg.opt[W;C]O);
                   (`icons          ;.hg.cic[Q;G]W);
                   (`ungrouped      ;.hg.var T);
                   (`reorderable    ;0=count W 0);
                   (`cell           ;count[G]>2+count W 1);
                   (`buttons        ;.hg.buttons[G;U]W);
                   (`execute        ;not(::)~D);
                   (`message        ;.hg.state[G;X;Y;S]W))}

/ buttons
.hg.buttons:{[g;u;w]
 e:(0<count g)&0=count w 0;s:2<=count g;p:$[null u;();enlist(`Play`Pause u;1b)];
 (!). flip((`Reset;1b);(`Expand;e);(`Collapse;e);(`Back;s);(`Forth;s);(`Swap;s);(`Up;s);(`Down;s)),p}

/ icons
.hg.cic:{$[0=count y;()!();[w:0=count z 0;n:count k:key[x]except `;((1#`g_)!1#`u` w),$[w;k!n#`d;(`,k)!`,n#`d` count[y]=2+count z 1]]]}

/ version
.hg.Version:"1.0(beta)"

/ state message
.hg.state:{[g;x;y;s;w]
 r:`Version`Table`Rows`Index!(.hg.Version;string T;string N;"/"sv string get R);
 if[count[w 0]&0=count w 1    ;r[`X]:x;r[`Y]:y;r[`Z]:string w[0;0]];
 if[count w 1                 ;r[`X]:x;r[`Y]:string y;r[`Z]:string w[0;0];r[`Where]:","sv({y,"=",z 0}.)each string w 1];
 if[(0=count w 0)&count g     ;r[`Groups]:","sv string g];
 if[count s                   ;r[`Sorts]:","sv string[key s]{$[x~"g_";"Hierarchy";x],"[",y,"]"}'string get s];
 r}
