function out = testFifo3(showPlot)
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  oldpwd = cd("../../../Examples/PaperExamples");
  load_system("StdLib");
  load_system("PaperLib");

  out = runFifo3(showPlot);

  close_system("StdLib");
  close_system("PaperLib");
  cd(oldpwd)
end
