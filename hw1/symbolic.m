syms q1 q2 q3 q4 q5 q6 dq l0 l1 l2 l3 l4 l5 dl

Tbase = RTmatrices.Tz(l0);

T123 = RTmatrices.Rz(q1)*RTmatrices.Tx(l1)*RTmatrices.Ry(q2)*RTmatrices.Tx(l2)*RTmatrices.Ry(q3 + dq)*RTmatrices.Tx(dl)*RTmatrices.Ry(-dq)

T456 = RTmatrices.Rx(q4)*RTmatrices.Ry(q5)*RTmatrices.Rx(q6)

Ttool = RTmatrices.Tx(l5);

%% test symb
syms q_1 q_2 q_3 q_4 q_5 q_6

forward_kinematics = FK(q_1, q_2, q_3, q_4, q_5, q_6)
% inverse = IK(forward_kinematics)