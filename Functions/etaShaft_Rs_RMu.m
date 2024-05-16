function etaShaft = etaShaft_Rs_RMu(Rs,r, mu)
% Calculate shaft efficiency given radius of the shaft (Rs), radius of the gear
% (r) and mu of the gear-shaft interaction.
    etaShaft = 1 - ((Rs./r).*mu);
end