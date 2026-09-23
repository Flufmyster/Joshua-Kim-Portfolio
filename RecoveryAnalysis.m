 %% Drift Analysis
% Housekeeping
clc
clear
close all

 %% Notes
% Ideal Terminal Velocties
% Drogue - 18 - 30 m/s
% Main - 4.5 - 7.5 m/s


 %% Rocket Specifications
launchAltitude = 210; % altitude ASL of launch site
apogee = 6700 + launchAltitude; % meters
mass = 3.3; % Mass of Rocket - (kg)
% Main flight mass: 3.3
% Test flight mass: 2.5
% Parachute Test Mass: .545

mainDeployment = 300 + launchAltitude; % Main deployment (m)


 %% Atmospheric Specifications
g = 9.81;
temp = 15 + 273.15; % In Celsius converted to kelvin
rho_0 = 1.225; % Assumes near Sea level conditions
L = 0.0065; % Temperature lapse rate (K/m)
dh = 0.1; % Altitude Resolution

altitudeD = mainDeployment:dh:apogee;
altitudeM = launchAltitude:dh:mainDeployment;

rhoD = rho_0 * (1 - (L .* altitudeD)./temp).^4.2559;
rhoM = rho_0 * (1 - (L .* altitudeM)./temp).^4.2559;


 %% Parachute Specifications

coDragM = 1.25; % Approximate Parachute Coefficient of Drag
coDragD = 0.75; % Approximate Parachute Coefficient of Drag
outerDiaM = 108 / 100; % Parachute Diameter - (cm)
innerDiaM = 11 / 100; % Diameter of Spill Hole - (cm)
outerDiaD = 45.72 / 100; % Parachute Diameter - (cm)
innerDiaD = 0 / 100; % Diameter of Spill Hole - (cm)

areaOctM = 0.828 * (outerDiaM^2 - innerDiaM^2); % Area of parachute - Octagon
areaHexM = 0.866 * (outerDiaM^2 - innerDiaM^2); % Area of parachute - Hexagon
areaCircleM = pi * ( (outerDiaM/2)^2 - (innerDiaM/2)^2 ); % Area of parachute - Circle 
% Octagon & Hexagon measured Across Flats

areaOctD = 0.828 * (outerDiaD^2 - innerDiaD^2); % Area of parachute - Octagon
areaHexD = 0.866 * (outerDiaD^2 - innerDiaD^2); % Area of parachute - Hexagon
areaCircleD = pi * ( (outerDiaD/2)^2 - (innerDiaD/2)^2 ); % Area of parachute - Circle 
% Octagon & Hexagon measured Across Flats



 %% Drag & Terminal Velocity Calculations

subCoefficientM = areaCircleM * coDragM; % Choose circle / oct / hex
subCoefficientD = areaOctD * coDragD; % Choose circle / oct / hex

terminalVelocityM = sqrt((2 .* mass .* g) ./ (rhoM .* ((subCoefficientM) + (subCoefficientD)))); % Terminal Velocity of total system
terminalVelocityD = sqrt((2 .* mass .* g) ./ (rhoD .* subCoefficientD)); % Terminal Velocity just under Drogue
descentTimeD = trapz(altitudeD, 1 ./ terminalVelocityD);
descentTimeM = trapz(altitudeM, 1 ./ terminalVelocityM);
descentTime = descentTimeD + descentTimeM;


 %% Drift Analysis for Monte Carlo Simulations
numSim = 100000; % number of sims for Monte Carlo sim

windDirectionCompass = 180; % degrees, where wind is from, eg. 0 deg = North
windSpeed = 3; % m/s
windSpeedUncertainty = 1.5; % m/s
windDirection = mod(270 - windDirectionCompass, 360); % degrees
windDirectionUncertainty = 20; % degrees

% Normally distributed wind conditions
windSpeedMC = windSpeed + windSpeedUncertainty .* randn(numSim, 1);
windDirectionMC = windDirection + windDirectionUncertainty .* randn(numSim, 1);

windSpeedMC(windSpeedMC < 0) = 0; % Negative values changed to 0

windDirectionRad = deg2rad(windDirectionMC); % Convert to Rad
driftDistance = windSpeedMC .* descentTime; % Total drift distance

driftX = driftDistance .* cos(windDirectionRad); % X and & coordinates for simulated Rocket Drift
driftY = driftDistance .* sin(windDirectionRad);

% Percentiles at 50, 68, 95, 99 of Drift Distance
drift50 = prctile(driftDistance, 50);
drift68 = prctile(driftDistance, 68);
drift95 = prctile(driftDistance, 95);
drift99 = prctile(driftDistance, 99);

% Percentile Ranges at 50, 68, 95, 99 of Drift Distance
index50 = driftDistance <= drift50;
index68 = driftDistance > drift50 & driftDistance <= drift68;
index95 = driftDistance > drift68 & driftDistance <= drift95;
index99 = driftDistance > drift95 & driftDistance <= drift99;
indexMax = driftDistance > drift99;

% Center of landing points
landingPoints = [driftX, driftY];
landingMean = mean(landingPoints);

% Covariance
landingCov = cov(landingPoints);

% Distance of each point from center
delta = landingPoints - landingMean;

mahalDistance = sum((delta / landingCov) .* delta, 2);

% 2D Percentile Distribution
p50 = prctile(mahalDistance, 50);
p68 = prctile(mahalDistance, 68);
p95 = prctile(mahalDistance, 95);
p99 = prctile(mahalDistance, 99);

% 2D Percentile Ranges
idx50 = mahalDistance <= p50;
idx68 = mahalDistance > p50 & mahalDistance <= p68;
idx95 = mahalDistance > p68 & mahalDistance <= p95;
idx99 = mahalDistance > p95 & mahalDistance <= p99;
idxMax = mahalDistance > p99;

 %% Coefficient of Drag Calculator
experimentalTerminalVelocity = 3.53; % Average of three trials
experimentalDragCoefficient = (2 * mass * 9.81) / (rho_0 * experimentalTerminalVelocity^2 * areaCircleM);

 %% Print Statements

fprintf('Experimental Coefficient of Drag %.4f\n', experimentalDragCoefficient)
fprintf('Terminal Velocity is %.2f m/s \nTerminal Velocity under Drogue is %.2f m/s \nDescent Time is %.2f s\n', terminalVelocityM(1),terminalVelocityD(1), descentTime)
fprintf('Simulated Landing Centered Around (%.2f, %.2f) meters\n', landingMean)
fprintf('50%% Likelihood to land within %.2f meters \n32%% Likelihood to land within %.2f meters \n5%% Likelihood to land within %.2f meters \n1%% Likelihood to land within %.2f meters', max(drift50), max(drift68), max(drift95), max(drift99))

 %% Plotting

% Plot for Descent Speed
figure
plot([altitudeM altitudeD], [terminalVelocityM terminalVelocityD])
grid minor
title('Altitude vs Descent Speed')
xlabel('Altitude ASL (m)')
ylabel('Descent Speed (m/s)')

% Plot for Drift Analysis
figure
hold on
scatter(driftX(idx50), driftY(idx50), 'g')
scatter(driftX(idx68), driftY(idx68), 'b')
scatter(driftX(idx95), driftY(idx95), 'r')
scatter(driftX(idx99), driftY(idx99), 'm')
scatter(driftX(idxMax), driftY(idxMax), 'k')

grid minor
axis equal
title('Monte Carlo Simulation of Recovery Drift')
xlabel('West to East Distance from Launch Pad (m)')
ylabel('South to North Distance from Launch Pad (m)')
legend('0-50%', '50-68%', '68-95%', '95-99%', '>99%')
