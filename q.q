k)\d .j
k)J:(($`0`1)!$`false`true;s;{$[in["w";x 1 2]|~#x;"null";x]};s;j;{s@[x;&"."=8#x;:;"-"]};s)1 2 5 10 11 12 16h bin  

/ case-insensitive sort
.so.sort:{$[type[y]in 10 11h;x lower@;x]y}
.so.iasc:.so.sort iasc
.so.idesc:.so.sort idesc
.so.asc:{x .so.iasc x}
.so.desc:{x .so.desc x}
.so.xasc:{keys[y]xkey(0!y).so.iasc?[y;();();x]}
.so.xdesc:{keys[y]xkey(0!y).so.idesc?[y;();();x]}
