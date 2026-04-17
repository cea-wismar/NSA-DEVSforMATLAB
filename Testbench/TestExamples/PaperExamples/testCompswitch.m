function out = testCompswitch(nr, showPlot)
  if ~exist("nr", "var")
    nr = 1;
  end
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  oldpwd = cd("../../../Examples/PaperExamples");
  load_system("StdLib");
  load_system("PaperLib");

  out = runCompswitch(nr, showPlot);

  close_system("StdLib");
  close_system("PaperLib");
  cd(oldpwd)
end
