%% FK_mid
function fk_mid = FK_mid(q1, q2, q3, q4, q5, q6)
l1 = 10; l2 = 5; l3 = 15; l6 = 1;

T_base = RTmatrices.Tz(l1);
T123 = RTmatrices.Rz(q1)*RTmatrices.Tx(-l2)*RTmatrices.Rx(q2)*RTmatrices.Tz(l3)*RTmatrices.Tz(q3);
T456 = RTmatrices.Rz(q4)*RTmatrices.Rx(q5)*RTmatrices.Rz(q6);
T_tool = RTmatrices.Tz(l6);
fk_mid = T_base*T123*T456*T_tool;
end