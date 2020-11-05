%% FK

function fk = FK(q1, q2, q3, q4, q5, q6)
l0 = 670; l1 = 312; l2 = 1075; l3 = 225; l4 = 1280; l5 = 215;

T_base = RTmatrices.Tz(l0);
T123 = RTmatrices.Rz(q1)*RTmatrices.Tx(l1)*RTmatrices.Ry(-q2)*RTmatrices.Tx(l2)*RTmatrices.Ry(q3)*RTmatrices.Tz(l3)*RTmatrices.Tx(l4);
T456 = RTmatrices.Rx(q4)*RTmatrices.Ry(q5)*RTmatrices.Rx(q6);
T_tool = RTmatrices.Tx(l5);
fk = T_base*T123*T456*T_tool;
end