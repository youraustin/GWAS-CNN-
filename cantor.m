function s = cantor(n)

% Start in the top left corner.
s = zeros(n,n);

k = 1;
d = 1;
v = 1;
total=n*n
for p = 1:total
   s(k,d)=p;
   if k==1&&v==1
       d=d+1;
       v=0;
       if d>n
           d=d-1;
           k=k+1;
       end
   elseif d==1&&v==0
       k=k+1;
       v=1;
       if k>n
           k=k-1;
           d=d+1;
       end
   elseif v==0
       k=k+1;
       d=d-1;
       if k>n
           k=k-1;
           d=d+2;
           v=1;
       end
   else
       k=k-1;
       d=d+1;
       if d>n
           d=d-1;
           k=k+2;
           v=0;
       end
   end
end
end