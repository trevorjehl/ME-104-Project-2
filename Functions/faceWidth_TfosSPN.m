function w = faceWidth_TfosSPN(T, FOS, s, P, N)
    numerator = 16*T*FOS*P^2;
    denominator = N*(N-11)^(1/8);
    denominator = denominator * s;

    w = numerator/denominator;
end