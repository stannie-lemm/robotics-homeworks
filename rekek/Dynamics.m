%% Dynamics Model

% m1=10 kg, m2 = 5 kg,
% m3 = 5 kg, m3 = 1 kg, I1 = 10 kg*m2
% , I2 = 4 kg*m2
% , I3 = 4 kg*m2
% , I4 = 1 kg*m2
syms q1 q2 q3 q4
m1 = 10; m2 = 5; m3 = 5; m4 = 1; I1 = 10; I2 = 4; I3 = 4; I4 = 1;
l1 = 1; l2 = 2; l3 = 2; l4 = 0.5;
g = transpose([0 0 9.81]);
% T_i - задает центры масс, из них высчитываются якобианы
T1 = RT.Tz(l1/2);
T2 = T1*RT.Ty(l2/2);
T3 = T2*RT.Ty(l3/2);
T4 = T3*RT.Tz(-l4/2);

% матрицы инерции для линков - все вращаются только вокруг осей Z
I_1 = eye(3)*transpose([0 0 I1]);
I_2 = eye(3)*transpose([0 0 I2]);
I_3 = eye(3)*transpose([0 0 I3]);
I_4 = eye(3)*transpose([0 0 I4]);

% L = K + P: 
% К - кинетическая энергия всех линков скорость линейная и угловая центров масс
% скорости достаем из якобиана
% Потенциальная - высоты центров масс отн-но нуля
% Разделяем кинетическую и потенциальную  - дифференцируем кинетическую по
% скорости, потенциальную по координате
% Генерализованная сила - сумма B(q)*q" и n(q, q')
% 



function fk = FK(q1, q2, q3, q4)
l1 = 1/2; % все центры масс - центры линков
l2 = 2/2;
l3 = 2/2;
l4 = 0.5/2;

T = RT.Tz(l1)*RT.Rz(q1)*RT.Ty(l2)*RT.Rz(q2)*RT.Ty(l3)*RT.Tz(q3)*RT.Rz(q4)*RT.Tz(-l4);
fk = T;

end

function jq = JQ(q1, q2, q3, q4)
T = FK(q1, q2, q3, q4)

%% Jacobian - Numerical Method
T0 = T;
T0 = inv(T0(1:3,1:3));
T0=[T0,zeros(3,1);0 0 0 1];

Td = RT.Tz(l1)*RT.Rdz(q1)*RT.Ty(l2)*RT.Rz(q2)*RT.Ty(l3)*RT.Tz(q3)*RT.Rz(q4)*RT.Tz(-l4)*T0; J1 = RT.Jcol(Td);
% J1 = simplify(J1);
Td = RT.Tz(l1)*RT.Rz(q1)*RT.Ty(l2)*RT.Rdz(q2)*RT.Ty(l3)*RT.Tz(q3)*RT.Rz(q4)*RT.Tz(-l4)*T0; J2 = RT.Jcol(Td);
% J2 = simplify(J2);
Td = RT.Tz(l1)*RT.Rz(q1)*RT.Ty(l2)*RT.Rz(q2)*RT.Ty(l3)*RT.Tdz(q3)*RT.Rz(q4)*RT.Tz(-l4)*T0; J3 = RT.Jcol(Td);
% J3 = simplify(J3);
Td = RT.Tz(l1)*RT.Rz(q1)*RT.Ty(l2)*RT.Rz(q2)*RT.Ty(l3)*RT.Tz(q3)*RT.Rdz(q4)*RT.Tz(-l4)*T0; J4 = RT.Jcol(Td);
% J4 = simplify(J4);


jq = [J1, J2, J3, J4];
end