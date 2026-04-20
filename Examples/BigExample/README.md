# Models of "Real-World Application" Paper 

This directory contains all examples from the article [Modeling and Simulation
of a Real-world Application using
NSA-DEVS](https://www.researchgate.net/publication/376651034_Modeling_and_Simulation_of_a_Real-world_Application_using_NSA-DEVS).

Since the NSA-DEVS modelbase is enhanced continuously, the paper model might
not work eventually and would have to be adapted. Therefore, it uses a fixed
library StdLib that contains copies of the necessary components.

## Models

Basic Model:

- productionLine: model of the complete production line (Fig. 1)  

Test Models:

- testTurningMachine: test model of a turning machine  
- testTurning: test model of the turning section  
- testFurnace: test model of a furnace (Fig. 4)  
- testGrindingMachine: test model of a grinding machine  
- testGrinding: test model of the grinding section (Fig. 2, Fig. 3)  

Libraries:

- ProductionLineLib_AM: library of atomic models for the production line
- ProductionLineLib_CM: library of coupled models for the production line
- ProductionLineLib: top level library
- StdLib: Library with copies of the NSA-DEVS modelbase

## Run Scripts

Complete production line:

- runProductionLine.m  
  parameter nr=2: complete run (Fig. 7)
  parameter nr=1: shorter run for test purposes

Test of components:

- runTestFurnace.m  
- runTestGrinding.m  
- runTestGrindingMachine.m  
- runTestTurning.m  
- runTestTurningMachine.m
