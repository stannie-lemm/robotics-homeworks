%% FK

function fk = FK(q1, q2, q3, q4, q5, q6)
l0 = 670; l1 = 312; l2 = 1075; l3 = 225; l4 = 1280; l5 = 215;

T_base = RT.Tz(l0);
T123 = RT.Rz(q1)*RT.Tx(l1)*RT.Ry(-q2)*RT.Tx(l2)*RT.Ry(q3)*RT.Tz(l3)*RT.Tx(l4);
T456 = RT.Rx(q4)*RT.Ry(q5)*RT.Rx(q6);
T_tool = RT.Tx(l5);
fk = T_base*T123*T456*T_tool;
end