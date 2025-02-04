function [out] = testVectorgen()

    tEnd = 17;
	model_generator("Vectorgen_Model");
	out = model_simulator("Vectorgen_Model", tEnd);

    if 0
        figure("name","testVectorgen", "NumberTitle","off");
        stairs(out.genOut.t,out.genOut.y);
        hold("on");plot(out.genOut.t,out.genOut.y, "*");hold("off");
        grid("on");
        xlim([0, tEnd])
        ylim([-0.1, 3.2])
        xlabel("simulation time");
        ylabel("out");
        title("VectorGen");
    end
end