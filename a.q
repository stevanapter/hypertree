// auxilliary functions

.af.tree:{[g]
 `P set(.ht.opento[T;g]last g;.ht.paths 1);
 ![.ht.cons[();T;P;A;S;(g;F);1b]W;();0b;.ht.C]}

.af.trees:{
 p:{$[x=1;y;raze .z.s[x-1;y]{x,/:y except x}\:y]};
 g!.af.tree each g:p[count G]G}

.af.set:{[p]{(`$x,"/",string` sv y)set z}[string p]'[key d;get d:.af.trees`];}
.af.get:{[p](` vs'k)!`$(string[p],"/"),/:string k:key p}

.af.gen:{[n;d;e]flip(n?'d),e@\:n}

\

t:.af.gen[10;`A`B`C!(`a`b`c;`d`e;`f`g`h`i)]`f`g!2#{x?100.}
 
