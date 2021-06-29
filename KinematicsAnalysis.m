%% KINEMATICS OF SELECTED GRIPPER
% 
clear
close all
syms deltaX real;

%% 0 Step: What we have
AB = 38;
BG = 11.296; 
GC = 29.384; % that give us 
CE = 45.7;
FE  = 30;
DF = 30.9;
AO = 35.6 + deltaX;
OC = 50.261;
ugol1 = 142.5*pi/180;

BC = sqrt(GC^2 + BG^2 - 2*GC*BG*cos(ugol1));
angle6 = asin(BG/BC*sin(ugol1));

AC = sqrt(AO^2+OC^2);
disp(AC)

angle8 = atan(AO/OC);

angle7 = acos((AC^2 + BC^2 - AB^2)/(2*AC*BC));

angle2 = 90 - (angle7+angle8+angle6);
Cx = 0;
Cy = -OC;
eY = Cy - CE*sin(angle2);
eX = Cx - CE*cos(angle2);
%% 3rd Step: Velocities and Accelerations for all points

% velocity of Joint E
vEY = diff(eY);
vEX = diff(eX);

% acceleration of Joint E
aEY = diff(vEY);
aEX = diff(vEX);
%% 4th Step: Show Values of Joint E (or we consider it as an endeffector

disp("Print X pos of E:")
disp(eX)

disp("Print Y pos of E:")
disp(eY)

%disp("Print velocity of E:")
%disp(vE)

%disp("Print acceleration of E:")
%disp(aE)

%% graphs: 

deltaX = 0;
count = 0;

eX1 = [];
eY1 = [];

eAX1 = [];
eAY1 = [];

eVX1 = [];
eVY1 = [];

Ax = deltaX;
Ay = 0;


Gx = cos(angle2)*GC+Cx;
Gy = sin(angle2)*GC+Cy;


Bx = cos(pi - angle2)*BG+Gx;
By = sin(pi - angle2)*BG+Gy;

Dx = eX - DF*cos(angle2);
Dy = eY - DF*sin(angle2);

Fx = eX;
Fy = eY*FE;

for c = 0:70
     deltaX = c;

     eX1 = [eX1 eval(eX)];
     eY1 = [eY1 eval(eY)];
     disp(eval(eX));
     disp(eval(eY))

     eVX1 = [eVX1 eval(vEX)];
     eVY1 = [eVY1 eval(vEY)];
     
     eAX1 = [eAX1 eval(aEX)];
     eAY1 = [eAY1 eval(aEY)];
     
%%     bX = eval(simplify(aX + AB*cos(alpha)));
 %%    bY = eval(simplify(aY - AB*sin(alpha))); 
     
%%     dX = eval(simplify(cX + CD*cos(gamma)));
 %%    dY = eval(simplify(cY + CD*sin(gamma)));

     
     figure(10)

     plot([deltaX, eval(Bx), eval(Gx), Cx, eval(eX), eval(Fx), eval(Dx)], [Ay, eval(By), eval(Gy), Cy, eval(eY), eval(Fy), eval(Dy)]);     
   %  xlim([-30 -25])
    % ylim([-16 -10])

   %   pause(0.01)
     
     count = count + 1;
end

w = linspace(0,(count-1), count);


figure(1)
plot(w,eX1,'b');
hold on;
plot(w,eY1,'r');
hold off;
xlabel('distance, mm')
ylabel('eX and eY of E')

figure(2)
plot(w,eVX1,'b');
hold on;
plot(w,eVY1,'r');
hold off;
xlabel('distance, mm')
ylabel('vX and vY of E')

figure(3)
plot(w,eAX1,'b');
hold on;
plot(w,eAY1,'r');
hold off;
xlabel('distance, mm')
ylabel('Accel of xE and yE')
