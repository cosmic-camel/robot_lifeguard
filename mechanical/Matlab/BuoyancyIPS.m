clear all
%Environmental Givens
fluid_density = 62.26 ;%lbm/ft^3
g = 32.174 ;%ft/s^2

%Boat Given
m_comp = 3; %lbm
m_hull = 11; %lbm
m_fill = 3 * 2.45; % lbm/ft^3 * ft^3
V_boat = 2.45; %ft^3

%Person Given
density_person = 61.48; %lbm/ft^3
w_person = 400 ;%lbf
amount_wet = .75; %0 to 1, amount of person in water

%Calc
m_person = w_person  ;%lbf / gravity = lbm
V_person = m_person / density_person ;%lbm / lbm/ft^3 = ft^3

m_boat = m_comp + m_hull + m_fill;

wet_V_person = amount_wet * V_person;

person_buoyancy = wet_V_person * fluid_density;
m_wet_person = m_person - person_buoyancy;

wet_V_total = V_boat + wet_V_person;
m_total = m_boat + m_wet_person;

%% Mass Calculations

F_g = m_total; %lbf
F_buoyancy = fluid_density*V_boat; %lbm/in^3 * in^3  *g = lbf

F_net = (F_buoyancy-F_g); %lb

message = ['If the boat is fully submerged, the individual will float with',' ', int2str(F_net), ' pounds of force to spare.'];
disp(message);

Density_Total= m_total / V_boat; %lbs/in^3
Density_Ratio = Density_Total / fluid_density
if Density_Ratio <= 1
    message = 'The Boat Will Float';
    disp(message);
else
    message = 'The Boat Will Sink';
    disp(message);
end