%% Nose Cone Ballast Calculator
% Code for internal ballast needed for LD-Haack series Nose cone (Von Karman ogive)
% Internal ballast assumed to be spherical balls suspended in liquid (Packing Density)
% Or solid nose cone tip 
% Written by Josh Kim - Buckeye Rocketry

% Housekeeping
clc
clear
close all

%% Initial Variables - Variables to Manipulate
BallastMass = 1.5; % Ballast Mass Needed in kg

Diameter = 5.8 / 100; % Internal Diameter of Nose Cone (In meters, input in cm)
Length = 30 / 100; % Internal Length of Von Karman Nose Cone (In meters, input in cm)
theta = linspace(0,pi,10000); % 100,000 spaces in between 0 and pi

% Densities
ballastDensity = 8500; % Density kg/m^3

% Density of common ballast materials

% Aluminum = 2,700 kg/m^3
% Stainless Steel 8,000 kg/m^3
% Brass 8,500 kg/m^3
% Lead = 11,340 kg/m^3
% Tungsten 19,250 kg/m^3

packingFactor = 1;
% 57.5% (0.575) is a conservative assumption for random packing density
% Packing factor is 100% (1) for solid materials

emptySpace = 1-packingFactor; % Empty space not taken by 
epoxyDensity = 1200; % Cured Epoxy Density kg/m^3

%% Full Volume
fullVolume = 1/2 * pi * (Diameter / 2)^2 * Length; % m^3

%% Volume and Height Needed
totalDensity = ballastDensity * packingFactor + emptySpace * epoxyDensity; % Combined density
partialVolume = BallastMass / totalDensity; % m^3

%% Parametrize Using Theta
volume = (((Diameter / 2)^2 * Length) / 2 ) .* (sin(theta) - theta .* cos(theta) - (1/3) .* (sin(theta).^3));

for i = 1:100000
    % Search for theta value that causes
    if volume(i) > partialVolume
        finalTheta = theta(i);
        break
    end
end

height = (Length/2) * (1 - cos(finalTheta)) * 100; % Centimeters

percentFilled = 100 * partialVolume / fullVolume;

fprintf("Ballast Volume: %.1f grams taking up %.1f cm^3\n", BallastMass * 1000, partialVolume*(100^3))
fprintf("Fill height: %.2f cm of %.1f cm total\n", height, Length * 100)
fprintf("Percentage filled: %.2f %%\n", percentFilled)
