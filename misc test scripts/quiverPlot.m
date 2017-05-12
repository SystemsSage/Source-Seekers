% quiver3(x,y,z,u,v,w)

clear all
close all

f1 = figure;
clf; hold on; grid on;box on;
axis auto; 

scrsz = get(0,'ScreenSize');
figsz = get(f1, 'OuterPosition');
set(f1, 'Position', [(scrsz(3)-figsz(3)) (scrsz(4)-figsz(4)) figsz(3) figsz(4)]);
Tr = view(3);

% x = rand(10,1);
% y = rand(10,1);
% z = rand(10,1);
% 
% u = rand(10,1)/20*pi;
% v = rand(10,1)/20;
% w = rand(10,1)/20;

s = 20;
x = zeros(s, 1);
y = zeros(s, 1);
z = zeros(s, 1);
dt = 2 * pi / double(s);
for i = 1:s
  t = dt * (i-1);
  x(i) = sin(t);
  y(i) = cos(t);
  z(i) = (i-1)/double(s);
end

u = gradient(x, dt);
v = gradient(y, dt);
w = gradient(z, dt);

quiver3(x,y,z,u,v,w, 0);
plot3(x,y,z,'g');
axis image;