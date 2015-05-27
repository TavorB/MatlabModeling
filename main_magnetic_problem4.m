dist = 1.5;
resolution = 0.1 ;
xRange = -dist:resolution:dist;
yRange = -dist:resolution:dist;

[X,Y] = meshgrid(xRange,yRange);

morewires = 'Y';
xPos = [];
yPos = [];
wI = [];


% Wires
xPos = [1 1 -1 -1]; %outwards is positive
yPos = [1 -1 -1 1];
wI = [1 1 -1 -1] ;

Bx = zeros(size(X));
By = zeros(size(Bx));
Pot = zeros(size(Bx));

for ii=1:length(xPos),
    I = wI(ii);
    x = xPos(ii);
    y = yPos(ii);
    
    r = ( (X-x).^2+ (Y-y).^2 ).^0.5 ;
%     r(r<0.05) = 0.05;
    
    B = I./ r;
    Bx = Bx - B .* ((Y-y)./ r );
    By = By + B .* ((X-x)./ r );
    
    
    
end



% Y0 = (Y==0); 
% By0 = By.*Y0 ;
% Bx0 = Bx.*Y0;

ind = find(Y==0);
Byind = By(ind) ;
Bxind = Bx(ind);
Xind = X(ind);
Yind = Y(ind);


Fx = -Byind;
Fy = Bxind;


% figure
% hold on
% title('Total Magnetic Field');
% quiver(X,Y,Bx,By, 'k')
% plot(xPos(1:2),yPos(1:2),'ro');
% plot(xPos(3:4),yPos(3:4),'rx');
% colormap hsv
% hold off
% 
% 
% figure
% hold on
% title('Magnetic Field at center');
% quiver(X,Y,Bx0,By0, 'k')
% plot(xPos(1:2),yPos(1:2),'ro');
% plot(xPos(3:4),yPos(3:4),'rx');
% colormap hsv;
% hold off



figure
hold on
quiver(X,Y,Bx,By, 'b');
quiver(Xind,Yind,Bxind,Byind, .4 , 'k');
quiver(Xind,Yind,Fx,Fy, .1, 'r')
colormap hsv
plot(xPos(1:2),yPos(1:2),'ro');
plot(xPos(3:4),yPos(3:4),'rx');
% colorbar vert;
legend('overall magnetic field', 'central magnetic field', 'force');
hold off


