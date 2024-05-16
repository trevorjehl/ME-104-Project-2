function w = faceWidth_TfosSPN(T, FOS, s, P, N)
% Calculate the gear face width to exactly meet the desired factor of
% safety. Given gear torque (T), FOS, unmodified endurance strength of the
% gear material (s), diametral pitch P (N/D -- imperial standard), and number
% of teeth N.
    numerator = 16*T*FOS*P^2;
    denominator = N*(N-11)^(1/8);
    denominator = denominator * s;

    w = numerator/denominator;
end