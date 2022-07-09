clear all;
t = 0.001:0.001:1;

x_r=5*sin(2*pi*80*t);

mn=length(x_r);
p= IMPULSE1(1,[1, 2, 10],0.001,0.1,1)';
y_sec = IMPULSE1(1,[1.5, 2.5, 20],0.001,0.1,1)';

x_buff = zeros(1,10);
x_af = zeros(1,mn);

sec=zeros(10,1);
for j=1:10
    sec(j)=y_sec(j);
end
% this is for the primary
for i = 1:mn
    x_buff = [x_r(i) x_buff(1:end-1)];
    x_af(i) = sum(p.*x_buff);
end

%this is for the secondary
x_2=zeros(10,1);
x_3=zeros(10,1);
 

%reference sig;

% for weight
N=50;
ww=zeros(N,1); % for storing the weight
x_1=zeros(N,1);
y_fi=zeros(N,1);

%for error and output

y_t=zeros(mn,1);
mu=10^-5;


for n=1:mn
    x_1=[x_r(n);x_1(1:N-1)];        %conv b/w weight and input
    y=sum(x_1.*ww);           
   
    x_2=[x_r(n); x_2(1:10-1)];      %conv b/w sec and input
    y_sout=sum(x_2.*sec);
    
    x_3=[y; x_3(1:10-1)];           %conv b/w y and sec
    out=sum(x_3.*sec);
    
    y_new(n)=out;
    err(n)=-x_af(n)+out;            %  finding the error

    y_fi=[y_sout;y_fi(1:N-1)]; 

    ww=ww-mu*err(n)*y_fi;           %updating the weight

    y_t(n)=out;               

end

plot(x_af, "black");
hold on;
plot(y_new, "yellow");
hold on;
plot(err,'red');
title('FsLMS')
ylabel('Amplitude')
xlabel('Time')
legend("Noise signal", "Counter signal","Error Signal");
hold off;

function sys3 = IMPULSE1(num,den,Ti,Ts,Tf)

    sys = tf(num, den);
    
    sys3 = impulse(sys,Ti:Ts:Tf);

end


