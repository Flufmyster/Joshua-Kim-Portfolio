# Rocket Analysis

MATLAB scripts for various Rocketry Calculations.
All independently written by Joshua Kim.

## How to run
1. Clone or download this repository.
2. Open MATLAB and set the folder to the repo directory.
3. Run required scripts, all scripts are independent and do not require another
4. Change necessary input values

## Files
1. My most used files

- **`RecoveryAnalysis.m`** - This script uses windspeed conditions, rocket mass, apogee, deployment altitude, and parachute dimensions, for both drogue and main, to calculate descent time, descent velocity, and 2D dimensional distance from launch pad from atmospheric models. Based on deployment altitude, drogue and main dimensions, a graph of descent speed over time is provided. When windspeed, direction, including each of their deviations are provided, a 100,000 iteration Monte Carlo simulation provides a graph of percentile likelihood of where the rocket lands. An additional feature allows you to experimentally find coefficient of drag for parachutes, given mass, terminal velocity, and parachute dimensions.

- **`VonKarman.m`** - My most used script. I use this to make Von Karman nose cones, arguably the best nose cone for supersonic speeds. Providing your nose cone height and diameter, this script provides 200 points in the x-y plane as a .txt file. Upload this into SolidWorks (using 'Curve through XYZ points' command) to easily create Von Karman nose cones. Von Karman nose cones are also creatable through equation driven curves, but I find this process to be far faster and easier.

- **`NoseConeBallast.m`** - This script assumes the usage of a Von Karman nose cone. Given a required ballast mass, height and diameter, this script tells you how much volume and height (from the tip) the mass will take. Really useful to find how large your ballast in your rocket needs to be, which is tedious to calcuate by hand (requires calculus every time). Script also accounts for various materials and their densities, as well as composite ballasts (e.g. ball bearings in suspended in epoxy) assuming average packing factor.

- **`ShockCordMount.m`** - This script calculates the strength of 3D printed shock cord mounts. I use this to calculate for the shear and tensile stress experienced by the shock cord. Providing your deployment velocity, stopping distance, rocket mass, mount dimensions, and material properties, it provides the shear and tensile stress, as well as respective safety factors.

- **`NACA_Airfoil.m`** - This script creates a pair of NACA 00xx airfoils based on root chord, tip chord, sweep length, and xx digits. The smaller airfoil is a smaller projection of the given airfoil, based on the sweep length. The pair of NACA 00xx airfoils are designed to be joined through a loft command to create airfoiled fins. Upload this into SolidWorks (using 'Curve through XYZ points' command) to easily create NACA airfoiled fins.

2. Lesser used files (mostly still in progress)
- **`FastenerFailure.m`** - Calculator for tensile stress/failure of a bolt and nut. I use this to calculate the force required to break the threads in my nose cone assemblies.
- **`Thermal.m`** - Basic calculator for stagnation pressure. I plan to add a heat transfer calculation as well.
- **`DynamicPressure.m`** - Basic calculator for dynamic pressure. I plan to include a fin flutter calculation as well.
