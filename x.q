// globals

/ rollup expressions
A:()!()

/ universe of columns
E::distinct key[A],cols first T

/ visible columns (in order)
F::E except G,I

/ grouping columns
G:()

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
S:.ht.S

/ table
T:`

/ drill to underlying table = allow no groups
U:0b

/ pop up grouping/visibility panel
V:1b

/ allow X-axis drilldown (pivot)
X:1b

/ allow Y-axis drilldown (treetable)
Y:1b

/ treetable
Z:`