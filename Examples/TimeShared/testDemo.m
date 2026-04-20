function testDemo()
  tEnd = 6;

  model_generator("demo1");
  out = model_simulator("demo1", tEnd);
  plot_results(out, tEnd);
end

function plot_results(out, tEnd);
  figure("name", "demo1", "NumberTitle", "off")
  subplot(2,1,1)
  stem(out.input.t,out.input.y); grid on;
  xlim([0 tEnd]);
  title("Generator out");

  subplot(2,1,2)
  stem(out.result.t,out.result.y); grid on;
  xlim([0 tEnd]);
  title("Add2 out");
end
