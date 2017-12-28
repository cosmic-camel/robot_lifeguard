clear all
%% Initial parameters
fluid_density = .03613; %lb/in^3 for freshwater
g = 386.2205; %in/s^2
%people calc

density_person = .03558; %lb/in^3
m_person = 400;%lb
V_person = m_person/density_person;% in^3

Amount_Wet = .5; %how much of the person is in the water
V_person_disp = Amount_Wet*V_person; %rough calculation

%boat calc

m_components = 0; %battery
m_shell = 24; % lb
m_substructure = 39.8;% lb

m_boat = m_shell + m_substructure+m_components;

V_boat = 5972.53; %in^3
V_boat_disp = V_boat; % rouch calculation

%% Calculations

V_disp = V_boat + V_person_disp;
%V_disp = 5*10^-4 * 61023.7 %UNIT TEST 

m_total = m_boat + m_person;
%m_total = .5 * 2.20462 %UNIT TEST


%% Mass Calculations

F_g = m_total; %lb
F_buoyancy = fluid_density*V_disp; %lb/in^3 * in^3 = lb


F_net = (F_buoyancy-F_g); %lb

%message = ['If the boat is fully submerged, the individual will float with',' ', int2str(F_net), ' pounds of force to spare.'];
%disp(message);

Density_Total= m_total / V_disp; %lbs/in^3
Density_Ratio = Density_Total / fluid_density
if Density_Ratio <= 1
    message = ['The Boat Will Float'];
    disp(message);
else
    message = ['The Boat Will Sink'];
    disp(message);
end

%% Source: https://en.wikipedia.org/wiki/Buoyancy 
%% Unit Test data from http://physics.bu.edu/~duffy/semester1/c21_arch_example.html