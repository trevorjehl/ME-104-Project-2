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

% ACRYLIC PROPERTIES [CAST]
% https://www.matweb.com/search/DataSheet.aspx?MatGUID=a5e93a1f1fff43bcbac5b6ca51b8981f&ckck=1
acrylic_elastic_modulus = 3*10^9; % [Pa]
acrylic_poisson_ratio = 0.370;
acrylic_shear_modulus = 1.7*10^9; % [Pa]
acrylic_shear_strength = mean([25.5, 62.1])*10^6; % [Pa]
acrylic_mu = mean([0.8 0.45]);
