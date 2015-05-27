
dist = 1;
resolution = 0.01 ;
xRange = -dist:resolution:dist;
yRange = -dist:resolution:dist;
[X,Y] = meshgrid(xRange,yRange);

% charges
xPos = [.5 -.5];
yPos = [0 0];
cQ = [10 -10] ;

temp = (  ((X==xPos(1) ) .* (Y==yPos(1)) ) +  (  (X==xPos(2)).*(Y==yPos(2))) ) ;
temp = temp==1;

Fx = zeros(size(X));
Fy = zeros(size(Fx));
Fxt = zeros(size(X));
Fyt = zeros(size(Fx));
Pot = zeros(size(Fx));

dRes = 10 ;
% FxDraw = Fx(1:dRes:end,1:dRes:end) ;
% FyDraw = Fy(1:dRes:end,1:dRes:end) ;
XDraw =  X(1:dRes:end,1:dRes:end) ;
YDraw =  Y(1:dRes:end,1:dRes:end) ;



figure;
hold on;

plot(xPos(1),yPos(1), 'r.','MarkerSize',40);
plot(xPos(2),yPos(2), 'b.','MarkerSize',40);



for ii=1:length(xPos),
    q = cQ(ii);
    x = xPos(ii);
    y = yPos(ii);
    r = ( (X-x).^2+ (Y-y).^2 ).^0.5 ;
    r(r<0.05) = 0.05; %since F~1/r, very small r would make F--> infinity
    
    F = q./ r;
    Fx = F .* ((X-x)./ r );
    Fy = F .* ((Y-y)./ r );

    Fx(temp) =0;
    Fy(temp) =0;
    
    Fxt = Fxt + Fx;
    Fyt = Fyt + Fy;
    
    
    
    if ii == 1
        quiver(XDraw,YDraw, Fx(1:dRes:end,1:dRes:end), Fy(1:dRes:end,1:dRes:end), 'r');
    else
        quiver(XDraw,YDraw, Fx(1:dRes:end,1:dRes:end), Fy(1:dRes:end,1:dRes:end), 'b');
    end
    
    Pot = Pot + q.* log(r);
end

quiver(XDraw,YDraw,Fxt(1:dRes:end,1:dRes:end),Fyt(1:dRes:end,1:dRes:end),'k');


% Pot(abs(Pot)>1) = 5000;
v = [-20 -10 -5 0 5 10 20];
[cs, h] = contour(X,Y,Pot,v);
% clabel(cs, h);
legend('Positive Charge', 'Negative Charge', 'E field due to +', 'E field due to -', 'Total E field', 'Equipotential lines');
hold off;
