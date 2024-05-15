function sigmaT = rotatingSr_rovRiRoR(rho, omega, Ri, Ro, R)
% Calculate the radial stress of a rotating ring given the density r
% (rho), angular speed omega (rad/s), poisson ratio v (eta), inner radius 
% Ri, outer radius Ro, and radius of interest R
    secondparens = (Ri^2 + Ro^2 + ((Ri^2 * Ro^2)/R^2) - R^2);
    firstparen = (3+eta)/8;
    
    sigmaT = rho*omega^2*firstparen*secondparens;
end