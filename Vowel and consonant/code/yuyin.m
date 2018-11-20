function varargout = yuyin(varargin)
% YUYIN M-file for yuyin.fig
%      YUYIN, by itself, creates a new YUYIN or raises the existing
%      singleton*.
%
%      H = YUYIN returns the handle to a new YUYIN or the handle to
%      the existing singleton*.
%
%      YUYIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in YUYIN.M with the given input arguments.
%
%      YUYIN('Property','Value',...) creates a new YUYIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before yuyin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to yuyin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help yuyin

% Last Modified by GUIDE v2.5 18-Sep-2013 16:47:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @yuyin_OpeningFcn, ...
                   'gui_OutputFcn',  @yuyin_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before yuyin is made visible.
function yuyin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to yuyin (see VARARGIN)

% Choose default command line output for yuyin
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes yuyin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = yuyin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'.wav'},'select picture');  %choose the path of voice data
waveFile=filename; 
[y, fs, nbits] = wavread(waveFile); 
time1=1:length(y); 
time=(1:length(y))/fs; 
wavplay(y,fs);         
frameSize=floor(fs/30);               
startIndex=round(2500);                 
endIndex=startIndex+frameSize-1;          
frame = y(startIndex:endIndex);            
frameSize=length(frame);

figure(1); 
subplot(3,1,1); 
plot(time1, y); 
title('speech waveform'); 
axis([0,20064,-0.2,0.2]);
ylim=get(gca, 'ylim'); 
line([time1(startIndex),time1(startIndex)],ylim,'color','r');
line([time1(endIndex), time1(endIndex)],ylim,'color','r');
xlabel('amount of sample points');
ylabel('amplitude(dB)');

subplot(3,1,2); 
plot(frame); 
axis([0,400,-0.2,0.2])
title('speech per frame'); 
xlabel('amount of sample points');
ylabel('amplitude(dB)')

subplot(3,1,3);
Y=fft(frame);
X=log10(abs(Y));
N=length(X);
f=(0:N/2-1)*fs/N;  %calculate the frequency scale
[up,down] = envelope(f,X(1:N/2),'linear'); %function envelope will calculate the envelope
plot(f,X(1:N/2),f,up,'r');
axis([0,4000,-2,2])
title('spectrogram');
ylabel('amplitude£¨dB£©');
xlabel('frequency£¨Hz£©');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'.wav'},'select picture');  
waveFile=filename; 
[y, fs, nbits] = wavread(waveFile); 
time1=1:length(y); 
time=(1:length(y))/fs; 
wavplay(y,fs);          
frameSize=floor(fs/30);            
startIndex=round(4500);                   
endIndex=startIndex+frameSize-1;           
frame = y(startIndex:endIndex);            
frameSize=length(frame);

figure(1); 
subplot(3,1,1); 
plot(time1, y); 
title('speech waveform'); 
axis([0,6000,-0.6,0.6]); 
ylim=get(gca, 'ylim'); 
line([time1(startIndex),time1(startIndex)],ylim,'color','r');
line([time1(endIndex), time1(endIndex)],ylim,'color','r');
xlabel('amount of sample points');
ylabel('amplitude(dB)');

subplot(3,1,2); 
plot(frame); 
axis([0,400,-0.5,0.5])
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

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'.wav'},'select picture');  
waveFile=filename; 
[y, fs, nbits] = wavread(waveFile); 
time1=1:length(y); 
time=(1:length(y))/fs; 
wavplay(y,fs);         
frameSize=floor(fs/30);              
startIndex=round(2500);                  
endIndex=startIndex+frameSize-1;         
frame = y(startIndex:endIndex);            
frameSize=length(frame);

figure(1); 
subplot(3,1,1); 
plot(time1, y); 
title('speech waveform'); 
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

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'.wav'},'select picture');  
waveFile=filename; 
[y, fs, nbits] = wavread(waveFile); 
time1=1:length(y); 
time=(1:length(y))/fs; 
wavplay(y,fs);        
frameSize=floor(fs/30);              
startIndex=round(4200);                  
endIndex=startIndex+frameSize-1;          
frame = y(startIndex:endIndex);            
frameSize=length(frame);

figure(1); 
subplot(3,1,1); 
plot(time1, y); 
title('speech waveform'); 
axis([0,6000,-0.6,0.6]);
ylim=get(gca, 'ylim'); 
line([time1(startIndex),time1(startIndex)],ylim,'color','r');
line([time1(endIndex), time1(endIndex)],ylim,'color','r');
xlabel('amount of sample points');
ylabel('amplitude(dB)');

subplot(3,1,2); 
plot(frame); 
axis([0,400,-0.5,0.5])
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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'.wav'},'select picture'); 
waveFile=filename; 
[y, fs, nbits] = wavread(waveFile); 

global ao currentSample;
ao = analogoutput('winsound');                      %establish an object of sound card device
nChannel = size(data, 2);
addchannel(ao, 1 : nChannel);                                
set(ao, 'SampleRate', Fs);     
set(ao, 'BitsPerSample', nBits);
putdata(ao, data); 
timerFcn = ['if get(ao, ''SamplesAvailable'') < get(ao, ''SampleRate''),',...
        'putdata(ao, data);',...
        'end'];
set(ao, 'TimerPeriod', 0.95, 'TimerFcn', timerFcn);
stopFcn = 'global ao currentSample, currentSample = get(ao, ''SamplesOutput'');';
set(ao, 'stopFcn', stopFcn);
start(ao);     




% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)

% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
cData=imread('tongji.jpg');
image(cData);
axis off;
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes5


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
