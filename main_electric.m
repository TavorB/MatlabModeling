
resolution = 0.01 ;
xRange = -3:resolution:3;
yRange = -3:resolution:3;

[X,Y] = meshgrid(xRange,yRange);

morecharges = 'Y';
xPos = [];
yPos = [];
cQ = [];

while (morecharges == 'Y'),
   replyxPos = input('What is this charges xPos (-3,3)? [0]: ');
   if isempty(replyxPos)
      replyxPos = 0;
   end
   xPos = [xPos replyxPos];
   
   replyyPos = input('What is this charges yPos (-3,3)? [0]: ');
   if isempty(replyyPos)
      replyyPos = 0;
   end
   yPos = [yPos replyyPos];
   
   replycharge = input('What is this charges charge? [0]: ');
   if isempty(replycharge)
      replycharge = 0;
   end
   cQ = [cQ replycharge];
   
   morecharges = input('Add more charges (Y/N)? [Y]: ','s');
   if isempty(morecharges)
      morecharges = 'Y';
   end
   
end
% charges
% xPos = [1 -1];
% yPos = [2 2];
% cQ = [1 -1] ;

Fx = zeros(size(X));
Fy = zeros(size(Fx));
Pot = zeros(size(Fx));

for ii=1:length(xPos),
    q = cQ(ii);
    x = xPos(ii);
    y = yPos(ii);
    
    r = ( (X-x).^2+ (Y-y).^2 ).^0.5 ;
    r(r<0.05) = 0.05;
    
    F = q./ r;
    Fx = Fx + F .* ((X-x)./ r );
    Fy = Fy + F .* ((Y-y)./ r );
    
    Pot = Pot + q.* log(r);
    
end

dRes = 10 ;
FxDraw = Fx(1:dRes:end,1:dRes:end) ;
FyDraw = Fy(1:dRes:end,1:dRes:end) ;
XDraw =  X(1:dRes:end,1:dRes:end) ;
YDraw =  Y(1:dRes:end,1:dRes:end) ;

figure;
contour(X,Y,Pot)
hold on
%quiver(X,Y,Fx,Fy)
quiver(XDraw,YDraw,FxDraw,FyDraw)
colormap hsv
plot(xPos,yPos,'rx');
colorbar vert;

hold off


