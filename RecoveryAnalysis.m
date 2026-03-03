%% Drift Analysis
% Housekeeping
clc
clear
close all

% Given Values
g = 9.81;
rho = 1.228; % Assumes near Sea level conditions

% Windspeed and Conditions
lowSpeed = 2.23; % m/s
highSpeed = 3.57; % m/s
averageSpeed = (lowSpeed + highSpeed) / 2; % m/s
apogee = 683; % meters
coDrag = .750; % Approximate Parachute Coefficient of Drag
outerDia = 147 / 100; % Parachute Diameter - (cm)
innerDia = 0 / 100; % Diameter of Spill Hole - (cm)
mass = 0.8; % Mass of Rocket - (kg)


area = 0.828 * (outerDia^2 - innerDia^2); % Area of parachute - Octagon

terminalVelocity = sqrt((2 * mass * g) / (rho * area * coDrag)); % Terminal Velocity
descentTime = apogee / terminalVelocity; % Time from deployment to ground
distanceHigh = descentTime * highSpeed; % Max distance traveled
distanceLow = descentTime * lowSpeed; % Min distance traveled
distanceAvg = descentTime * averageSpeed; % Average distance traveled

fprintf('Terminal Velocity is %.2f m/s\nDescent Time is %.2f s\n', terminalVelocity,descentTime)
fprintf('Distance Traveled %.2f to %.2f meters\n', distanceLow, distanceHigh)
fprintf('Centered around %.2f meters\n', distanceAvg)

%figure
%grid on
%distance = windSpeed .* descentTime;
%plot(windSpeed, distance)