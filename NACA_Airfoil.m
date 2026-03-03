%% NACA_Airfoil Points
% Code for NACA Airfoil 00xx, symmetrical 4-digit airfoil
% Written by Josh Kim - Buckeye Rocketry

% Housekeeping
clc
clear
close all

%% Initial Variables - Variables to Manipulate
rootChord = 24; % in Millimeters
tipChord = 10; % in Millimeters
sweepLength = 0;% in Millimeters

digits = 10; % Last two numbers of 00xx
x = linspace(0,1,100);
t = digits/100; 

% NACA Airfoil-00xx Equation
y = 5 * t * ( (0.2969 * x.^(1/2)) - (0.1260 * x) - (0.3516 * x.^2) + (0.2843 * x.^3) - (0.1015 * x.^4) );

yRoot = y * rootChord;
xRoot = x * rootChord;

yTip = y * tipChord;
xTip = (x * tipChord) + sweepLength;

% Graphical Representation
figure('Name', 'NACA 00xx Airfoil', 'NumberTitle', 'off')
title('NACA 00xx Airfoil')
xlabel('Chord (Milimeters)')
ylabel('Thickness (Milimeters)')
hold on
plot(xRoot, yRoot, 'b');
plot(xRoot, -yRoot, 'b');
plot(xTip, yTip, 'r');
plot(xTip, -yTip, 'r');
axis equal

% Creation of Points
z = zeros(1, 100);
rootPoints = [xRoot' yRoot' z'];
tipPoints = [xTip' yTip' z'];

% Output to Excel
writematrix(rootPoints, 'NACA_Airfoil_RootChord_Points.txt')
writematrix(tipPoints, 'NACA_Airfoil_TipChord_Points.txt')

