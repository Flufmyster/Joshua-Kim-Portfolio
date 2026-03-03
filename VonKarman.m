%% Von Karman Nose Cone
% Code for LD-Haack series Nose cone (Von Karman ogive)
% Written by Josh Kim - Buckeye Rocketry

% Housekeeping
clc
clear
close all


%% Initial Variables - Variables to Manipulate
D = 79.; % External Diameter of Nose Cone (In millimeters)
L = 300; % Length of Von Karman Nose Cone (In millimeters)
theta = linspace(0,pi,200); % Von Karman Nose Cone points

%% Haack Series Nose Cone Equation
x = (L/2) * (1 - cos(theta));
y = ((D/2) / sqrt(pi)) * sqrt(theta - (sin(2 * theta) / 2));

%% Graphical Representation
figure
hold on
plot(x, y, 'b')
plot(x, -y, 'b')
axis equal

x = x';
y = y';
z = zeros(200, 1);
Points = [x y z];

%% Output to Excel .txt file
% Use Curve Through XYZ Points Feature in SolidWorks
writematrix(Points, 'Von_Karman_Points.txt')

