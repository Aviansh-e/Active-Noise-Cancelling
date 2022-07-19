
input_file =Bandsaw2;       % here we can put the file name of the noise data

y = input_file.VarName2;    %here we will give the name of the columns from the file


phase_y = [0; y(1:end-1)];  %extracting all the columns


                                                                       
Ts= input_file.Curve1(2);
Fs = 1/Ts;

Fn = Fs/2;                                              
L = size(y,1);                                          
t = linspace(0, 1, L);                                  
FTd = fft(y)/L;                                         
Fv = linspace(0, 1, fix(L/2)+1)*Fn;                     
Iv = 1:length(Fv);    

p = pspectrum(y,Fs);

spect = melSpectrogram(y,Fs);

tiledlayout(3,2)

%time plot
nexttile
plot(y)
title('time-plot')

% phase plotting
nexttile
plot(y,phase_y)
title('phase plot')

% fft plotting
 nexttile
 plot(Fv, abs(FTd(Iv))*2)
 title('fft')
 xlabel('Frequency');
ylabel('Amplitude');

%power spectrum
nexttile
plot(p)
title('power spectrum')
ylabel('PDL');
xlabel('frequency(Hz)');

%mel spectrum
nexttile
melSpectrogram(y,Fs)
title('mel spectrogram')
xlabel('Time(sec)');
ylabel('Frequency(Hz)');
