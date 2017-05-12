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
dt = 2 * pi / double(s);
for i = 1:s
  t = dt * (i-1);
  x = sin(t);
  u = dt * cos(t);
  y = cos(t);
  v = -dt * sin(t);
  z = (i-1)/double(s);
  w = 1/double(s) / dt;
  
  quiver3(x,y,z,u,v,w, 0, 'b');
  
end
axis image;