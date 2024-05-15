function etaSpur = etaSpur_maN1N2(mu, alpha, N1, N2)
% Calculate the efficiency of two meshed spur gears given the friction
% between the two materials (mu), the gear pressure angle (alpha) in 
% radians, and thenumber of teeth on the first and second gears (N1 & N2) 
% respectively.
% Note that N2 must be > N1.
    numerator = 1-(mu.*(alpha + (pi./N2)));
    denominator = 1-(mu.*(alpha - (pi./N1)));
    etaSpur = numerator./denominator;

end