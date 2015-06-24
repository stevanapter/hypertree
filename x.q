// globals

A:()!() 						/ aggregations
B:()
C::.ht.visible[Q;G]I 			/ visible columns
D:()
E:()
F:0#` 							/ aggregated columns
G:0#` 							/ grouping columns
H::.ht.groupable T 				/ groupable columns
I::.ht.invisible[W;T;A;Q;F]G 	/ invisible columns
J:0b 							/ filter infinities?
K:(::) 							/ sort vector
L:1b 							/ show leaves?
M:()
N::count get T 					/ row count
O.:(::) 						/ properties
P:.ht.P 						/ path	
Q::.ht.qtype Z 					/ types
R:`start`end!0 60 				/ rows
S:()!() 						/ sort
T:`t 							/ input table
U:0b 							/ show underlying records?
V:1b 							/ update?
W:(();();()) 					/ pivot state
X:()
Y:()
Z:`z 							/ output table
