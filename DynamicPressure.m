%% Dynamic Pressure Calculation
% Dynamic Pressure Calculation

% Housekeeping
clc
clear
close all

% Initial Values

velocity = 530; % In meters / seconds

% Air Density from 0 - 11,000m

rhoZero = 1.225; % kg/m^3
h = 1:11000; % Altitude from 0 - 11,000m

rho = rhoZero * (1 - 2.25577 .* 10.^(-5) .* h ).^4.256;

% Air Density from 11,000 - 

q = (1/2) * (rho) * velocity^2; % in N/m^2