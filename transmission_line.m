function project2()

clc; close all;

% Collect user input
q = {'D (cm):','n (subconductors per phase):','d (cm):','r (cm):'};
a = inputdlg(q,'Transmission Line');

if isempty(a)
    return
end

% Parse input and convert cm to metres
D = str2double(a{1})/100;
n = round(str2double(a{2}));
d = str2double(a{3})/100;
r = str2double(a{4})/100;

% Validate input
if any(isnan([D n d r])) || D<=0 || r<=0 || n<1 || (n>1 && d<=0)
    errordlg('Invalid input');
    return
end

% Phase spacing (horizontal, transposed arrangement)
Dab = D;
Dbc = D;
Dac = 2*D;
GMD = (Dab*Dbc*Dac)^(1/3);

% Effective (GMR) conductor radius
rp = 0.7788*r;

% Bundle-equivalent radius for L and C
Ds_L = bundleEq(n, d, rp);
Ds_C = bundleEq(n, d, r);

% Inductance and capacitance
L = 2e-7 * log(GMD / Ds_L);
C = 2*pi*8.854e-12 / log(GMD / Ds_C);

% Convert to conventional units
L_mHkm = L * 1e6;
C_nFkm = C * 1e12;

% Show the result
msgbox(sprintf('L = %.4f mH/km\nC = %.3f nF/km', ...
    L_mHkm, C_nFkm), 'Result');

end


function Ds = bundleEq(n, d, rself)
% Compute the bundle-equivalent radius
% Assumes sub-conductors are evenly spaced around a circle

if n == 1
    Ds = rself;
    return
end

% Radius of the bundle circle
Rb = d / (2*sin(pi/n));

% Product of distances between sub-conductors
p = 1;
for k = 1:(n-1)
    Dik = 2*Rb*sin(pi*k/n);
    p = p * Dik;
end

Ds = (rself * p)^(1/n);

end
