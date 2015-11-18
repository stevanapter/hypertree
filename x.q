// globals

A:()!()                                         / aggregations
B:()
C::.ht.visible[Q;G]I                            / visible columns
D:(::)                                          / input -> output
E:(::)                                          / event function
F:0#`                                           / aggregated columns
G:0#`                                           / grouping columns
H::.ht.groupable T                              / groupable columns
I::.ht.invisible[W;T;A;Q;F]G                    / invisible columns
J:([c:0#`]s:0#`;n:0#0;o:0#`)                    / rank table
K:(::)                                          / sort vector
L:1b                                            / show leaves?
M:(::)
N::count get T                                  / row count
O.:(::)                                         / properties
P:.ht.paths                                     / paths
Q::.ht.qtype Z                                  / types
R:`start`end!0 60                               / rows
S:()!()                                         / sort
T:`t                                            / input table
U:0N                                            / update?
V:(::)                                          / view
W:.ht.state                                     / pivot state
Y::G 0                                          / Y axis
X::$[count W 1;first 1_G except W[1;;1];G 1]    / X axis
Z:`z                                            / output table
