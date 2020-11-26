%% ZXZ
function zxz = ZXZ(R)

% singular case 1
if R(3, 3) == 1
    q46 = atan2(-R(1, 2), R(2, 2));
    q4 = q46;
    q5_1 = 0;
    q5_2 = 2*pi;
    q6 = 0;
    
    zxz = [q4, q5_1, q6; q4, q5_2, q6];

% singular case 2
elseif R(3, 3) == -1
    q46 = atan2(R(1, 2), -R(2, 2));
    q4 = q46;
    q5_1 = -pi;
    q5_2 = pi;
    q6 = 0;
    
    zxz = [q4, q5_1, q6; q4, q5_2, q6];
    
% cos q5 positive
else
    
    q5_1 = atan2(sqrt(R(3, 1)^2 + R(3, 2)^2), R(3, 3));
    q5_2 = atan2(-sqrt(R(3, 1)^2 + R(3, 2)^2), R(3, 3));
    
    % sin q5 >= 0
    q4_1 = atan2(R(1, 3), -R(2, 3));
    q6_1 = atan2(R(3, 1), R(3, 2));
    
    % sin q5 < 0
    q4_2 = atan2(-R(1, 3), -R(2, 3));
    q6_2 = atan2(-R(3, 1), -R(3, 2));
    
    zxz = [q4_1, q5_1, q6_1; q4_2, q5_2, q6_2];
    
end
end