%% RRR 3D ARM
clc
syms q1 q2 q3 real

global l1 l2 l3
l1 = 1; l2 = 1; l3 = 1;

%% Forward kinematics

T = RTmatrices.Tz(l1)*RTmatrices.Rz(q1)*RTmatrices.Rx(q2)*RTmatrices.Tx(l2)*RTmatrices.Rx(q3)*RTmatrices.Tx(l3)
T = simplify(T)

%% Numerical derivatives
T0 = T;
T0 = inv(T0(1:3,1:3));
T0=[T0,zeros(3,1);0 0 0 1];

Td = RTmatrices.Tz(l1)*RTmatrices.Rzd(q1)*RTmatrices.Rx(q2)*RTmatrices.Tx(l2)*RTmatrices.Rx(q3)*RTmatrices.Tx(l3)*T0; J1 = RTmatrices.Jcol(Td);
Td = RTmatrices.Tz(l1)*RTmatrices.Rz(q1)*RTmatrices.Rxd(q2)*RTmatrices.Tx(l2)*RTmatrices.Rx(q3)*RTmatrices.Tx(l3)*T0; J2 = RTmatrices.Jcol(Td);
Td = RTmatrices.Tz(l1)*RTmatrices.Rz(q1)*RTmatrices.Rx(q2)*RTmatrices.Tx(l2)*RTmatrices.Rxd(q3)*RTmatrices.Tx(l3)*T0; J3 = RTmatrices.Jcol(Td);

Jq1 = [simplify(J1), simplify(J2), simplify(J3)]

%% Skew theory
 

% Get Z from tf



% Full Jacobian

