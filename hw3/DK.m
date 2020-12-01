%% FANUC R-2000iC/165F

syms q1 q2 q3 q4 q5 q6 real
d1 = 670;
d2 = 312;
d3 = 1075;
d4 = 225;
d5 = 1280;
d6 = 215;

%% Skew theory

% Origins
T0 = eye(4);
T1 = RT.Rz(q1)*RT.Tz(d1)*RT.Tx(d2);
T1 = simplify(T1);
T2 = T1*RT.Ry(-q2)*RT.Tx(d3);
T2 = simplify(T2);
T3 = T2*RT.Ry(q3)*RT.Tz(d4)*RT.Tx(d5);
T3 = simplify(T3);
T4 = T3*RT.Rx(q4);
T4 = simplify(T4);
T5 = T4*RT.Ry(q5);
T5 = simplify(T5);
T6 = T5*RT.Rx(q6)*RT.Tx(d6);
T6 = simplify(T6);

O0 = T0(1:3,4);
O1 = T1(1:3,4);
O2 = T2(1:3,4);
O3 = T3(1:3,4);
O4 = O3;
O5 = O3;
O6 = T6(1:3,4);

% Rotation axes
Z0 = T0(1:3,3);
Y1 = T1(1:3,2);
Y2 = T2(1:3,2);
X3 = T3(1:3,1);
Y4 = T4(1:3,2);
X5 = T5(1:3,1);

% J columns
J1 = [cross(Z0,O6-O0);Z0];
J2 = [cross(Y1,O6-O1);Y1];
J3 = [cross(Y2,O6-O2);Y2];
J4 = [cross(X3,O6-O3);X3];
J5 = [cross(Y4,O6-O4);Y4];
J6 = [cross(X5,O6-O5);X5];

Jq1 = [simplify(J1), simplify(J2), simplify(J3), simplify(J4), simplify(J5), simplify(J6)];
Jq1 = simplify(Jq1);
disp('Skew Theory');
disp(Jq1);

%% Numerical method

% FK
T = FK(q1, q2, q3, q4, q5, q6);
T = simplify(T);

% Inverse transpose
T = inv(T(1:3,1:3));
T = simplify([T,zeros(3,1);0 0 0 1]);

% J columns
Td = RT.Rzd(q1)*RT.Tz(d1)*RT.Tx(d2)* RT.Ry(-q2)*RT.Tx(d3)* RT.Ry(q3)*RT.Tz(d4)*RT.Tx(d5)* RT.Rx(q4)* RT.Ry(q5)* RT.Rx(q6)*RT.Tx(d6)*T;
Td = simplify(Td);
J1 = RT.Jcol(Td);
Td =  RT.Rz(q1)*RT.Tz(d1)*RT.Tx(d2)*RT.Ryd(-q2)*RT.Tx(d3)* RT.Ry(q3)*RT.Tz(d4)*RT.Tx(d5)* RT.Rx(q4)* RT.Ry(q5)* RT.Rx(q6)*RT.Tx(d6)*T;
Td = simplify(Td);
J2 = RT.Jcol(Td);
Td =  RT.Rz(q1)*RT.Tz(d1)*RT.Tx(d2)* RT.Ry(-q2)*RT.Tx(d3)*RT.Ryd(q3)*RT.Tz(d4)*RT.Tx(d5)* RT.Rx(q4)* RT.Ry(q5)* RT.Rx(q6)*RT.Tx(d6)*T;
Td = simplify(Td);
J3 = RT.Jcol(Td);
Td =  RT.Rz(q1)*RT.Tz(d1)*RT.Tx(d2)* RT.Ry(-q2)*RT.Tx(d3)* RT.Ry(q3)*RT.Tz(d4)*RT.Tx(d5)*RT.Rxd(q4)* RT.Ry(q5)* RT.Rx(q6)*RT.Tx(d6)*T;
Td = simplify(Td);
J4 = RT.Jcol(Td);
Td =  RT.Rz(q1)*RT.Tz(d1)*RT.Tx(d2)* RT.Ry(-q2)*RT.Tx(d3)* RT.Ry(q3)*RT.Tz(d4)*RT.Tx(d5)* RT.Rx(q4)*RT.Ryd(q5)* RT.Rx(q6)*RT.Tx(d6)*T;
Td = simplify(Td);
J5 = RT.Jcol(Td);
Td =  RT.Rz(q1)*RT.Tz(d1)*RT.Tx(d2)* RT.Ry(-q2)*RT.Tx(d3)* RT.Ry(q3)*RT.Tz(d4)*RT.Tx(d5)* RT.Rx(q4)* RT.Ry(q5)*RT.Rxd(q6)*RT.Tx(d6)*T;
Td = simplify(Td);
J6 = RT.Jcol(Td);

Jq2 = [simplify(J1), simplify(J2), simplify(J3), simplify(J4), simplify(J5), simplify(J6)];
Jq2 = simplify(Jq2);
disp('Numerical Method');
disp(Jq2);
%% Comparing two solutions

disp('Jskew - Jnumerical');
disp(simplify(Jq1 - Jq2));


%% Kinematic Singularity analysis

% singular_values = svd(vpa(Jq1))
det0 = simplify(det(Jq1))
J11 = Jq1(1:3,1:3);
det1 = simplify(det(J11)) % arm singularities
J22 = Jq2(4:6,4:6);
det2 = simplify(det(J22)) % wrist singularities

sol1 = solve(det2 == 0)
disp(sol1)
sol2 = solve(det1 == 0, q2, q3, q4, q5)
disp(sol2)
