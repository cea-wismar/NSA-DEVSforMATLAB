function runCompswitch(model)
% makes and runs model and plots results
% parameters:
%   model    "compswitch" or "compswitchA"
% optional: 
%   set global DEBUGLEVEL
%   model_simulator(model, tEnd, false)
if nargin == 0
  model = "compswitch";
end

tEnd = 17.5;

model_generator(model); 
out = model_simulator(model, tEnd);
plotResults(out, tEnd)
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd)
figure("name", "compswitch", "NumberTitle", "off", ...
  "Position", [1 1 450 600]);
subplot(4,1,1)
stem(out.vgenOut.t,out.vgenOut.y);
grid("on");
xlim([0, tEnd])
ylim([-3.4, 2.4])
ylabel("out");
title("VectorGen");

subplot(4,1,2)
stairs(out.compOut.t,out.compOut.y);
hold("on");plot(out.compOut.t,out.compOut.y, "*");hold("off");
grid("on");
xlim([0, tEnd])
ylim([-0.1, 1.1])
ylabel("out");
title("Comparator");

subplot(4,1,3)
stem(out.sw1Out.t,out.sw1Out.y);
grid("on");
xlim([0, tEnd])
ylim([-3.4, 2.4])
ylabel("out1");
title("Switch 1");

subplot(4,1,4)
stem(out.sw2Out.t,out.sw2Out.y);
grid("on");
xlim([0, tEnd])
ylim([-3.4, 2.4])
ylabel("out2");
title("Switch 2");
end