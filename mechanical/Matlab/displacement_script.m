%% Description

%The purpose of this script is to determine the velocity and position of
%the boat, given that there is a period where the boat accelerates, and the
%boat 'decelerates'. This is performed using numerical integration

%Numerical Integration:

%Numerical integration trades a small bit of accuracy for simplified code.
%Let's say we're given an integral:

%integral(x, dx) from 0 to 1

%our equation would evaluate to [.5(1)^2 - .5(0)^2]  = .5

%however we do not like matlab symbolic notation because it is garbage, so
%we do not have matlab derive our governing equation for us. 

%when we integrate, we are essentially performing the following calculation 
%over and over again (i.e. on a loop)

%new_x = (current_x + new_x)dx
%

%instead 



%% PARAMETER AND SETUP
clear all
m_boat= 65; %lbs, includes all equipment
F_f = 11.2; %lbs-force, forward thrust
F_b = 9.0; %lbs-force, rearward thrust
a_f = 32.17*F_f / m_boat; %acceleration, ft/s^2
a_b = -32.17*F_b / m_boat; %backward acceleration = deceleration ft/s^2
Vi = 0; %initial velocity, ft/s

timestep = .001; %timestep required for 
t = (0:timestep:15);

acceleration_list = zeros(1,length(t));
acceleration_list(1) = a_f;
velocity_list = zeros(1,length(t));
velocity_list(1) = Vi;
displacement_list = zeros(1, length(t));

disp_cutoff = 100;
cutoff_index = 0;
stopped_index = 0;
velocity_check = 0;
%% NUMERICAL INTEGRATION
check_decel = 0;
for index = 2:length(t);
%% TEST IF SLOWING DOWN 
    %% before cutoff pt
    if displacement_list(index-1) < disp_cutoff && check_decel == 0;
        status = [1,': Before cutoff pt'];
        a = a_f;
    %% after cutoff point    
    elseif displacement_list(index-1) >= disp_cutoff && check_decel == 0;
        check_decel = 1;
        status = [2, 'just reached cutoff pt'];
        a = a_b;
    elseif check_decel == 1
        a = a_b;
        status = [3, 'after cutoff pt'];
    end
    
    if velocity_list(index-1) < 0 && velocity_check == 0
        status = [4, 'boat has stopped'];
        velocity_check = 1;
    end
    
    %% numerical integration for real
    acceleration_list(index) = a;
    velocity_list(index) = velocity_list(index-1) + a*timestep;
    displacement_list(index) = displacement_list(index-1) + velocity_list(index)*timestep;
    
    if status(1) == 2
        cutoff_index = index;
    end
    if status(1) == 4
        stopped_index = index;
    end
    
end

plot(t, displacement_list);
hold on ;
plot(t,velocity_list);
hold on ;
plot(t,acceleration_list);
hold on ; 
plot(repmat(t(cutoff_index), 1, length(t)), displacement_list, '--');
plot(repmat(t(stopped_index), 1, length(t)), displacement_list, '--');

legend('displacement', 'velocity', 'acceleration','Cutoff', 'Boat Stopped','Location','northwest');
hold off
t_cutoff = t(cutoff_index);
t_stopped = t(stopped_index);

message = ['The boat stopped after ',num2str(t_stopped), ' seconds']
message = ['After starting to slow down, it took approximately' t_stopped - t(cutoff_index)]

