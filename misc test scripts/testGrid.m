clear all
close all
f1 = figure;
clf; hold on; grid on;box on;
axis auto;

scrsz = get(0,'ScreenSize');
figsz = get(f1, 'OuterPosition');
set(f1, 'Position', [(scrsz(3)-figsz(3)) (scrsz(4)-figsz(4)) figsz(3) figsz(4)]);
Tr = view(3);

minRange = .33333;
nP = 27;

mP = ceil(nthroot(nP, 3));

uP = (mP - 1) / 2 * minRange;
lP = -(mP - 1) / 2 * minRange;
sScale = [lP:minRange:uP];
sGrid = zeros (mP, mP, mP);

for i = 1:nP
  while true
    s = randi(mP, [1,3]);
    if (sGrid(s(1), s(2), s(3)) == 0)
      X(i) = sScale(s(1));
      Y(i) = sScale(s(2));
      Z(i) = sScale(s(3));
      sGrid(s(1), s(2), s(3)) = 1;
      break
    end
  end
end


axis equal
scatter3 (X, Y, Z, 'filled');
labels = cellstr(num2str([1:nP]'));
text(X, Y, Z, labels, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')
xlim ([lP, uP]); ylim ([lP, uP]); zlim ([lP, uP]);
%xMinorTick = 'off'; yMinorTick = 'off'; zMinorTick = 'off';

Q = [X;Y;Z]';
dist = sqrt(bsxfun(@minus,Q(:,1),Q(:,1)').^2 + bsxfun(@minus,Q(:,2),Q(:,2)').^2 + bsxfun(@minus,Q(:,3),Q(:,3)').^2);
min(triu(dist,0))
