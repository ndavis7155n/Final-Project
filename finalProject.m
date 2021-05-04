function [] = finalProject()
%I created a global structure to hold all the values
    global physics;
    
    %creates the window to display all the uicontrols
    physics.fig = figure('name', 'Kinematics Calculater');
    
    %States the question of what the user wants to calculate
    physics.Question = uicontrol('style', 'text', 'units', 'normalized', 'position', [.10 .80 .20 .10], 'string', 'What do you want to calculate?','horizontalalignment', 'left');
    %Creates a drop down menu for the user to use
    popup = uicontrol(physics.fig, 'style', 'popupmenu', 'units', 'normalized', 'position', [.10 .75 .10 .05], 'string', 'Distance (x)', 'string', 'Final Velocity (Vf)', 'callback', {@popupSelection});
    popup.String = {'Distance (x)','Final Velocity (Vf)'};
    
    %callback function of what the user selects from the drop down menu
    function popupSelection(src,event)
        switch get(popup, 'Value')
        %tests if the user selected to calculate Distance (x)
            case 1
            %Displays uicontrols text and edit boxes for all the inputs of
            %calculating distance
                fprintf('\nSelection: Distance (x)\n');
                physics.initialDistance(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.30 .80 .20 .10], 'string', 'Enter the initial distance','horizontalalignment', 'left');
                physics.initialDistance(2) = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.30 .75 .05 .05],'horizontalalignment', 'left');
                physics.initialVelocity(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.50 .80 .20 .10], 'string', 'Enter the initial velocity','horizontalalignment', 'left');
                physics.initialVelocity(2) = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.50 .75 .05 .05],'horizontalalignment', 'left');
                physics.time(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.70 .80 .20 .10], 'string', 'Enter the time','horizontalalignment', 'left');
                physics.time(2) = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.70 .75 .05 .05],'horizontalalignment', 'left');
                physics.acceleration(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.90 .80 .20 .10], 'string', 'Enter the acceleration','horizontalalignment', 'left');
                physics.acceleration(2) = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.90 .75 .05 .05],'horizontalalignment', 'left', 'Callback', {@distanceCalc});
            case 2 
            %Tests if the user selected to calculate final velocity and
            %displays all the text and edit boxes for all the inputs
               fprintf('\nSelection: Final Velocity (Vf)\n');
               physics.initialVelocity(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.30 .80 .20 .10], 'string', 'Enter the initial velocity','horizontalalignment', 'left');
               physics.initialVelocity(2) = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.30 .75 .05 .05],'horizontalalignment', 'left');
               physics.time(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.50 .80 .20 .10], 'string', 'Enter the time','horizontalalignment', 'left');
               physics.time(2) = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.50 .75 .05 .05],'horizontalalignment', 'left');
               physics.acceleration(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.70 .80 .20 .10], 'string', 'Enter the acceleration','horizontalalignment', 'left');
               physics.acceleration(2) = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.70 .75 .05 .05],'horizontalalignment', 'left', 'Callback', {@velocityCalc});
            otherwise
        end
    end

%Callback function for calculating and displaying the final distance
    function distanceCalc(src,event)
        
        %Gets the input values from the edit boxes and converts them to
        %doubles to be used in calculations
        initialDistance = get(physics.initialDistance(2), 'string');
        initialDistance = str2double(initialDistance);
        initialVelocity = get(physics.initialVelocity(2), 'string');
        initialVelocity = str2double(initialVelocity);
        time = get(physics.time(2), 'string');
        time = str2double(time);
        acceleration = get(physics.acceleration(2), 'string');
        acceleration = str2double(acceleration);
        distance = initialDistance + initialVelocity * time + 0.5 * acceleration * power(time, 2);
        distance = distance * 100;
        distance = floor(distance);
        physics.distance = distance / 100;
        fprintf('\nDistance: %d\n', physics.distance);
        
        %Displays the final answer of distance using ui controls
        physics.distDisplay(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.60 .40 .20 .10], 'string', 'Congrats Nerd here is your final distance: ', 'horizontalalignment', 'left');
        physics.distDisplay(2) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.90 .40 .20 .10], 'string', num2str(physics.distance), 'horizontalalignment', 'left');
    end

%Callback function for calculating and displaying the final velocity
     function velocityCalc(src,event)
         
        %Gets the input values from the edit boxes and converts them to
        %doubles to be used in calculations
        initialVelocity = get(physics.initialVelocity(2), 'string');
        initialVelocity = str2double(initialVelocity);
        time = get(physics.time(2), 'string');
        time = str2double(time);
        acceleration = get(physics.acceleration(2), 'string');
        acceleration = str2double(acceleration);
        velocity = initialVelocity + acceleration * time;
        velocity = velocity * 100;
        velocity = floor(velocity);
        physics.velocity = velocity / 100;
        fprintf('\nFinal Velocity: %d\n', physics.velocity);
        
        %Displays the final answer of distance using ui controls
        physics.velDisplay(1) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.60 .40 .20 .10], 'string', 'Congrats Nerd here is your final velocity: ', 'horizontalalignment', 'left');
        physics.velDisplay(2) = uicontrol('style', 'text', 'units', 'normalized', 'position', [.90 .40 .20 .10], 'string', num2str(physics.velocity), 'horizontalalignment', 'left');
    end
end