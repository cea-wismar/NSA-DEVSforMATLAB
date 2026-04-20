function tests = test_examples
	tests = functiontests(localfunctions);
end

% Run the models in the Example directory and compare the results 
% with the saved results.
% run with:
%    run(test_examples)

%% PaperExamples
function test_PaperExamples_compswitch(testCase)
  oldpwd = cd("TestExamples/PaperExamples");
	act_out = testCompswitch(1, false);
	load("testCompswitch_out.mat");
	verifyEqual(testCase, act_out, testCompswitch_out)
  cd(oldpwd);
end
function test_PaperExamples_compswitchA(testCase)
  oldpwd = cd("TestExamples/PaperExamples");
	act_out = testCompswitch(2, false);
	load("testCompswitchA_out.mat");
	verifyEqual(testCase, act_out, testCompswitchA_out)
  cd(oldpwd);
end
function test_PaperExamples_shiftregister(testCase)
  oldpwd = cd("TestExamples/PaperExamples");
	act_out = testShiftregister(false);
	load("testShiftregister_out.mat");
	verifyEqual(testCase, act_out, testShiftregister_out)
  cd(oldpwd);
end
function test_PaperExamples_singleserver(testCase)
  oldpwd = cd("TestExamples/PaperExamples");
	act_out = testSingleserver(false);
	load("testSingleserver_out.mat");
	verifyEqual(testCase, act_out, testSingleserver_out)
  cd(oldpwd);
end
function test_PaperExamples_fifo3(testCase)
  oldpwd = cd("TestExamples/PaperExamples");
	act_out = testFifo3(false);
	load("testFifo3_out.mat");
	verifyEqual(testCase, act_out, testFifo3_out)
  cd(oldpwd);
end

%% C22
function test_C22_fixFifoA(testCase)
  oldpwd = cd("TestExamples/C22");
	act_out = testFixFifo(1, false);
	load("testFixFifoA_out.mat");
	verifyEqual(testCase, act_out, testFixFifoA_out)
  cd(oldpwd);
end
function test_C22_fixFifoB(testCase)
  oldpwd = cd("TestExamples/C22");
	act_out = testFixFifo(2, false);
	load("testFixFifoB_out.mat");
	verifyEqual(testCase, act_out, testFixFifoB_out)
  cd(oldpwd);
end

%% BigExample
function test_BigExample_productionLine(testCase)
  oldpwd = cd("TestExamples/BigExample");
	act_out = testProductionLineP(false);
	load("testProductionLineP_out.mat");
	verifyEqual(testCase, act_out, testProductionLineP_out, RelTol=1e-14)
  cd(oldpwd);
end

%% BigExampleS
function test_BigExampleS_productionLine(testCase)
  oldpwd = cd("TestExamples/BigExampleS");
	act_out = testProductionLineS(false);
	load("testProductionLineS_out.mat");
	verifyEqual(testCase, act_out, testProductionLineS_out, RelTol=1e-14)
  cd(oldpwd);
end

%% TimeShared
function test_TimeShared_timeShared(testCase)
  oldpwd = cd("TestExamples/TimeShared");
	act_out = testTimeShared(false);
	load("testTimeShared_out.mat");
	verifyEqual(testCase, act_out, testTimeShared_out)
  cd(oldpwd);
end

%% Tutorial
function test_Tutorial_tut01(testCase)
  oldpwd = cd("TestExamples/Tutorial");
	act_out = testTut01(false);
	load("testTut01_out.mat");
	verifyEqual(testCase, act_out, testTut01_out)
  cd(oldpwd);
end
function test_Tutorial_tut02(testCase)
  oldpwd = cd("TestExamples/Tutorial");
	act_out = testTut02(false);
	load("testTut02_out.mat");
	verifyEqual(testCase, act_out, testTut02_out)
  cd(oldpwd);
end
function test_Tutorial_tut03(testCase)
  oldpwd = cd("TestExamples/Tutorial");
	act_out = testTut03(false);
	load("testTut03_out.mat");
	verifyEqual(testCase, act_out, testTut03_out)
  cd(oldpwd);
end
function test_Tutorial_tut04(testCase)
  oldpwd = cd("TestExamples/Tutorial");
	act_out = testTut04(false);
	load("testTut04_out.mat");
	verifyEqual(testCase, act_out, testTut04_out)
  cd(oldpwd);
end
function test_Tutorial_tut05(testCase)
  oldpwd = cd("TestExamples/Tutorial");
	act_out = testTut05(false);
	load("testTut05_out.mat");
	verifyEqual(testCase, act_out, testTut05_out)
  cd(oldpwd);
end
function test_Tutorial_tut06(testCase)
  oldpwd = cd("TestExamples/Tutorial");
	act_out = testTut06(false);
	load("testTut06_out.mat");
	verifyEqual(testCase, act_out, testTut06_out)
  cd(oldpwd);
end
function test_Tutorial_tut07(testCase)
  oldpwd = cd("TestExamples/Tutorial");
	act_out = testTut07(false);
	load("testTut07_out.mat");
	verifyEqual(testCase, act_out, testTut07_out)
  cd(oldpwd);
end
