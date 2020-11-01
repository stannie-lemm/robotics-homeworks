%% tests

%% E2A
test1_e2a = RTmatrices.Rx(pi/2)*RTmatrices.Ry(pi/4)*RTmatrices.Rx(pi/2)
Q1 = radtodeg(E2A(test1_e2a))

test2_e2a = RTmatrices.Rx(pi/4)*RTmatrices.Ry(pi/2)*RTmatrices.Rx(pi)
Q2 = radtodeg(E2A(test2_e2a))

test3_e2a = RTmatrices.Rx(pi/4)*RTmatrices.Ry(pi)*RTmatrices.Rx(pi)
Q3 = radtodeg(E2A(test3_e2a))

test4_e2a = RTmatrices.Rx(pi/4)*RTmatrices.Ry(-pi)*RTmatrices.Rx(pi)
Q4 = radtodeg(E2A(test4_e2a))

test5_e2a = RTmatrices.Rx(pi/6)*RTmatrices.Ry(-pi/2)*RTmatrices.Rx(pi)
Q5 = radtodeg(E2A(test5_e2a))

%% FK - IK
q1 = pi/2; q2 = pi/2; q3 = pi/2; q4 = pi/2; q5 = pi/4; q6 = pi/2;
fk = FK(q1, q2, q3, q4, q5, q6)
ik = radtodeg(IK(fk))