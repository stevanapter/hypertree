// js utilities

.js.nnd:{$[99=type x;.z.s each(key[x]except`)#x;x]}
.js.sub:{i:(::;.js.inf)y;flip each(i 1#x;.js.idx[i 1_x]. z`start`end)}
.js.idx:{$[0 0W~y,z;x;y>=count x;0#x;((1+z-y)&count r)#r:y _ x]}
.js.ret:{x,.js.obj[]}
.js.sym:{$[()~x;0#`;(t:abs type x)in 0 99h;.z.s each x;10=t;`$x;x]}
.js.inf:{k:exec c!t$1%0 from meta x where t in"ijf";![x;();0b;key[k]!({@[x;where x in y,neg y;:;first 0#x]};;)'[key k;get k]]}
.js.opt:{$[0=count x 0;z;not`columns in key z;z;not x[0;0]in key z`columns;z;@[z;`columns;:;y!count[y]#z[`columns]x[0;0]]]}

/ object -> js
.js.obj:{(!). flip((`hypertree      ;.js.sub[get[Z]K;J]R);
                   (`visible        ;C);
                   (`groups 		;G);
                   (`groupable      ;H);
                   (`invisible      ;I);
                   (`qtypes 		;Q);
                   (`sorts 		;`cols`sorts!reverse each(key S;get S));
                   (`rows 		;R);
                   (`count 		;count get Z);
                   (`table 		;first T);
                   (`properties     ;.js.nnd .js.opt[W;C]O);
                   (`icons          ;.js.cic[Q;G]W);
                   (`ungrouped      ;V);
                   (`reorderable    ;0=count W 0);
                   (`cell           ;count[G]>3+count W 1);
                   (`buttons        ;.js.buttons[G;U]W);
                   (`message        ;.js.msg[G;X;Y;S]W))}

/ buttons
.js.buttons:{[g;u;w]
 e:(0<count g)&0=count w 0;s:2<=count g;
 (!). flip((`reset;1b);(`expand;e);(`collapse;e);(`back;s);(`forth;s);(`swap;s);(`up;s);(`down;s);(`pause;u))}

/ icons
.js.cic:{$[0=count y;()!();[w:0=count z 0;n:count k:key[x]except `;((1#`g_)!1#`u` w),$[w;k!n#`d;(`,k)!`,n#`d` count[y]=2+count z 1]]]}

/ state -> message
.js.msg:{[g;x;y;s;w]
 r:`Table`Rows`Index!(string T;string N;"/"sv string get R);
 if[(0=count w 0)&count g     ;r[`Groups]:","sv string g];
 if[count s                   ;r[`Sorts]:","sv string[key s]{$[x~"g_";"Hierarchy";x],"[",y,"]"}'string get s];
 if[count w 0                 ;r[`Pivot]:string w[0;0];r[`Y]:y;if[not count w 1;r[`X]:x]];
 if[count w 1                 ;r[`X]:x;r[`Where]:","sv({y,"=",z 0}.)each string w 1];
 r}


