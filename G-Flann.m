clc;
close all;

t = 0.001:0.001:1;

 
M = 10;
mu = 0.526;

%file=Bandsaw2;
%X_s=file.Curve1-file.VarName2;

X_s=sin(2*pi*80*t);
N =length(X_s);
primary_resp = IMPULSE1(1,[1, 2, 10],0.001,0.1,1)';
secondary_resp = IMPULSE1(1,[1.5, 2.5, 20],0.001,0.1,1)';
y_sec=secondary_resp';

w=zeros(M,M);
%t=0:0.01:10;
%X_s=3*sin(2*pi*50*t+pi*.3)';
%N=length(X_s);
x_af = zeros(1,N);
x_buff = zeros(1,M);

x_xs=zeros(M,M);
y_ww1=zeros(M,M);
%M=20; % assuming the length of channel
wet=zeros(M,M);
cin=zeros(M,1);


err=zeros(N,1);
%err=zeros(N,1);
y_outt=zeros(N,1);
for i = 1:N
    x_buff = [X_s(i) x_buff(1:end-1)];
    x_af(i) = sum(primary_resp.*x_buff);
end

for j=1:N
    cin=[X_s(j);cin(1:M-1)];
    y_w1=zeros(M,1); %it store the y1,y2,y3...
    for i=1:M
        if(i==1)
            wet(:,i)=[X_s(j);wet(1:M-1,i)];
            y_w1(i)= sum(wet(:,i).*w(:,i));
        elseif(i==2)
            wet(:,i)=[X_s(j);wet(1:M-1,i)];
            y_w1(i)= sum(wet(:,i).*w(:,i));
        elseif(i==3)
            wet(:,i)=[X_s(j);wet(1:M-1,i)];
            y_w1(i)= sum(wet(:,i).*w(:,i));
        else
            if(rem(j,2)==0)
                wet(:,i)=[cin(i)*sin(pi*X_s(j));wet(1:M-1,i)];
                y_w1(i)= sum(wet(:,i).*w(:,i));
            else
               wet(:,i)=[cin(i)*cos(pi*X_s(j));wet(1:M-1,i)];
               y_w1(i)= sum(wet(:,i).*w(:,i));
            end
        end
    end
    y_outt(j)=sum(y_w1);                                   %basically it will guve the sum of y(1),y(2)...
        
    for j=1:M
        if j==1
            x_xs(:,j)=[wet(j,j); x_xs(1:M-1,j)];
            y_ww1(:,j)= [sum(x_xs(:,j).*y_sec); y_ww1(1:M-1,j)];
        end    
        if (rem(j,2)==0)
            x_xs(:,j)=[wet(j,j); x_xs(1:M-1,j)];            
            y_ww1(:,j)= [sum(x_xs(:,j).*y_sec); y_ww1(1:M-1,j)];
        end
        if(rem(j,2)==1)
            x_xs(:,j)=[wet(j,j); x_xs(1:M-1,j)];            
            y_ww1(:,j)=[sum(x_xs(:,j).*y_sec); y_ww1(1:M-1,j)];
        end
    end
        
     err(j) = x_af(j) - y_outt(j);
    %for updating the weight of array N X N
    for k=1:M
        w(:,k)=w(:,k)-mu*err(j)*y_ww1(:,k);
    end
          
end

plot(x_af,'Black');
hold on;
plot(y_outt,'Yellow');
hold on;
plot(err,'Red');
title("Generalized FLANN");
xlabel("Time");
ylabel("Amplitude");
legend("Noise signal","Counter signal","Error signal")
hold off;

function sys3 = IMPULSE1(num,den,Ti,Ts,Tf)

    sys = tf(num, den);
    
    sys3 = impulse(sys,Ti:Ts:Tf);

end
