% Calculate the torque out for N stage transmission with fixed transmission
% ratio
clear all; close all; clc;
setupProject2Props;

mu = 0.2;
P = 24; % diametral pitch N / D in
P = P/0.0254; % diametral pitch N/D [m]
N_b = 48;
FOS = 1;
r_lift = 1e-2; %m 

alpha = (20/180)*pi;

transmission_ratio = 1/10;
F_up = 10*9.8;

dstage = 0.01;
n_stages_arr = 0:dstage:5;
% r_small / r_large
stage_ratio_arr = exp(log(transmission_ratio)./n_stages_arr);
[stageRatioInflectX, stageRatioInflectY] = findInflectionPoints(n_stages_arr((1/dstage):end), ...
    stage_ratio_arr((1/dstage):end))

% Calculate efficiency
N_b = N_b;
N_s = N_b.*stage_ratio_arr;
% D = N/P
D_b = N_b/P;
r_b = D_b./2;
D_s = N_s./P;
r_s = D_s./2;

T_lift = F_lift.*r_lift;


eta = etaSpur_maN1N2(0.34, alpha, N_s, N_b);
eta_arr = eta.^(n_stages_arr);
[etaInflectX, etaInflectY] = findInflectionPoints(n_stages_arr((1/dstage):end),eta_arr((1/dstage):end));

% F_drop = F_lift.*((D_s./2)./(D_b./2));

T_drop = (r_lift./r_s).*F_lift.*(1./transmission_ratio).*eta_arr;
    M_drop = T_drop ./g;

% % Calcualte the mass of the geartrain for integer number of stages
m_stage_arr = zeros(1, max(n_stages_arr));
for iNstages = 1:1:max(n_stages_arr)
    m_stage = 0;
    stageIdx = (1/dstage)*iNstages;
    istage_ratio = stage_ratio_arr(stageIdx);
    istage_ratio = 1/istage_ratio

    iN_b = N_b;
    iN_s = N_s(stageIdx);

    T_last = T_lift;
    for j = 1:1:iNstages
        T_small = T_last;
            m_small = spurMass_fosTrsN(FOS,T_small, pla_rho, pla_sigma_yield, iN_s);
        T_big = T_small*istage_ratio;
            m_big = spurMass_fosTrsN(FOS,T_big, pla_rho, pla_sigma_yield, iN_b);
        m_stage = m_stage + m_small + m_big;
    end
    m_stage_arr(iNstages) = m_stage
end


% % % % % % % % % % % % % % % % MAKE PLOTS % % % % % % % % % % % % % % % %

figure(1);
hold on;
title('Stage Ratio vs. Number of Stages');
plot(n_stages_arr, stage_ratio_arr, 'DisplayName','Calculated Data');
plot(stageRatioInflectX, stageRatioInflectY,'o', 'DisplayName', 'Inflection Point');
xlabel('Number of Stages');
ylabel('Stage Ratio');
xlim([0 max(n_stages_arr)]);

figure(2);
hold on;
title('Geartrain Efficiency vs. N Stages');
plot(n_stages_arr, eta_arr);
xlabel('Number of Stages');
ylabel('Geartrain Efficiency \eta');

figure(3);
hold on;
title('Drop Mass Needed To Lift 2kg Mass', 'Assuming Rope Connected to Big Input & Small Output Gears');
plot(n_stages_arr, M_drop, 'DisplayName','Required Drop Mass [kg]');
    % plot(dropMassInflectX, dropMassInflectY, 'bo', 'DisplayName','Drop Mass Inflection');
plot(1:1:max(n_stages_arr), m_stage_arr*1e3,'o--' ,'DisplayName','Geartrain Mass [g]')
xlabel('Number of Stages');
ylabel('Mass');
ylim([0 50])
yyaxis('right');
plot(n_stages_arr, eta_arr, 'k-','DisplayName','Overall Efficiency');
    plot(etaInflectX, etaInflectY, 'ko','DisplayName','Efficiency Inflection');
ylabel('Efficiency');

figure(4);

title('Gear Diameter vs. Number of Stages', sprintf('For R_{lift} = %.1f cm', r_lift*100));
hold on;
plot(n_stages_arr, 100.*D_s, 'DisplayName','Small Gear Diameter');
plot(n_stages_arr, 100.*linspace(D_b,D_b, length(n_stages_arr)), 'DisplayName','Large Gear Diameter');
xlabel('Number of Stages');
ylabel('Gear Diameter [cm]');
yyaxis('right');
plot(1:1:max(n_stages_arr), m_stage_arr*1e3,'o--' ,'DisplayName','Geartrain Mass [g]')


plotfixer


function [xInflect, yInflect] = findInflectionPoints(xdata, ydata)
    % Ensure the input data is in ascending order
    [xdata, idx] = sort(xdata);
    ydata = ydata(idx);

    % Fit a cubic spline to the data
    pp = spline(xdata, ydata);

    % Compute the second derivative of the spline
    p2 = fnder(pp, 2);

    % Find zeros of the second derivative
    inflectionPoints = fnzeros(p2);
    xInflect = inflectionPoints(1, :);

    % Evaluate the original spline at the inflection points to get y-values
    yInflect = ppval(pp, xInflect);
end
