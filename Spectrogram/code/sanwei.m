function varargout = sanwei(varargin)
% SANWEI M-file for sanwei.fig
%      SANWEI, by itself, creates a new SANWEI or raises the existing
%      singleton*.
%
%      H = SANWEI returns the handle to a new SANWEI or the handle to
%      the existing singleton*.
%
%      SANWEI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SANWEI.M with the given input arguments.
%
%      SANWEI('Property','Value',...) creates a new SANWEI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sanwei_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sanwei_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sanwei

% Last Modified by GUIDE v2.5 01-Mar-2012 15:09:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sanwei_OpeningFcn, ...
                   'gui_OutputFcn',  @sanwei_OutputFcn, ...
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


% --- Executes just before sanwei is made visible.
function sanwei_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sanwei (see VARARGIN)

% Choose default command line output for sanwei
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sanwei wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sanwei_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

clear all;
[filename,pathname]=uigetfile({'.wav'},'select picture');  
waveFile=filename;
[Sg,Fs]=wavread(waveFile);               %sr is sample rate
 Winsiz = 256;
 Shift = 32;
 Base = 0;
% Mode = ;
% Gray = ;


n = floor((length(Sg) - Winsiz)/Shift)+1;
A = zeros(Winsiz/2+1 , n);
for i = 1:n
    n1 = (i-1)*Shift + 1;
    n2 = n1 + Winsiz - 1;
    s = Sg(n1:n2);
    s = s.*hanning(Winsiz);

    z = fft(s);
    z = z(1:(Winsiz/2)+1);
    z = z.*conj(z);
    z = 10 * log10(z);
    A(:,i) = z;
end

L0 = (A > Base);
L1 = (A < Base);
B = A.*L0 + Base*L1;
L = (B-Base)./(max(max(B))-Base);

y = [0:Winsiz/2]*Fs/Winsiz;
x = [0:n-1]*Shift/1000;

figure(1)
mesh(x,y,A);
xlabel('time(s)');
ylabel('frequency(Hz)');
zlabel('decibel(db)');
title('mesh plot');


%colormap('default');


% if Mode == 1
%     colormap('default');
% else
%     mymode = gray;
%     mymode = mymode(Gray:-1:1);
%     colormap(mymode);
% end

%imagesc(x,y,L);
%axis xy;
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
clear all;
[filename,pathname]=uigetfile({'.wav'},'select picture');  
waveFile=filename;
[x,sr]=wavread(waveFile);              
if (size(x,1)>size(x,2))                      
    x=x';
end
s=length(x);
w=round(44*sr/1000);                    
n=w;                                  
ov=w/2;                               
h=w-ov;
% win=hanning(n)';                      
win=hamming(n)';                       
c=1;
ncols=1+fix((s-n)/h);                     
d=zeros((1+n/2),ncols);
for b=0:h:(s-n)
    u=win.*x((b+1):(b+n));
    t=fft(u);
    d(:,c)=t(1:(1+n/2))';
    c=c+1;
end
tt=[0:h:(s-n)]/sr;
ff=[0:(n/2)]*sr/n;
figure(2)
imagesc(tt/1000,ff/1000,20*log10(abs(d)));
colormap(gray);

axis xy
xlabel('time(s)');
ylabel('frequency(kHz)');

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
clear;
clc;
[filename,pathname]=uigetfile({'.wav'},'select picture');  
waveFile=filename; 
[y, fs, nbits] = wavread(waveFile);
wavplay(y,fs);         
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
cData=imread('tongji.jpg');
image(cData);
axis off;
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
