%% IK_mid
function ik_mid = IK_mid(T0)
l1 = 10; l2 = 5; l3 = 15; l6 = 1;

T_base = RTmatrices.Tz(l1);
T_tool = RTmatrices.Tz(l6);
T0 = inv(T_base)*T0*inv(T_tool);
x = T0_free(1, 4); y = T0_free(2, 4); z = T0_free(3, 4);

q3 = sqrt(x^2 + y^2 + z^2 - l2^2) - l3;

s_q2 = sqrt((x^2 + y^2 - l2^2)/(l3 + q3)^2);
c_q2 = z/(l3 + q3);
q2 = atan2(s_q2, c_q2);

a = (l3+q3)*s_q2; b = l2;
c_q1 = (b*x + a*y)/(- a^2 - b^2);
s_q1 = (b*y - a*x)/(- a^2 - b^2);
q1 = atan2(s_q1, c_q1);

T123 = RTmatrices.Rz(q1)*RTmatrices.Tx(-l2)*RTmatrices.Rx(q2)*RTmatrices.Tz(l3)*RTmatrices.Tz(q3);

T456 = inv(T123)*T0;

q456 = ZXZ(T456);

ik = [q1, q2, q3, q456(1, 1), q456(1, 2), q456(1, 3);
      q1, q2, q3, q456(2, 1), q456(2, 2), q456(2, 3)];
end