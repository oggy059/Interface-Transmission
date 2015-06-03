
function varargout = frequency_response1(varargin)
% FREQUENCY_RESPONSE1 MATLAB code for frequency_response1.fig
%      FREQUENCY_RESPONSE1, by itself, creates a new FREQUENCY_RESPONSE1 or raises the existing
%      singleton*.
%
%      H = FREQUENCY_RESPONSE1 returns the handle to a new FREQUENCY_RESPONSE1 or the handle to
%      the existing singleton*.
%
%      FREQUENCY_RESPONSE1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FREQUENCY_RESPONSE1.M with the given input arguments.
%
%      FREQUENCY_RESPONSE1('Property','Value',...) creates a new FREQUENCY_RESPONSE1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before frequency_response1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to frequency_response1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help frequency_response1

% Last Modified by GUIDE v2.5 03-Jun-2015 15:11:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @frequency_response1_OpeningFcn, ...
                   'gui_OutputFcn',  @frequency_response1_OutputFcn, ...
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


% --- Executes just before frequency_response1 is made visible.
function frequency_response1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to frequency_response1 (see VARARGIN)

% Choose default command line output for frequency_response1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes frequency_response1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = frequency_response1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Pbreceivedata.
function Pbreceivedata_Callback(hObject, eventdata, handles)

filename = handles.filename;
if strfind(filename,'bmp')> 0
    x=imread(filename);
    b = imnoise(x,'gaussian',0.00002);
    
    axes(handles.axes2);
    N=length(b);
    Q = b(1:2:N);
    I = b(2:2:N);
    Module = (abs(fft(Q + I)));
    
    Module=Module(1:length(Module)/2);
    plot((0:length(Module)-1)*(1/length(Module)),Module);
    
%     
%     fmin = 20;
%     fmax = 100;
%     BP = fmax - fmin;
%     N1 = N/2;
%     Fe = BP/(N1-1);
%     f = (fmin:Fe:fmax)*10^(9);
%     plot(f,Module)
     
    %b1=abs(fft(b));
    
   

    %Reponse impulsionnelle
    axes(handles.axes3);
    Te = 1/Fe;
    y=(fft(Module));
    %b2=abs(ifft(y));
    t = (0:Te:Te*(N1-1))*10^(-9);
    plot(t,y)

 %calcul de psnr 
 erreur=sum((x-b).^2);% erreur quadratique
 erreur1=mean(erreur);%erreur quadratique moyenne
 psnr=(10*log((255^2)/(erreur1)));%calcul de peak signal noise ratio en dB
 set(handles.psnr,'String',psnr);
% %Calcul de snr
P0=10;% Puissance de la constellation transmise
I=b(1:2:length(b)); %partie complexe de l'image reçue
Q=b(2:2:length(b));%partie réelle de l'image reçue
I_moy=(1/length(I))*sum(abs(I).^2);%partie complexe de l'image reçue moyenne
Q_moy=(1/length(Q))*sum(abs(Q).^2);%partie réelle de l'image reçue moyenne
EVM=(sqrt(I_moy+Q_moy)/P0);% vecteur erreur de modulation moyen
SNR=(10*log(1/EVM)^2);%snr en dB
set(handles.snr,'String',SNR);% affichage de SNR en dB
 


%  moy1=mean(x);% moyenne de l'image initiale
%  moy2=mean(b);% moyenne de l'image compressée
%  var=(1/length(x))*sum((moy1-moy2).^2);% la variance
%SNR=(10*log(var/erreur1));%snr en dB
%set(handles.snr,'String',SNR);% affichage de SNR en dB
 
 
x1=dec2bin(x);%pour rendre l'image émise en binaire 
b3 = dec2bin(b); %numeriser
[M1,N1]=size(b3);%definir la taille_ligne et taille_colonne
bit_error=0;
for i=1:M1
    for k=1:N1
        if x1(i,k)~=b3(i,k)% si les images sont différentes faire%
         bit_error=bit_error+1;
        end
    end
end
  
   
  bit_emis=M1*N1;
  Ber=(bit_error/bit_emis);%calcul de taux d'erreurs binaires
  set(handles.Trber,'String',Ber);% affichage de Ber en dB
 
elseif strfind(filename,'jpg')> 0
    x=imread(filename);
    y=(0.3*x(:,:,1))+(0.6*x(:,:,2))+(0.11*x(:,:,3));% la composante lumineuse de l'image couleur
    b = imnoise(y,'gaussian',0.02);
    b1=abs(fft(b));
    axes(handles.axes2);
    fmin=-0.01*(10^9);% fréquence minimale de la sous bande 
    fmax=0.01*(10^9);%fréquence maximale de la sous bande
    Fe=(fmax-fmin)/length(y);% fréquence d'échantillage
    f=fmin:Fe:fmax-Fe;% l'axe fréquentiel
    plot(f,b1)

    %Reponse impulsionnelle
    axes(handles.axes3);
    %b2=abs(ifft(b));
    t=0:1/Fe:1/Fe*(length(b)-1);% l'axe temporel
    plot(t,b)

 %calcul de psnr 
 erreur=sum((y-b).^2);% erreur quadratique
 erreur1=mean(erreur);%erreur quadratique moyenne
 psnr=(10*log((255^2)/(erreur1)));%calcul de peak signal noise ratio en dB
 set(handles.psnr,'String',psnr);
%Calcul de snr
 moy1=mean(y);% moyenne de l'image initiale
 moy2=mean(b);% moyenne de l'image compressée
 var=(1/length(y))*sum((moy1-moy2).^2);% la variance

 SNR=(10*log(var/erreur1));%snr en dB
 set(handles.snr,'String',SNR);% affichage de SNR en dB
 
 %calcul de ber de l'image
y1=dec2bin(y);%pour rendre l'image émise en binaire 
b3 = dec2bin(b); %numeriser
[M1,N1]=size(b3);%definir la taille_ligne et taille_colonne
bit_error=0;
for i=1:M1
    for k=1:N1
        if y1(i,k)~=b3(i,k)% si les images sont différentes faire%
         bit_error=bit_error+1;
        end
    end
end
  
   
  bit_emis=M1*N1;
  Ber=(bit_error/bit_emis);%calcul de taux d'erreurs binaires
  set(handles.Trber,'String',Ber);% affichage de Ber en dB
    
elseif strfind(filename,'mp3')> 0

    file = fopen(filename);%ouvrir le fichier
    x = fread(file);%lire le fichier
    b = imnoise(x,'gaussian',0.02);% fichier bruité
    %calcul de psnr du son mp3
     err = sum((x-b).^2);
     MSE=mean(err);
     PSNR = 10*log((255.^2)/MSE); 
     set(handles.psnr,'String',PSNR);
     
     
 %Calcul de snr du son mp3
 moy1=mean(x);% moyenne de l'image initiale
 moy2=mean(b);% moyenne de l'image compressée
 var=(1/length(x))*sum((moy1-moy2).^2);% la variance
 SNR=(10*log(var/MSE));%snr en dB
 set(handles.snr,'String',SNR);% affichage de SNR en dB
 
 
x1=dec2bin(x);%pour rendre l'image émise en binaire 
b3 = dec2bin(b); %numeriser
[M1,N1]=size(b3);%definir la taille_ligne et taille_colonne
bit_error=0;
for i=1:M1
    for k=1:N1
        if x1(i,k)~=b3(i,k)% si les images sont différentes faire%
         bit_error=bit_error+1;
        end
    end
end
  
   
  bit_emis=M1*N1;
  Ber=(bit_error/bit_emis);%calcul de taux d'erreurs binaires
  set(handles.Trber,'String',Ber);% affichage de Ber en dB
  
  
  b1=abs(fft(b));
    axes(handles.axes2);
    fmin=-0.01*(10^9);% fréquence minimale de la sous bande 
    fmax=0.01*(10^9);%fréquence maximale de la sous bande
    Fe=(fmax-fmin)/length(x);% fréquence d'échantillage
    f=fmin:Fe:fmax-Fe;% l'axe fréquentiel
    plot(f,b1)

    %Reponse impulsionnelle
    axes(handles.axes3);
    %b2=abs(ifft(b));
    t=0:1/Fe:1/Fe*(length(b)-1);% l'axe temporel
    plot(t,b)
    
elseif strfind(filename,'wav') >0
    file = fopen(filename);%ouvrir le fichier
    x = fread(file);%lire le fichier
    b = imnoise(x,'gaussian',0.02);% fichier bruité
    %calcul de psnr du son mp3
     err = sum((x-b).^2);
     MSE=mean(err);
     PSNR = 10*log((255.^2)/MSE); 
     set(handles.psnr,'String',PSNR);
     
     
 %Calcul de snr du son mp3
 moy1=mean(x);% moyenne de l'image initiale
 moy2=mean(b);% moyenne de l'image compressée
 var=(1/length(x))*sum((moy1-moy2).^2);% la variance
 SNR=(10*log(var/MSE));%snr en dB
 set(handles.snr,'String',SNR);% affichage de SNR en dB
 
 
x1=dec2bin(x);%pour rendre l'image émise en binaire 
b3 = dec2bin(b); %numeriser
[M1,N1]=size(b3);%definir la taille_ligne et taille_colonne
bit_error=0;
for i=1:M1
    for k=1:N1
        if x1(i,k)~=b3(i,k)% si les images sont différentes faire%
         bit_error=bit_error+1;
        end
    end
end
  
   
  bit_emis=M1*N1;
  Ber=(bit_error/bit_emis);%calcul de taux d'erreurs binaires
  set(handles.Trber,'String',Ber);% affichage de Ber en dB
  
  
  b1=abs(fft(b));
    axes(handles.axes2);
    fmin=-0.01*(10^9);% fréquence minimale de la sous bande 
    fmax=0.01*(10^9);%fréquence maximale de la sous bande
    Fe=(fmax-fmin)/length(x);% fréquence d'échantillage
    f=fmin:Fe:fmax-Fe;% l'axe fréquentiel
    plot(f,b1)

    %Reponse impulsionnelle
    axes(handles.axes3);
    %b2=abs(ifft(b));
    t=0:1/Fe:1/Fe*(length(b)-1);% l'axe temporel
    plot(t,b)   
    
elseif strfind(filename,'mp4') >0
    file = fopen(filename);
    x = fread(file);
    b = imnoise(x,'gaussian',0.02);%????????
    %calcul de psnr du son mp4
    err = sum((x-b).^2);
    MSE=mean(err);
    PSNR = 10*log((255.^2)/MSE); 
    set(handles.psnr,'String',PSNR);
    
    
 %Calcul de snr du son mp3
 moy1=mean(x);% moyenne de l'image initiale
 moy2=mean(b);% moyenne de l'image compressée
 var=(1/length(x))*sum((moy1-moy2).^2);% la variance
 SNR=(10*log(var/MSE));%snr en dB
 set(handles.snr,'String',SNR);% affichage de SNR en dB
    
 
x1=dec2bin(x);%pour rendre l'image émise en binaire 
b3 = dec2bin(b); %numeriser
[M1,N1]=size(b3);%definir la taille_ligne et taille_colonne
bit_error=0;
for i=1:M1
    for k=1:N1
        if x1(i,k)~=b3(i,k)% si les images sont différentes faire%
         bit_error=bit_error+1;
        end
    end
end
  
   
  bit_emis=M1*N1;
  Ber=(bit_error/bit_emis);%calcul de taux d'erreurs binaires
  set(handles.Trber,'String',Ber);% affichage de Ber en dB

  
b1=abs(fft(b));
    axes(handles.axes2);
    fmin=-0.01*(10^9);% fréquence minimale de la sous bande 
    fmax=0.01*(10^9);%fréquence maximale de la sous bande
    Fe=(fmax-fmin)/length(x);% fréquence d'échantillage
    f=fmin:Fe:fmax-Fe;% l'axe fréquentiel
    plot(f,b1)

    %Reponse impulsionnelle
    axes(handles.axes3);
    %b2=abs(ifft(b));
    t=0:1/Fe:1/Fe*(length(b)-1);% l'axe temporel
    plot(t,b)
    
elseif strfind(filename,'avi') >0
    
        file = fopen(filename);
    x = fread(file);
    b = imnoise(x,'gaussian',0.02);%????????
    %calcul de psnr du son mp4
    err = sum((x-b).^2);
    MSE=mean(err);
    PSNR = 10*log((255.^2)/MSE); 
    set(handles.psnr,'String',PSNR);
    
    
 %Calcul de snr du son mp3
 moy1=mean(x);% moyenne de l'image initiale
 moy2=mean(b);% moyenne de l'image compressée
 var=(1/length(x))*sum((moy1-moy2).^2);% la variance
 SNR=(10*log(var/MSE));%snr en dB
 set(handles.snr,'String',SNR);% affichage de SNR en dB
    
 
x1=dec2bin(x);%pour rendre l'image émise en binaire 
b3 = dec2bin(b); %numeriser
[M1,N1]=size(b3);%definir la taille_ligne et taille_colonne
bit_error=0;
for i=1:M1
    for k=1:N1
        if x1(i,k)~=b3(i,k)% si les images sont différentes faire%
         bit_error=bit_error+1;
        end
    end
end
  
   
  bit_emis=M1*N1;
  Ber=(bit_error/bit_emis);%calcul de taux d'erreurs binaires
  set(handles.Trber,'String',Ber);% affichage de Ber en dB

  
b1=abs(fft(b));
    axes(handles.axes2);
    fmin=-0.01*(10^9);% fréquence minimale de la sous bande 
    fmax=0.01*(10^9);%fréquence maximale de la sous bande
    Fe=(fmax-fmin)/length(x);% fréquence d'échantillage
    f=fmin:Fe:fmax-Fe;% l'axe fréquentiel
    plot(f,b1)

    %Reponse impulsionnelle
    axes(handles.axes3);
    %b2=abs(ifft(b));
    t=0:1/Fe:1/Fe*(length(b)-1);% l'axe temporel
    plot(t,b)
end




function psnr_Callback(hObject, eventdata, ~)
% hObject    handle to psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of psnr as text
%        str2double(get(hObject,'String')) returns contents of psnr as a double


% --- Executes during object creation, after setting all properties.
function psnr_CreateFcn(hObject, eventdata, ~)
% hObject    handle to psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over psnr.
function psnr_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Trber_Callback(hObject, eventdata, handles)
% hObject    handle to Trber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Trber as text
%        str2double(get(hObject,'String')) returns contents of Trber as a double


% --- Executes during object creation, after setting all properties.
function Trber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in receivechannels.
function receivechannels_Callback(hObject, eventdata, handles)
% hObject    handle to receivechannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns receivechannels contents as cell array
%        contents{get(hObject,'Value')} returns selected item from receivechannels



% --- Executes during object creation, after setting all properties.
function receivechannels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to receivechannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


index_selected = get(hObject, 'Value' );
switch index_selected
    case 1
        freq = sprintf( '2.41 GHz');
        set(handles.Carrierfrequen, 'String' , freq);
    case  2
        freq = sprintf( '2.415 GHz');
        set(handles.Carrierfrequen, 'String', freq);
    case  3
        freq = sprintf( '2.42 GHz');
      set(handles.Carrierfrequen, 'String' , freq);
    case  4
        freq = sprintf('2.425 GHz');
        set(handles.Carrierfrequen, 'String' , freq);        
    case  5
        freq = sprintf('2.43 GHz');
        set(handles.Carrierfrequen, 'String' , freq);
    case  6
        freq = sprintf('2.435 GHz');
        set(handles.Carrierfrequen, 'String' , freq);
    case  7
        freq = sprintf('2.44 GHz');
        set(handles.Carrierfrequen, 'String' , freq);
    case  8
        freq = sprintf('2.445 GHz');
        set(handles.Carrierfrequen, 'String' , freq);              
    case  9
        freq = sprintf('2.45 GHz');
        set(handles.Carrierfrequen, 'String' , freq);
    case  10
        freq = sprintf('2.455 GHz');
        set(handles.Carrierfrequen, 'String' , freq);
    case  11
        freq = sprintf('2.46 GHz');
       set(handles.Carrierfrequen, 'String' , freq);
    case  12
        freq = sprintf('2.465 GHz');
        set(handles.Carrierfrequen, 'String' , freq);  
    case  13
        freq = sprintf('2.47 GHz');
        set(handles.Carrierfrequen, 'String' , freq);        
end


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, ~)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function snr_Callback(hObject, eventdata, handles)
% hObject    handle to snr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of snr as text
%        str2double(get(hObject,'String')) returns contents of snr as a double


% --- Executes during object creation, after setting all properties.
function snr_CreateFcn(hObject, eventdata, ~)
% hObject    handle to snr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Carrierfrequen_Callback(hObject, eventdata, handles)
% hObject    handle to Carrierfrequen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Carrierfrequen as text
%        str2double(get(hObject,'String')) returns contents of Carrierfrequen as a double


% --- Executes during object creation, after setting all properties.
function Carrierfrequen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Carrierfrequen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel12.
function uipanel12_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel12 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
%     case 'radiobutton1'
%        %global rb;
%        % rb = 1;%if SISO is selected
%         set(handles.antreceiver,'Enable','on');%Enable to select antreceiver
%         set(handles.antreceiver2,'Enable','on');%Enable to select antreceiver2
%         set(handles.antreceiver,'Value',1);%Select antreceiver by default
%         set(handles.antreceiver2,'Value',0);%Unselect antreceiver2 by default
%     case 'radiobutton3'
%         rb = 0;%if MIMO is selected, we need to select both option and prevent the user to change the selection
%         set(handles.antreceiver,'Value',1);%Select antreceiver
%         set(handles.antreceiver2,'Value',1);%Select antreceiver2
%         set(handles.antreceiver,'Enable','off');%Disable to select antreceiver
%         set(handles.antreceiver2,'Enable','off');%Disable to select antreceiver2
        
       
    case 'radiobutton1'%SISO
        set(handles.popupmenu2,'String','1-to-1');
    case 'radiobutton2'%SIMO
        antenna1{1}= '1-to-2';
        antenna1{2}= '1-to-3';
        antenna1{3}= '1-to-4';
        set(handles.popupmenu2,'String',antenna1);
    case 'radiobutton4'%MISO
        antenna2{1}= '2-to-1';
        antenna2{2}= '3-to-1';
        antenna2{3}= '4-to-1';
        set(handles.popupmenu2,'String',antenna2);
    case 'radiobutton3' %MIMO
        antenna3{1}= '2-to-2';
        antenna3{2}= '2-to-3';
        antenna3{3}= '2-to-4';
        antenna3{4}= '3-to-2';
        antenna3{5}= '3-to-3';
        antenna3{6}= '3-to-4';
        antenna3{7}= '4-to-2';
        antenna3{8}= '4-to-3';
        antenna3{9}= '4-to-4';
        set(handles.popupmenu2,'String',antenna3);



        
end

% --- Executes on button press in antreceiver.
function antreceiver_Callback(hObject, eventdata, handles)
% hObject    handle to antreceiver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of antreceiver
global rb;% call value from uipanel6
% if antreceiver is selected and rb = 1(SISO is selected)
if (get(hObject,'Value') == get(hObject,'Max'))&&(rb == 1);
	set(handles.antreceiver2,'Value',0);%unselect antreceiver2 to assure only one is selected
else
% if antreceiver is unselected(to avoid none of the option is selected) 
    set(handles.antreceiver2,'Value',1);%select antreceiver
end


% --- Executes on button press in antreceiver2.
function antreceiver2_Callback(hObject, eventdata, handles)
% hObject    handle to antreceiver2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of antreceiver2


global rb;% call value from uipanel6
% if antreceiver2 is selected and rb = 1(SISO is selected)
if (get(hObject,'Value') == get(hObject,'Max'))&&(rb == 1);
	set(handles.antreceiver,'Value',0);%unselect antreceiver to assure only one is selected
else
% if antreceiver2 is unselected(to avoid none of the option is selected) 
    set(handles.antreceiver,'Value',1);%select antreceiver
end


% --- Executes on button press in selectdata.
function selectdata_Callback(hObject, eventdata, handles)
% hObject    handle to selectdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
[filename,pathname] = uigetfile({'*.jpg';'*.mp3';'*wav';'*.mp4';'*avi';'*bmp';'*wma'},'File Selector');%Enable user to browse file
file = strcat(pathname,filename);%Compile fullpath to the selected file
handles = guidata(hObject);
setappdata(0,'file',file);%store the value in GUI, so that other GUI can recall
 handles.filename = filename;
 guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in showdata.
function showdata_Callback(hObject, eventdata, handles)
% hObject    handle to showdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename =handles.filename;
[~,~, ext] = fileparts(filename); 
if strcmp(ext,'.bmp')||strcmp(ext,'.jpg')
    x =imread(filename);
    b = imnoise(x,'gaussian',0.002);
    figure(1) 
    imshow(b);%affichage de l'image
    
    %y = qammod(b,16);
    %figure(2)
    %scatterplot(y)
    
% hMod = comm.RectangularQAMModulator('ModulationOrder',16);
% figure(3)
% constellation(hMod)


%         hAWGN = comm.AWGNChannel('NoiseMethod','Signal to noise ratio (Es/No)',... 
%     'EsNo',20);
%         hScope = comm.ConstellationDiagram;
%         modData = step(hMod,b);
%         ampImb = 10; % dB
%         Q = exp(0.5*ampImb/20)*real(modData);
%         I = exp(-0.5*ampImb/20)*imag(modData);
%         Sig = complex(I,Q);
%         rxSig = step(hAWGN,Sig);
%         figure(2)
%         step(hScope,rxSig)
%h = comm.BPSKModulator;
%refC = constellation(h);
%figure(2)
%constellation(h)

   
elseif strcmp(ext,'.mp3')||strcmp(ext,'.wma')||strcmp(ext,'.wav')
    Audioplayer;
elseif strfind(filename,'avi')> 0
    movieCommand;
elseif strfind(filename,'mp4') >0
    implay(filename);
    [y,f]=audioread(filename);
    pl=audioplayer(y,f);
    handles.pl=pl;
    resume(pl);
    guidata(hObject,handles);
 end;
 handles.filename = filename;
 guidata(hObject,handles);


% --- Executes on button press in cleardata.
function cleardata_Callback(hObject, eventdata, handles)
% hObject    handle to cleardata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes2,'reset');
cla(handles.axes3,'reset');
set(handles.snr,'String','');
set(handles.psnr,'String','');
set(handles.Trber,'String','');


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
