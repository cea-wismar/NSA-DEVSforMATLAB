function out = testTimeShared(showPlot)
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  oldpwd = cd("../../../Examples/TimeShared");
  load_system("StdLib");
  load_system("TimeSharedLib");

  out = runTimeSharedS(showPlot);

  close_system("StdLib");
  close_system("TimeSharedLib");
  cd(oldpwd)
