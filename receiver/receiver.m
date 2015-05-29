
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

% Last Modified by GUIDE v2.5 26-May-2015 14:29:46

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
[~,~,ext] = fileparts(filename) ;
if strcmp(ext,'.jpg')||strcmp(ext,'.bmp')    
    
    x=imread(filename);
    b = imnoise(x,'gaussian',0.02);%ajouter le bruit dans l'image
    
    %Test si image est N&B ou couleur
    f=imfinfo(filename);
    type = f.ColorType;
    
    if strcmp(type,'indexed') == 1 % si image N &B
        %Reponse frequentielle
        axes(handles.axes2);
        fmin=-0.01*(10^9);% fréquence minimale donnée
        fmax=0.01*(10^9);%fréquence maximale donnée
        Fe=(fmax-fmin)/length(b);% fréquence d'échantillage
        f=fmin:Fe:fmax-Fe;% l'axe fréquentiel

        xf=abs(fft(b));
        plot(f,xf)


        %Reponse impulsionnelle
        axes(handles.axes3);
        t=0:1/Fe:1/Fe*(length(b)-1);% l'axe temporel
        %stem(t,x1)
        plot(t,b)
        
        val_psnr=PSNR_grayscale(x,b);%calcul psnr
        set(handles.psnr,'String',val_psnr);
        
        val_snr= 20*log(norm(x,'fro')/norm(x-b,'fro'));
        set(handles.snr,'String',val_snr);
    else
        FFT_RED = fft2(b(:,:,1));
        FFT_GREEN = fft2(b(:,:,2));
        FFT_BLUE = fft2(b(:,:,3));
        %Reponse frequentielle
        axes(handles.axes2);
        hold on;
        plot(FFT_RED,'r');
        plot(FFT_GREEN,'g')
        plot(FFT_BLUE,'b');
        
        %Reponse impulsionnelle
        axes(handles.axes3);
        Imp_RED = b(:,:,1);
        Imp_GREEN = b(:,:,2);
        Imp_BLUE = b(:,:,3);
        hold on;
        plot(Imp_RED,'r');
        plot(Imp_GREEN,'g')
        plot(Imp_BLUE,'b');
        
        val_psnr = PSNR_RGB(x,b); %si image couleur
        set(handles.psnr,'String',val_psnr);
    end;
    
    x1=dec2bin(x);%pour rendre l'image émise en binaire
    b1=dec2bin(b);%pour rendre l'image reçue en binaire

    [M1,N1]=size(b1);%definir la taille_ligne et taille_colonne
    bit_error=0;
    for i=1:M1
        for k=1:N1
            if x1(i,k)~=b1(i,k)% si les images sont différentes faire%
             bit_error=bit_error+1;
            end
        end
    end
    bit_emis=M1*N1;
    Ber=(bit_error/bit_emis);%calcul de taux d'erreurs binaires
    set(handles.Trber,'String',Ber);% affichage de Ber en dB

elseif strcmp(ext,'.mp3')||strcmp(ext,'.wav')
    axes(handles.axes3);
    [wave,fs]=audioread(filename);
    t=0:1/fs:(length(wave)-1)/fs; % and get sampling frequency */
    plot(t,wave);

 % graph it – try zooming while its up…not much visible until you do*/
    axes(handles.axes2);
    n=length(wave)-1; 
    f=0:fs/n:fs;
    wavefft=abs(fft(wave)); % perform Fourier Transform *
    plot(f,wavefft); % plot Fourier Transform */

    %Ajouter le bruit dans le son
    [y1, ~] = audioread(filename);
    y2 = y1 + 0.01 * randn(size(y1));
    
    [c1x,c1y]=size(y1);

    R=c1x;
    C=c1y;
    err = sum((y1-y2).^2)/(R*C);
    sumerr = sum(err);
    MSE=sqrt(sumerr);
    MAXVAL=255;
    PSNR = 10*log10(MAXVAL.^2/MSE); 
    set(handles.psnr,'String',PSNR);
    
    %afficher le ber
    x1 = dec2bin( typecast( single(y1(:)), 'uint8'), 8 ) - '0';%convertir audio original en binaire
    b1 = dec2bin( typecast( single(y2(:)), 'uint8'), 8 ) - '0';%convertir audio bruite en binaire
    [M1,N1]=size(b1);%definir la taille_ligne et taille_colonne
    bit_error=0;
    for i=1:M1
        for k=1:N1
            if x1(i,k)~=b1(i,k)% si les images sont différentes faire%
             bit_error=bit_error+1;
            end
        end
    end
    bit_emis=M1*N1;
    Ber=(bit_error/bit_emis);%calcul de taux d'erreurs binaires
    set(handles.Trber,'String',Ber);% affichage de Ber en dB

    val_snr = 10*log10(sum(y1.^2)/ sum(y2.^2));
    set(handles.snr,'String',val_snr);
    
elseif strcmp(ext,'.mp4')
    
    
elseif strfind(filename,'avi') >0

    obj = VideoReader(filename);
    video = read(obj);
    nFrames = size(video,4);
    
    %Le calcul de psnr pour video
    psnr2 = 0;
    for i = 1 : nFrames  
        I(:,:,:,i) = video(:,:,:,i);%Original frame
        N(:,:,:,i) = imnoise(video(:,:,:,i),'gaussian',0.02);%Noise-added frame
        drawnow; %Add if we use in loop 
        errorFrame = I - N;    
        PSNR = 10*log10(255*255/mean(mean((errorFrame.^2))));
        val_psnr = 0;
        for j = 1 : 3;
            val_psnr = val_psnr+PSNR(:,:,j,i);
        end;
        moy_val_psnr = val_psnr/3;%faire la moyenne pour frame RGB
        psnr2 = psnr2 + moy_val_psnr;
    end;
    moy_psnr2 = psnr2/nFrames;%la moyenne de tous les frames
    set(handles.psnr,'String',moy_psnr2);
    
    %Ajouter les frames bruitees dans noise.avi
    writerObj2 = VideoWriter('noise.avi');
    open(writerObj2);
    for i = 1:nFrames
    writeVideo(writerObj2,N);
    end;
    
    
    
    Imp_RED2 = 0;
    Imp_GREEN2 = 0;
    Imp_BLUE2 = 0;
    for i = 1 : nFrames
        Imp_RED(:,:,i) = N(:,:,1,i);
        Imp_RED = uint16(Imp_RED);%la valeur limite pour uint 8 est 255
        Imp_RED2 = Imp_RED2+ Imp_RED(:,:,i);%la somme fait plus que 255
        Imp_GREEN(:,:,i) = N(:,:,2,i);
        Imp_GREEN = uint16(Imp_GREEN);
        Imp_GREEN2 = Imp_GREEN2+Imp_GREEN(:,:,i);
        Imp_BLUE(:,:,i) = N(:,:,3,i);
        Imp_BLUE = uint16(Imp_BLUE);
        Imp_BLUE2 = Imp_BLUE2+Imp_BLUE(:,:,i);
    end;
    moy_Imp_RED2 = Imp_RED2/nFrames;
    moy_Imp_GREEN2 = Imp_GREEN2/nFrames;
    moy_Imp_BLUE2 = Imp_BLUE2/nFrames;
    axes(handles.axes3);
    hold on;
    plot(moy_Imp_RED2,'r');
    plot(moy_Imp_GREEN2,'g');
    plot(moy_Imp_BLUE2,'b');
    
    FFT_RED = fft2(moy_Imp_RED2);
    FFT_GREEN = fft2(moy_Imp_GREEN2);
    FFT_BLUE = fft2(moy_Imp_BLUE2);
    %Reponse frequentielle
    axes(handles.axes2);
    hold on;
    plot(FFT_RED,'r');
    plot(FFT_GREEN,'g');
    plot(FFT_BLUE,'b');
    
    %Ouvrir les fichiers et les transformer en binaire
    fileID = fopen(filename,'r');
    A = fread(fileID);
    fclose(fileID);
    fileID = fopen('noise.avi','r');
    B = fread(fileID);
    fclose(fileID);
    x1=dec2bin(A);%pour rendre l'image émise en binaire
    b1=dec2bin(B);%pour rendre l'image reçue en binaire

    [M1,N1]=size(b1);%definir la taille_ligne et taille_colonne
    bit_error=0;
    for i=1:M1
        for k=1:N1
            if x1(i,k)~=b1(i,k)% si les images sont différentes faire%
             bit_error=bit_error+1;
            end
        end
    end
    bit_emis=M1*N1;
    Ber=(bit_error/bit_emis);%calcul de taux d'erreurs binaires
    set(handles.Trber,'String',Ber);% affichage de Ber en dB
end
    
function psnr_Callback(hObject, eventdata, handles)
% hObject    handle to psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of psnr as text
%        str2double(get(hObject,'String')) returns contents of psnr as a double


% --- Executes during object creation, after setting all properties.
function psnr_CreateFcn(hObject, eventdata, handles)
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
function snr_CreateFcn(hObject, eventdata, handles)
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
    case 'radiobutton1'
        global rb;
        rb = 1;%if SISO is selected
        set(handles.antreceiver,'Enable','on');%Enable to select antreceiver
        set(handles.antreceiver2,'Enable','on');%Enable to select antreceiver2
        set(handles.antreceiver,'Value',1);%Select antreceiver by default
        set(handles.antreceiver2,'Value',0);%Unselect antreceiver2 by default
    case 'radiobutton2'
        rb = 0;%if MIMO is selected, we need to select both option and prevent the user to change the selection
        set(handles.antreceiver,'Value',1);%Select antreceiver
        set(handles.antreceiver2,'Value',1);%Select antreceiver2
        set(handles.antreceiver,'Enable','off');%Disable to select antreceiver
        set(handles.antreceiver2,'Enable','off');%Disable to select antreceiver2
        
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
[filename,pathname] = uigetfile({'*.jpg';'*.mp3';'*wav';'*.mp4';'*avi';'*bmp'},'File Selector');%Enable user to browse file
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
[~,~,ext] = fileparts(filename) ;
if strcmp(ext,'.jpg')||strcmp(ext,'.bmp')
    axes(handles.axes1);
    x =imread(filename);
    b = imnoise(x,'gaussian',0.02);
    imshow(b);%affichage de l'image
  
elseif strcmp(ext,'.mp3')
    Audioplayer;
elseif strcmp(ext,'.avi')
    movieCommand;
elseif strcmp(ext,'.mp4')
    implay(filename);
    [y,f]=audioread(filename);
    pl=audioplayer(y,f);
    handles.pl=pl;
    resume(pl);
    guidata(hObject,handles);
 end;
 
 guidata(hObject,handles);


% --- Executes on button press in cleardata.
function cleardata_Callback(hObject, eventdata, handles)
% hObject    handle to cleardata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
cla(handles.axes3,'reset');
set(handles.snr,'String','');
set(handles.psnr,'String','');
set(handles.Trber,'String','');
