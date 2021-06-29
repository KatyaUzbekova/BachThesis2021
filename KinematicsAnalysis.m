%% KINEMATICS OF SELECTED GRIPPER
% 
clear
close all
syms w real;
%% 0 Step: What we have
PC = 2;
h = 1; % from 1 to 2 
OA = 5; % that give us 
AB = 5;
BC  = 3;
DE = 2;

FE = 10;
CD = FE; 
aX0 = 0.4;


cX = AB + sqrt(BC^2 - PC^2);
cY = OA + PC;

beta0 = asin(PC/BC);


fX = 12;
fY = 2 ; % we think as an example

%% 1 STEP
aX = aX0 - simplify(w/2/3.1416 * h);
aY = OA;

AP = cX - aX;
AC = simplify(sqrt(PC*PC + AP*AP));
fi = simplify(asin(PC/AC));

% cosinus theorem:
abc = simplify(acos((AB*AB + BC*BC - AC*AC)/2/AB/BC));
% by sinus theorem
ugolA = simplify(asin(BC/AC * sin(abc)));


% angles alpha and beta
alpha = ugolA - fi;
beta = 3.1416 - abc - alpha;
gamma = beta - beta0;


eY = fY + FE*sin(gamma);
eX = fX + FE*cos(gamma);
%% 3rd Step: Velocities and Accelerations for all points

% velocity of Joint E
vEY = diff(eY);
vEX = diff(eX);

% acceleration of Joint E
aEY = diff(vEY);
aEX = diff(vEX);
%% 4th Step: Show Values of Joint E (or we consider it as an endeffector

disp("Print X pos of E:")
disp(simplify(eX))

disp("Print Y pos of E:")
disp(eY)

%disp("Print velocity of E:")
%disp(vE)

%disp("Print acceleration of E:")
%disp(aE)

%% graphs: 

w = 0;
count = 0;

eX1 = [];
eY1 = [];

eAX1 = [];
eAY1 = [];

eVX1 = [];
eVY1 = [];

for c = 0:130
     w = c*0.06;

     eX1 = [eX1 eval(eX)];
     eY1 = [eY1 eval(eY)];
     
     eVX1 = [eVX1 eval(vEX)];
     eVY1 = [eVY1 eval(vEY)];
     
     eAX1 = [eAX1 eval(aEX)];
     eAY1 = [eAY1 eval(aEY)];
     
     bX = eval(simplify(aX + AB*cos(alpha)));
     bY = eval(simplify(aY - AB*sin(alpha))); 
     
     dX = eval(simplify(cX + CD*cos(gamma)));
     dY = eval(simplify(cY + CD*sin(gamma)));

     
     figure(10)
     plot([eval(aX) bX cX dX eval(eX) fX],...
         [aY bY  cY dY  eval(eY) fY]);
     xlim([0 25])
     ylim([0 25])

    %% pause(0.01)
     
     count = count + 1;
end

w = linspace(0,(count-1), count);


figure(1)
plot(w,eX1,'b');
hold on;
plot(w,eY1,'r');
hold off;
xlabel('angle, rad')
ylabel('eX and eY of E')

figure(2)
plot(w,eVX1,'b');
hold on;
plot(w,eVY1,'r');
hold off;
xlabel('angle, rad')
ylabel('vX and vY of E')

figure(3)
plot(w,eAX1,'b');
hold on;
plot(w,eAY1,'r');
hold off;
xlabel('angle, rad')
ylabel('Accel of xE and yE')