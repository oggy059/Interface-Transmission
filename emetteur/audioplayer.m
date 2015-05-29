function varargout = Audioplayer(varargin)
% AUDIOPLAYER MATLAB code for Audioplayer.fig
%      AUDIOPLAYER, by itself, creates a new AUDIOPLAYER or raises the existing
%      singleton*.
%
%      H = AUDIOPLAYER returns the handle to a new AUDIOPLAYER or the handle to
%      the existing singleton*.
%
%      AUDIOPLAYER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUDIOPLAYER.M with the given input arguments.
%
%      AUDIOPLAYER('Property','Value',...) creates a new AUDIOPLAYER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Audioplayer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Audioplayer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Audioplayer

% Last Modified by GUIDE v2.5 21-May-2015 16:00:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Audioplayer_OpeningFcn, ...
                   'gui_OutputFcn',  @Audioplayer_OutputFcn, ...
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


% --- Executes just before Audioplayer is made visible.
function Audioplayer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Audioplayer (see VARARGIN)

% Choose default command line output for Audioplayer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Audioplayer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Audioplayer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% SL = get(handles.slider1,{'min','value','max'});
% set(handles.edit1,'string',SL{2});

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pl stop_pl;
stop_pl = 0;
stop (pl); % Stop audio file


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pl stop_pl;
stop_pl = 1;
file = getappdata(0,'file');%Call value from main GUI
%On definit le filename comme handles.filename pour que l'autre hObject
%peut faire appel
[y,f]=audioread(file);%Read audio file
pl=audioplayer(y,f);
handles.pl=pl;
resume(pl);%Play file
t=get(pl,'TotalSamples');%get the Total Sample of running audio
guidata(hObject,handles);
while (stop_pl == 1)%if stop button is not clicked
    c=get(pl,'CurrentSample');%get the Current Sample(it changes every second)
    sliderval = c/t;
    set(handles.slider1,'Value',sliderval);
    guidata(hObject, handles);
    pause(.1);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)%We stop the sound from playing if user close the window
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pl stop_pl;
stop_pl = 0;
stop (pl);
% Hint: delete(hObject) closes the figure
delete(hObject);
