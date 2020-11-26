syms q1 q2 q3 q4 q5 q6 dq l0 l1 l2 l3 l4 l5 dl a b c

Tbase = RTmatrices.Tz(l0);

T123 = RTmatrices.Rz(q1)*RTmatrices.Tx(l1)*RTmatrices.Ry(-q2)*RTmatrices.Tx(l2)*RTmatrices.Ry(q3)*RTmatrices.Tz(l3)*RTmatrices.Tx(l4);

T456 = RTmatrices.Rx(q4)*RTmatrices.Ry(q5)*RTmatrices.Rx(q6);

Ttool = RTmatrices.Tx(l5);

T_free = T123*T456;

inv(T123)*T_free;



rpy = RTmatrices.Rz(c)*RTmatrices.Ry(-pi/2)*RTmatrices.Rx(a);

zXz = RTmatrices.Rz(q4)*RTmatrices.Rx(q5)*RTmatrices.Rz(q6)

T123 = RTmatrices.Rz(q1)*RTmatrices.Tx(-l2)*RTmatrices.Rx(q2)*RTmatrices.Tz(l3)*RTmatrices.Tz(q3);
T456 = RTmatrices.Rz(q4)*RTmatrices.Rx(q5)*RTmatrices.Rz(q6);
T_free = T123*T456