% Setup project 2 props
addpath('Functions/');
g = 9.8;

m_lift = 2; % kg
F_lift = 2*g;

% PLA PROPERTIES
pla_sigma_yield = 50*1e6; % [Pa]
pla_elastic_modulus = 3.6*1e6; % [Pa]
pla_flexural_strength = 70*1e6;
pla_flexural_modulus = 3.8*1e6;
pla_sigma_yield_weak = 20*1e6;
pla_sigma_yield_interlaminar = 5*1e6;
pla_rho = 1240; % [kg/m^3]