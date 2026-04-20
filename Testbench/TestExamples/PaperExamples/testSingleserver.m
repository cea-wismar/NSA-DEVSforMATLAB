function out = testSingleserver(showPlot)
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  oldpwd = cd("../../../Examples/PaperExamples");
  load_system("StdLib");
  load_system("PaperLib");

  out = runSingleserver(showPlot);

  close_system("StdLib");
  close_system("PaperLib");
  cd(oldpwd)
end
