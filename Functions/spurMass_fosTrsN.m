function spurmass = spurMass_fosTrsN(FOS,T,rho,sigma,N)
% Calculate the mass of a spur gear given the factor of safety (FOS),
% torque on the gear (T), material density (rho, kg/m^3), sigma (unmodified
% endurance strength of material, Pa), and N (number of gear teeth).
    spurmass = 4.*pi.*FOS.*T.*(N.^(7/8)).*rho./sigma;

    if spurmass < 0
        errordlg(' Error: Spur gear mass is negative.');
    end
end