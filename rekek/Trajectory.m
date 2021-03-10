%%Trajectory

% Determine trapezoidal trajectory for the robot moves through PTP motion.
% a. q1 = (0, 0, 0, 0), q2 = (0.2, 1, 0.5, 0)
% b. Controller command interpretation frequency – f = 100 Hz
% c. Maximum joint velocity – 1 rad/s and 0.1 m/s
% d. Maximum joint acceleration – 10 rad/s2 and 5 m/s
% e. Joint velocity and position plots
% My idea is to move all the joints consiquently: q1, then q2, then q3

q1 = [0 0 0 0];
qf = [0.2 1 0.5 0];

freq = 100; m_vel = 0.1; m_om = 1; m_acc = 5; m_eps = 10;

% Determine trapezoidal profiles for each joint
trp_q1 = TRPZ_ANG(q1(1), qf(1), m_om, m_eps, freq)% считает неправильно
trp_q2 = TRPZ_ANG(q1(2), qf(2), m_om, m_eps, freq) % считает правильно, почему?
trp_q3 = TRPZ_POS(q1(3), qf(3), m_vel, m_acc, freq)% считает неправильно
trp_q4 = TRPZ_ANG(q1(4), qf(4), m_om, m_eps, freq) 


% Create timelines for each joint
t1_1 = (trp_q1(1):1/freq:trp_q1(2)); t1_2 = (trp_q1(2):1/freq:trp_q1(3)); t1_3 = (trp_q1(3):1/freq:trp_q1(4));
tl_q1 = cat(2, t1_1, t1_2); %tl_q1 = cat(2, tl_q1, t1_3);
t2_1 = (trp_q2(1):1/freq:trp_q2(2)); t2_2 = (trp_q2(2):1/freq:trp_q2(3)); t2_3 = (trp_q2(3):1/freq:trp_q2(4));
tl_q2 = cat(2, t2_1, t2_2); tl_q2 = cat(2, tl_q2, t2_3);
t3_1 = (trp_q3(1):1/freq:trp_q3(2)); t3_2 = (trp_q3(2):1/freq:trp_q3(3)); t3_3 = (trp_q3(3):1/freq:trp_q3(4));
tl_q3 = cat(2, t3_1, t3_2); tl_q3 = cat(2, tl_q3, t3_3);
t4_1 = (trp_q4(1):1/freq:trp_q4(2)); t4_2 = (trp_q4(2):1/freq:trp_q4(3)); t4_3 = (trp_q4(3):1/freq:trp_q4(4));
tl_q4 = cat(2, t4_1, t4_2); tl_q4 = cat(2, tl_q4, t4_3);


% Get all positions and velocities of joints
%j1: accelerating
dq1_q1 = zeros(size(t1_1)); q1_q1 = zeros(size(t1_1)); pos1_q1 = zeros(size(t1_1)); 
for i = 1:1:size(t1_1)
    dq1_q1(i) = trp_q1(5)*t1_1(i); 
    q1_q1(i) = trp_q1(5)*(i/freq)^2/2; % pos1_q1(i) = FK(q1_q1(i), 0, 0, 0);
end
dq2_q1 = zeros(size(t1_2)) + trp_q1(6); q2_q1 = zeros(size(t1_2)) + q1_q1(size(q1_q1)); pos2_q1 = zeros(size(t1_2));
for i = 1:1:size(t1_2)
%     dq2_q1(i) = trp_q1(6); 
    q2_q1(i) = q2_q1(i) + trp_q1(6)*(i/freq);% pos2_q1(i) = FK(q2_q1(i), 0, 0, 0);
end
% %decelerating
% dq3_q1 = zeros(size(t3_1)) + trp_q1(6);
% q3_q1 = zeros(size(t3_1));
% 
% pos3_q1 = zeros(size(t3_1));
% q2_q1(size(t1_2))
% for i = 1:1:size(t3_1)
%     dq3_q1(i) = dq3_q1(i) - trp_q1(5)*(1/freq)*i; 
%     q3_q1(i) = q3_q1(i) - trp_q1(5)*(i/freq)^2/2 + trp_q1(6)*(i/freq)  + q2_q1(size(t1_2)); %pos3_q1(i) = FK(q3_q1(i), 0, 0, 0);
% end

om1 = cat(2, dq1_q1, dq2_q1);% om1 = cat(2, om1, dq3_q1);
pos1 = cat(2, q1_q1, q2_q1); %pos1 = cat(2, pos1, q3_q1);

figure(1)
hold on
plot(tl_q1, pos1, 'r');
plot(tl_q1, om1, 'b');
hold off

%% functions defenition

function fk = FK(q1, q2, q3, q4)
l1 = 1;
l2 = 2;
l3 = 2;
l4 = 0.5;

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

% generates trapezioidal profile for known desired angles of joints
function trpz_profile_angle = TRPZ_ANG(q0, qf, dq_max, ddq_max, freq)
T = 1/freq;
s = ceil((qf - q0)*(qf - q0)*freq/dq_max);
n = ceil((qf - q0)*(qf - q0)*freq*freq/(ddq_max*s));
% we search for largest possible s - s/freq is time we move with max
% possible velocity
while n > s
    s = s + 1;
    n = ceil((qf - q0)*(qf - q0)*freq*freq/(ddq_max*s));
end

k = s - n;
t0 = 0;
t1 = T*n;
t2 = T*(n + k);
tf = T*(2*n + k);
e = (qf - q0)*(qf - q0)*freq*freq/(s*n);
om = e*n/freq;
trpz_profile_angle = [t0, t1, t2, tf, e, om];
end


% generates trapezioidal profile for known desired decartian coordinate of joints
function trpz_profile_pos = TRPZ_POS(p0, pf, v_max, acc_max, freq)
T = 1/freq;
s = ceil((pf - p0)*(pf - p0)*freq/v_max);
n = ceil((pf - p0)*(pf - p0)*freq*freq/(acc_max*s));

while n > s
    s = s + 1;
    n = ceil((pf - p0)*(pf - p0)*freq*freq/(acc_max*s));
end

k = s - n;
t0 = 0;
t1 = T*n;
t2 = T*(n + k);
tf = T*(2*n + k);
acc = (pf - p0)*(pf - p0)*freq*freq/(s*n);
v = acc*n/freq;
trpz_profile_pos = [t0, t1, t2, tf, acc, v];
end