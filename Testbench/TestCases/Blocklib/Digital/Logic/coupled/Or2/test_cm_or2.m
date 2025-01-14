function out = test_cm_or2()

    tEnd = 15;
	model_generator("CMOr2_Model");
	out = model_simulator("CMOr2_Model", tEnd);
    
    if 0
        figure("name", "testOr2", "NumberTitle", "off", "Position", [1 1 450 400]);
        subplot(3,1,1)
        plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
        title("A");
        xlim([0,16])
        xlabel('t');
        grid on;
        
        subplot(3,1,2)
        plot_ieee1164(out.gen2Out.t, out.gen2Out.y);
        title("B");
        xlim([0,16])
        xlabel('t');
        grid on;
        
        subplot(3,1,3)
        plot_ieee1164(out.orOut.t, out.orOut.y);
        title("Y");
        xlim([0,16])
        xlabel('t');
        grid on;
    end   
end