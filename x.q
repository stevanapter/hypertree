// globals

/ rollup expressions
A:()!()

/ universe of columns
E::distinct key[A],cols first T

/ visible columns (in order)
F::E except G,I

/ grouping columns
G:0#`

/ groupable columns
H::exec c from meta first T where t in"bhijspmdznuvt"

/ invisible columns
I:()

/ json infinity check
J:0b

/ expand to leaves
L:1b

/ object properties
O.:(::)

/ instruction state = (current;prior)
P:.ht.P

/ q types of each column
Q::.ht.qtype get Z

/ rows -> gui
R:`start`end!0 60

/ sorts = cols!(..{`a`d`A`D}..)
S:()!()

/ table
T:`

/ drill to underlying table = allow no groups
U:0b

/ pivot state
V:()

/ pivot column
W:`

/ pivot x axis
X:`

/ pivot y axis
Y:`

/ treetable
Z:`