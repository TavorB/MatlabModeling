
dist = 1.5;
resolution = 0.1 ;
xRange = -dist:resolution:dist;
yRange = -dist:resolution:dist;

[X,Y] = meshgrid(xRange,yRange);

morewires = 'Y';
xPos = [];
yPos = [];
wI = [];
% 
% while (morewires == 'Y'),
%    replyxPos = input('What is this wires xPos (-3,3)? [0]: ');
%    if isempty(replyxPos)
%       replyxPos = 0;
%    end
%    xPos = [xPos replyxPos];
%    
%    replyyPos = input('What is this wires yPos (-3,3)? [0]: ');
%    if isempty(replyyPos)
%       replyyPos = 0;
%    end
%    yPos = [yPos replyyPos];
%    
%    replycharge = input('What is this wires current? [0]: ');
%    if isempty(replycharge)
%       replycharge = 0;
%    end
%    wI = [wI replycharge];
%    
%    morewires = input('Add more wires (Y/N)? [Y]: ','s');
%    if isempty(morewires)
%       morewires = 'Y';
%    end
%    
% end
% Wires
xPos = [1 -1];
yPos = [0 0];
wI = [1 -1] ;

Bx = zeros(size(X));
By = zeros(size(Bx));
Pot = zeros(size(Bx));

for ii=1:length(xPos),
    I = wI(ii);
    x = xPos(ii);
    y = yPos(ii);
    
    r = ( (X-x).^2+ (Y-y).^2 ).^0.5 ;
    r(r<0.05) = 0.05;
    
    B = I./ r;
    Bx = Bx - B .* ((Y-y)./ r );
    By = By + B .* ((X-x)./ r );
    
    
    
end

% dRes = 10 ;
% FxDraw = Bx(1:dRes:end,1:dRes:end) ;
% FyDraw = By(1:dRes:end,1:dRes:end) ;
% XDraw =  X(1:dRes:end,1:dRes:end) ;
% YDraw =  Y(1:dRes:end,1:dRes:end) ;


% figure
% imagesc(By0);

figure
hold on
quiver(X,Y,Bx,By)
% quiver(XDraw,YDraw,FxDraw,FyDraw)
colormap hsv
plot(xPos(1:2),yPos(1:2),'ro');
colorbar vert;

hold off


