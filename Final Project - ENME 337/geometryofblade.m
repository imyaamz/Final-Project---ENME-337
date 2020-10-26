function geometryofblade(chord,twist,radius)
%This function loads an array with the geometry of the airfoil. It
%multiplies it by the chord length array so we get the geometry of the
%blade without any discrepencies. It is then multiplied by the twist angle
%which results in the geometry of the blade
load ('airfoil.mat')

for i = 1:17
    A_A = A(:,1).*chord(i);
    A_B = A(:,2).*chord(i);
    R_R = ones(1,length(A_A))*radius(i);
    
    plot = plot3(A_A, A_B,R_R);
    xlabel('Horizontal component of blade [m]');
    ylabel('Vertical component of blade [m]');
    zlabel('Radial Positions [m]');
    title('Geometry of Airfoil with respect to Every Radial Position of the Blade');
    hold on;
    rotate(plot, [0 0 1], twist(i));
end

end

