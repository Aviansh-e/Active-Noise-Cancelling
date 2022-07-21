#   Active-Noise-Cancelling -  
##  Characterstic of the Noise

(1) Here i have written the code in the for detecting the charactristic of the noise(like tonal noise,broadband noise,acoustic noise etc...).
  
  
  **Time Plot-**           Time Plot-It gives the how the amplitude of Noises is changing over the time.
   
  **->FFT-**                It stand for the Fast Dourier Transform,bascically it convert the signal from time domain to frequency domain
                            -here i have plotted the graph between the magnitude of Amplitude(fft) and frequency domain.
                            -here peak gives us the information is that how much that frequency is present in the original signal.
   
   **->MelSpectrogram**  -If the signal is non-periodic or fluctuate with the each instant of time,to compute the spectrum we will use of the short time FT overlapped                           called MelSpectrogram.
                         -Mel- it is a type of scale for reading the higher frequency .it is the logarithmic transformation of a signal frequency.
                         -Formula to convert from frequency to Mel scale(m) =1127(log(1+f/700) in decibel
                        - For Frequency=700(10^(m/2595)-1) in hertz.
    
    **->Phase Plot-**  This is the very important characteristic of a sound wave in the phase .phase specify that location ot timing of a point within a wave cycle.
                         -it also help in determining the which noise is it by simply looking its plot.
    
   **-> Power Spectrum-**   From it we finding the Fault to that frequency or 1st Harmonic 2nd harmonic and so on..
                          -side band shows around that frequency is Fault .
                          -Highest Peak Represent the its Harmonics.
                          -formula for PSD =IFT. 
               
                         #FSLMS
    ***1*** To deal with the non-linear noise signal,fslms come in to the picture,
    ***2*** it consist of non-linear controlled structure ,where as primary path is the acoustic path from the input microphone to the cancelling laudspeaker.
    
    ### Working of the algorithm 
       - first we deal with the primary path which is the desired signal.
       - then we will have multiple channel,where we will send the noises in such way that:- if the lenght of channel is count as even then it noise will passed as               *sin(j*x(n)*pi)*, for the odd it will passed as the *cos(j*x(n)*pi)*.
       -then *weight* come into the picture as a parameter.
       - *weight* get updated using the **gradient descent** algorithm.
       -** secondary path ** provide a flexibility in cancelling the noise.
    
                      
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
