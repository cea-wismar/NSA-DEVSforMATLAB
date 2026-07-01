function out = testAdddata1(showPlot)
  % check behaviour if field parameter is entered as numerical value
  if nargin == 0
    showPlot = false;
  end
   
  tEnd = 5;
    
	model_generator("Adddata1_Model");
	out = model_simulator("Adddata1_Model", tEnd);

  if showPlot
    width = 400;
    height = 600;
    fig = figure("name", "testAdddata1", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    subplot(3,1,1)
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("t");
    ylabel("value");
    title("Generator");
 
    subplot(3,1,2)
    stem(out.dataOut.t, [out.dataOut.y.id]); grid on;
    xlim([0 tEnd]);
    xlabel("t");
    ylabel("id");
    title("Data");

    subplot(3,1,3)
    stem(out.dataOut.t, [out.dataOut.y.age]); grid on;
    xlim([0 tEnd]);
    xlabel("t");
    ylabel("age");
    title("Data");
  end
end