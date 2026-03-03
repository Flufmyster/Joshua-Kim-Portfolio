%% Thread Failure Calculations
% Thread failure - Josh Kim - Buckeye Rocketry

% Housekeeping
clc
clear
close all

%% Initial Conditions
bolt = 2 / 1000; % Diameter in m
length = 5 / 1000; % Effective engaged length in m
pitch = 0.4 / 1000; % In m, Check ISO Standards, depends on Major diameter, and course vs fine

boltYield = 450 * 10^6; % Tensile Strength of Bolt (Pascals)
nutYield = 168 * 10^6; % Tensile Strength of Nut (Pascals)
% 304 Stainless Steel Yield Strength: 450 MPa
% Polycarbonate Yield Strength: 55 MPa
% PPA-CF Yield Strength: 168 MPa

pitchDiameter = bolt - 0.64952 *pitch; % Pitch Diameter, both approximated to be the same
area = pi * (bolt /2)^2; % Area of bolt
shearArea = pi * pitchDiameter * length; % Area of Shear

%% Bolt Tensile Failure

force = area * boltYield; % Newtons
fprintf('Force required to yield bolt is %.2f Newtons\n', force)

%% Bolt Thread Failure

boltShear = 0.6 * boltYield;
bForce = shearArea * boltShear;
fprintf('Force required to shear bolt is %.2f Newtons\n', bForce)


%% Nut Thread Failure

nutShear = 0.6 * nutYield;
nForce = shearArea * nutShear;
fprintf('Force required to shear nut is %.2f Newtons\n', nForce)