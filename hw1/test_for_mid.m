%% tests for mid

clc
%% ZXZ
test1 = RTmatrices.Rz(pi/2)*RTmatrices.Rx(pi/4)*RTmatrices.Rz(pi/2);
Q1 = radtodeg(ZXZ(test1));

test2 = RTmatrices.Rz(pi/4)*RTmatrices.Rx(pi/2)*RTmatrices.Rz(pi);
Q2 = radtodeg(ZXZ(test2));
% 
test3 = RTmatrices.Rz(pi/4)*RTmatrices.Rx(pi)*RTmatrices.Rz(pi);
Q3 = radtodeg(E2A(test3));
% 
test4 = RTmatrices.Rz(pi/4)*RTmatrices.Rx(-pi)*RTmatrices.Rz(pi);
Q4 = radtodeg(E2A(test4));
% 
test5 = RTmatrices.Rz(pi/6)*RTmatrices.Rx(-pi/2)*RTmatrices.Rz(pi);
Q5 = radtodeg(E2A(test5));

%% FK - IK
q1 = pi/2; q2 = 0; q3 = 0; q4 = 0; q5 = 0; q6 = 0;
fk = FK(q1, q2, q3, q4, q5, q6);
ik01 = IK(fk)

q1 = pi/2; q2 = pi/3; q3 = 0; q4 = 0; q5 = 0; q6 = 0;
fk = FK(q1, q2, q3, q4, q5, q6);
ik02 = IK(fk)

q1 = pi/2; q2 = pi/2; q3 = 3; q4 = pi/2; q5 = pi/2; q6 = pi/2;
fk = FK(q1, q2, q3, q4, q5, q6);
ik1 = IK(fk)
 
q1 = -pi/4; q2 = pi/6; q3 = 1; q4 = pi/2; q5 = -pi/4; q6 = -2*pi;
fk = FK(q1, q2, q3, q4, q5, q6);
ik3 = IK(fk)
 
q1 = pi/4; q2 = pi/6; q3 = 3; q4 = pi/2; q5 = -pi/4; q6 = -2*pi;
fk = FK(q1, q2, q3, q4, q5, q6);
ik4 = IK(fk)
 
q1 = pi/4; q2 = pi/6; q3 = pi/3; q4 = pi/2; q5 = -pi/4; q6 = -2*pi;
fk = FK(q1, q2, q3, q4, q5, q6);
ik5 = radtodeg(IK(fk)) 