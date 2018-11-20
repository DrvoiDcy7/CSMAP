[filename,pathname]=uigetfile({'.wav'},'select picture');  
waveFile=filename; 
[y, fs, nbits] = audioread(waveFile); 
time1=1:length(y); 
time=(1:length(y))/fs; 
wavplay(y,fs);         
frameSize=floor(fs/300);            
startIndex=round(2500);                  
endIndex=startIndex+frameSize-1;        
frame = y(startIndex:endIndex);           
frameSize=length(frame);

figure(1); 
subplot(3,1,1); 
plot(time1, y); 
title('speech wavefom'); 
axis([0,8000,-0.7,0.7]); 
ylim=get(gca, 'ylim'); 
line([time1(startIndex),time1(startIndex)],ylim,'color','r');
line([time1(endIndex), time1(endIndex)],ylim,'color','r');
xlabel('amount of sample points');
ylabel('amplitude(dB)');

subplot(3,1,2); 
plot(frame); 
axis([0,400,-0.7,0.7])
title('speech per frame'); 
xlabel('amount of sample points');
ylabel('amplitude(dB)')

subplot(3,1,3);
Y=fft(frame);
X=log10(abs(Y));
N=length(X);
f=(0:N/2-1)*fs/N;  
[up,down] = envelope(f,X(1:N/2),'linear'); 
plot(f,X(1:N/2),f,up,'r');
axis([0,4000,-2,2])
title('spectrogram');
ylabel('amplitude£¨dB£©');
xlabel('frequency£¨Hz£©');