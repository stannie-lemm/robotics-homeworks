function euler2angles = E2A(T456)
% for XYX euler

% singular case 1
if T456(1, 1) == 1
    q46 = atan2(T456(2, 3), T456(2, 2));
    q4 = q46;
    q5_1 = 0;
    q5_2 = 2*pi;
    q6 = 0;
    
    euler2angles = [q4, q5_1, q6; q4, q5_2, q6];

% singular case 2
elseif T456(1, 1) == -1
    q46 = atan2(T456(2, 3), T456(2, 2));
    q4 = q46;
    q5_1 = -pi;
    q5_2 = pi;
    q6 = 0;
    
    euler2angles = [q4, q5_1, q6; q4, q5_2, q6];
    
% cos q5 positive
else
    
    q5_1 = atan2(sqrt(T456(1, 2)^2 + T456(1, 3)^2), T456(1, 1));
    q5_2 = atan2(-sqrt(T456(1, 2)^2 + T456(1, 3)^2), T456(1, 1));
    
    % sin q5 >= 0
    q4_1 = atan2(T456(2, 1), -T456(3, 1));
    q6_1 = atan2(T456(1, 2), T456(1, 3));
    
    % sin q5 < 0
    q4_2 = atan2(-T456(2, 1), T456(3, 1));
    q6_2 = atan2(-T456(1, 2), -T456(1, 3));
    
    euler2angles = [q4_1, q5_1, q6_1; q4_2, q5_2, q6_2];
    
end

end
