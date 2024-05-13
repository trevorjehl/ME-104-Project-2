function etaSpur = etaSpur_maN1N2(mu,alpha, N1, N2)

    numerator = 1-(mu.*(alpha + (pi./N2)));
    denominator = 1-(mu.*(alpha - (pi./N1)));
    etaSpur = numerator./denominator;

end