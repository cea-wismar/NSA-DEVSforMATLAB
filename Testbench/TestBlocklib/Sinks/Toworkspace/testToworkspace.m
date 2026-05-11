function out = testToworkspace(showPlot)
  if nargin == 0
    showPlot = false;
  end
 
	global simin
  
  tend = 10;
  simin.in.t = [0, 1, 2, 3, 4, 5];
  simin.in.y = [1, 1.2, 7, 9, 10, 100];

  model_generator("Toworkspace_Model");
  out = model_simulator("Toworkspace_Model", tend);

  if showPlot
    width = 600;
    height = 400;
    fig = figure("name", "testToworkspace", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    stem(out.out1.t,out.out1.y); grid on;
    xlim([0 tend]);
    xlabel('t');
    ylabel('y');
    title('vector');

    disp(out.out2.t);
    disp(out.out2.y);
  end
end
