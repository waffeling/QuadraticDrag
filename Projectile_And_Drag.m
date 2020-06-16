%% Creates a Graph for a baseball's flight without drag
clear; 
clc;
velnaught = input("Enter the ball's initial velocity: ");
angle = input("Enter the angle of ascent: ");

Xdistance = linspace(1,75,150);

vynaught = velnaught * sin((angle*(3.14/180)));
vxnaught = velnaught * cos((angle*(3.14/180)));
g = 9.81 ; 
Acceleration = -0.5 * g * (Xdistance/vxnaught).^2;
Velocity = vynaught* (Xdistance/vxnaught);
Yposition = Acceleration + Velocity;
plot(Xdistance,Yposition);

%% Creates the prior graph along with a graph for the baseball's flight with quadratic drag

clear; 
clc;

diameter = (input("Please enter the diameter of the ball: "));
mass = (input("Please enter the mass of the ball: "));
velnaught = (input("Please enter the initial speed of the ball: "));
angle = (input("Please enter the angle of ascent: ")); 
time = input("For how long would you like to see the objects flight? ");
step = input("How big would you like you Euler step size to be? ");

vynaught = velnaught * sind(angle);
vxnaught = velnaught * cosd(angle);
g = 9.81 ; 
cvalue = 0.25 * diameter^2;
range = (velnaught^2 * sind(2*angle)^2)/g;


%Creates Graph for baseball without drag
Xdistance = [];
Yposition = [];
cT1 = [];
for t = 0:step:time
    xdistance = vxnaught*t;
    yposition = (vynaught*t) - (0.5 * g * t^2);
    Xdistance = [Xdistance, xdistance];
    Yposition = [Yposition, yposition];
    cT1 = [cT1, t];
end
figure(1);
plot(Xdistance,Yposition);
ylim([-0.1, inf])
title("Plot for ball without drag");


%Creates graph for baseball with drag using Euler's Method for Systems


vx = vxnaught;
vy = vynaught;
x = 0;
y = 0;
xdisplacement = 0;
ydisplacement = 0;

gamma = cvalue / mass;



Vx = [vx];
Vy = [vy];
X = [x];
Y = [y];
cT= [0];
CT = [0];
for t = 0:step:time
  xacc = vdotx(vx, vy, gamma);
  yacc = vdoty(vx, vy, gamma); 
  newvx = xacc * (t - cT(length(cT))) + vx;
  newvy = yacc * (t - cT(length(cT))) + vy;
  newx = vx * (t - cT(length(cT))) + x;
  newy = vy * (t - cT(length(cT))) + y;
  Vx = [Vx, newvx];
  Vy = [Vy, newvy];
  X = [X, newx];
  Y = [Y, newy];
  
  
  x = newx;
  y = newy;
  vx = newvx;
  vy = newvy; 
  CT = [CT, t - cT(length(cT))];
  cT = [cT, t];  
end 
hold on
plot(X,Y)
title("Plot for ball with and without drag");
ylim([-0.1, inf])
hold off
function xacceleration = vdotx(vx, vy, gamma)
xacceleration = -gamma* vx *sqrt(vx^2 + vy^2);
end
function yacceleration = vdoty(vx, vy, gamma)
yacceleration = -9.8 - gamma* vy *sqrt(vx^2 + vy^2);
end
 