% Size the flywheel approximately
setupProject2Props;

d_shaft = 0.00635; % m
r_shaft = d_shaft/2;

dr = 0.1
Ro_arr = 0:dr:12; %cm
Ro_arr = Ro_arr./100; % m

for i = 1:1:length(Ro_arr)
    R = Ro_arr(i)

    st(i) = rotatingSr_rovRiRoR(pla_rho, )
end