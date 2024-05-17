% Analyze a two-step geartrain with an overall transmission ratio.
% Note that the code assumes that there is a rack connected to a small
% gear which is fixed to a larger diamter gear. That large diameter gear
% meshes with another small diameter gear that ultimately lifts the mass.
clear all; close all; clc; format compact;
setupProject2Props;

Roverall = 12; % overall transmission ratio
FOS = 1.5; % overall factor of safety
alpha = (20/180)*pi;
mu = 0.4;

NteethArr = 16:2:100;
Module_arr = 0.5:0.5:2;
D_arr = bsxfun(@times,NteethArr', Module_arr); % mm [each column is a different module]
R_arr = D_arr./2; % mm

% Work through the geartrain from back to front, from the lifting mass to
% the drop mass. 
% Note that gear 4 = last gear connected to the lift mass

module = 2; % select module index [note this is not the actual module]

dataArr = zeros(1,4*5 + 2);
for gear4 = 1:1:length(R_arr)
    r(4) = R_arr(gear4, module); % [mm]
    N(4) = NteethArr(gear4);

F(4) = F_lift; % [N]
T(4) = r(4)*F(4)/1000; % [N*m]
mass(4) = spurMass_fosTrsN(FOS,T(4),pla_rho,pla_sigma_yield,N(4)); % [kg]

for gear3 = 1:1:length(R_arr)
    r(3) = R_arr(gear3, module); % [mm]
    N(3) = NteethArr(gear3);
    R43 = r(3)/r(4);

eta43 = etaSpur_maN1N2(mu, alpha, N(4), N(3));

F(3) = F(4); % [N*m]
T(3) = T(4)*R43*eta43; % [N*m]

mass(3) = spurMass_fosTrsN(FOS,T(3),pla_rho,pla_sigma_yield,N(3)); % [kg]

for gear2 = 1:1:length(R_arr)
    r(2) = R_arr(gear2, module); % [mm]
    N(2) = NteethArr(gear2);
    module2 = Module_arr(module);

    r(1) = (Roverall/R43)*r(2); % [mm]
    R21 = r(1)/r(2);
    d1 = r(1)*2; % [mm]
    N(1) = d1 / module2;
    eta21 =  etaSpur_maN1N2(mu, alpha, N(2), N(1));

F(2) = (r(3)/r(2))*F(3); % [N]
T(2) = F(2)*r(2)/1000; % [N*m]

F(1) = F(2); % [N]
T(1) = T(4)*R43*R21*eta43*eta21; % [N*m]

if eta43 >1 || eta21 >1
    continue
end

mass(2) = spurMass_fosTrsN(FOS, T(2), pla_rho, pla_sigma_yield,N(2)); % [kg]
mass(1) = spurMass_fosTrsN(FOS, T(4), pla_rho, pla_sigma_yield,N(1)); % [kg]

dataArr(end+1,:) = [r F T eta21 eta43 mass N];
end
end
end

% Remove the initial row of zeros
dataArr = dataArr(2:end, :);

% % % % % % % % % % % % % % % % PLOTTING % % % % % % % % % % % % % % % % % 

clf; clc;
% % Example data
x = dataArr(:,1)./dataArr(:,2); % Your x array
y = dataArr(:,3)./dataArr(:,4); % Your y array
z = dataArr(:,13).*dataArr(:,14);

% Plot contour
figure(1);
dotsize = 6;
scatter3(x, y, z, dotsize, z, 'filled');
c = colorbar;
% set(gca, 'XScale', 'log');
% set(gca, 'YScale', 'log');
xlabel('R1/R2');
ylabel('R3/R4');
zlabel('Total Efficiency')
title('Contour Plot');

% % % % % % % % % % % NOW FOR MASS % % % % % % % %

% Example data
x = dataArr(:,1)./dataArr(:,2); % Your x array
y = dataArr(:,3)./dataArr(:,4); % Your y array
z = sum(dataArr(:,15:18),2);

figure(2);
scatter3(x, y, z, dotsize, z, 'filled');
c = colorbar;
% set(gca, 'XScale', 'log');
% set(gca, 'YScale', 'log');
xlabel('R1/R2');
ylabel('R3/R4');
zlabel('Total Mass')
title('Contour Plot');

z = sum(dataArr(:,15:18),2)./(dataArr(:,13).*dataArr(:,14));
[optimalZ, optimalIdx] = min(z);
optimalRow = dataArr(optimalIdx,:);
fprintf(sprintf('Current Module: %.0f \n', Module_arr(module)));
optimal_radius_mm = optimalRow(1:4)
optimal_width_m = faceWidth_TfosSPN(optimalRow(9:12), FOS, pla_sigma_yield, (1000/Module_arr(module)), optimalRow(19:22))
R3_over_R4 = x(optimalIdx)
R1_over_R2 = y(optimalIdx)
optimal_mass = sum(optimalRow(15:18))

figure(3)
scatter3(x, y, z, dotsize, z);
hold on;
plot3(x(optimalIdx), y(optimalIdx), z(optimalIdx), 'ro','MarkerSize',10, 'LineWidth',10)

c = colorbar;
% set(gca, 'XScale', 'log');
% set(gca, 'YScale', 'log');
xlabel('R1/R2');
ylabel('R3/R4');
zlabel('Total Mass / Efficiency [Lower Is Better]')
title('Contour Plot');