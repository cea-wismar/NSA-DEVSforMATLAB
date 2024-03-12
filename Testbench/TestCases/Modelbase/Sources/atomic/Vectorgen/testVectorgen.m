function [out] = testVectorgen(showPlot)
	if nargin == 0
      showPlot = false;
    end

    global simout
    global epsilon
    global DEBUGLEVEL
    global mi;
    mi = 0.0;
    simout = [];
    DEBUGLEVEL = 0;           % simulator debug level
    epsilon = 1e-6;
    
    tVec = [1, 3, 7, 8, 9];
    yVec = [2, 3, 2, 2, 1];
    tEnd = 17;
    mdebug = false;
    rOut = 2.0;
    
    N1 = coordinator("N1");
    
    Vectorgen = devs(am_vectorgen("Vectorgen", tVec, yVec, [0, 1], mdebug));
    Terminator = devs(am_terminator("Terminator", [0, 1], mdebug));
    Genout = devs(am_toworkspace("Genout", "genOut", 0, "vector", [0, rOut], mdebug));
    
    N1.add_model(Vectorgen);
    N1.add_model(Terminator);
    N1.add_model(Genout);
    
    N1.add_coupling("Vectorgen","out","Terminator","in");
    N1.add_coupling("Vectorgen","out","Genout","in");
    
    root = rootcoordinator("root",0,tEnd,N1,0,0);
    root.sim();
    out = simout;

    if showPlot
        figure("name","testVectorgen", "NumberTitle","off");
        stairs(simout.genOut.t,simout.genOut.y);
        hold("on");plot(simout.genOut.t,simout.genOut.y, "*");hold("off");
        grid("on");
        xlim([0, tEnd])
        ylim([-0.1, 3.2])
        xlabel("simulation time");
        ylabel("out");
        title("VectorGen");
    end
end