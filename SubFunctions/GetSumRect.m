function PixelSum=GetSumRect(IntegralImage,x,y,Width,Height,Channel)

n = length(x);
PixelSum = zeros(n,1);
for ii=1:n
    PixelSum(ii)  =   IntegralImage(y(ii) + Height(ii)+1,(x(ii)+Width(ii)+1), Channel) +  ...
                  IntegralImage(y(ii)+1,x(ii)+1,Channel) - ...
                  IntegralImage(y(ii)+1,x(ii)+Width(ii)+1,Channel) - ...
                  IntegralImage(y(ii)+Height(ii)+1,x(ii)+1,Channel);
end

            
       