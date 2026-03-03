%% Calculation For Shock Cord Mount
% Housekeeping
clc
clear
close all

%% Shock Cord Calculations
mass = 2.1; % Rocket mass (kg)
v = 15; % Velocity (m/s)
s = 0.3; % Stopping distance ------ How tf do i estimate this?????? note: not elongation of kevlar (too small)


snatchLoad = (mass * v^2) / s;

%% Assuming Standard Geometry

zTensile = 29.2; % MPa
% 29.2 MPa -- PLA+
% 29.0 MPa -- PETG-CF
% 34.0 MPa -- PC
% 57.0 MPa -- PPA-CF

outerDia = 75.75; % mm
innerDia = 63.75; % mm

area = pi * ( ( (outerDia / 1000) / 2)^2 - ( (innerDia / 1000) / 2)^2 ); % m^2

force = zTensile * 10^6 * area; % Newtons
force_Lbs = force * .2248; % Pounds

%% Shear Force
xyTensile = 58.0; % MPa
% 58.0 MPa -- PLA+
% 35.0 MPa -- PETG-CF
% 55.0 MPa -- PC
% 168.0 MPa -- PPA-CF

xyShear = .5 * xyTensile; % Medium estimate of 50%

areaS = ( (4 / 1000) * (12 / 1000) ); % mm

forceS = xyShear * 10^6 * areaS; % Newtons
forceS_Lbs = forceS * .2248; % Pounds


% Safety Factor
TensileFOS = force / snatchLoad;
ShearFOS = forceS / snatchLoad;

fprintf('Tensile Factor of Safety = %.2f\nShear Factor of Safety = %.2f\n', TensileFOS, ShearFOS)
fprintf('Tensile Force %.2f, Shear Force %.2f', force_Lbs, forceS_Lbs)