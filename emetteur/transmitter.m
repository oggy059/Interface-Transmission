function varargout = Transmitter(varargin)
% TRANSMITTER MATLAB code for Transmitter.fig
%      TRANSMITTER, by itself, creates a new TRANSMITTER or raises the existing
%      singleton*.
%
%      H = TRANSMITTER returns the handle to a new TRANSMITTER or the handle to
%      the existing singleton*.
%
%      TRANSMITTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANSMITTER.M with the given input arguments.
%
%      TRANSMITTER('Property','Value',...) creates a new TRANSMITTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Transmitter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Transmitter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Transmitter

% Last Modified by GUIDE v2.5 02-Jun-2015 16:07:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Transmitter_OpeningFcn, ...
                   'gui_OutputFcn',  @Transmitter_OutputFcn, ...
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


% --- Executes just before Transmitter is made visible.
function Transmitter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Transmitter (see VARARGIN)
global browse;
browse = 0;
% Choose default command line output for Transmitter
handles.output = hObject;
axes(handles.axes1);
imshow('univ.jpg');
axes(handles.axes2);
imshow('facu.jpg');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Transmitter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Transmitter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in popupmenu2.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global browse;
[filename,pathname] = uigetfile({'*.jpg';'*.mp3';'*wav';'*.mp4';'*avi'},'File Selector');
file = strcat(pathname,filename);
handles = guidata(hObject);
setappdata(0,'file',file);
if strfind(filename,'jpg')> 0
    figure;
    imshow(file);
elseif strfind(filename,'mp3')> 0
    Audioplayer;
elseif strfind(filename,'avi')> 0
%     implay(filename);
%     [y,f]=audioread(filename);
%     pl=audioplayer(y,f);
%     handles.pl=pl;
%     resume(pl);
%     guidata(hObject,handles);
    movieCommand;
elseif strfind(filename,'mp4') >0
    implay(filename);
    [y,f]=audioread(filename);
    pl=audioplayer(y,f);
    handles.pl=pl;
    resume(pl);
    guidata(hObject,handles);
 end;
 if filename ~= 0%if no file is selected
    browse = 1;%provoke warning
 end;
 handles.filename = filename;
 guidata(hObject,handles);
 


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
index_selected = get(hObject,'Value');
switch index_selected
    case 1
        strH = sprintf('2,41 GHz');
        set(handles.edit5,'String',strH);
    case 2
        strH = sprintf('2,415 GHz');
        set(handles.edit5,'String',strH);
    case 3
        strH = sprintf('2,42 GHz');
        set(handles.edit5,'String',strH);
    case 4
        strH = sprintf('2,425 GHz');
        set(handles.edit5,'String',strH);        
    case 5
        strH = sprintf('2,43 GHz');
        set(handles.edit5,'String',strH);
    case 6
        strH = sprintf('2,435 GHz');
        set(handles.edit5,'String',strH);
    case 7
        strH = sprintf('2,44 GHz');
        set(handles.edit5,'String',strH);
    case 8
        strH = sprintf('2,445 GHz');
        set(handles.edit5,'String',strH);              
    case 9
        strH = sprintf('2,45 GHz');
        set(handles.edit5,'String',strH);
    case 10
        strH = sprintf('2,455 GHz');
        set(handles.edit5,'String',strH);
    case 11
        strH = sprintf('2,46 GHz');
        set(handles.edit5,'String',strH);
    case 12
        strH = sprintf('2,465 GHz');
        set(handles.edit5,'String',strH);  
    case 13
        strH = sprintf('2,47 GHz');
        set(handles.edit5,'String',strH);        
end;

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global browse;
if browse == 0
    msgbox('Warning! You haven’t selected any file. Please click on Browse button to select any file.','File Error','warn');
else
    msgbox('The file has been successfully transmitted!','Transmission complete');
end;
    



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel6.
function uipanel6_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel6 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton1'%SISO
        set(handles.popupmenu2,'String','1-to-1');
    case 'radiobutton2'%SIMO
        antenna1{1}= '1-to-2';
        antenna1{2}= '1-to-3';
        antenna1{3}= '1-to-4';
        set(handles.popupmenu2,'String',antenna1);
    case 'radiobutton3'%MISO
        antenna2{1}= '2-to-1';
        antenna2{2}= '3-to-1';
        antenna2{3}= '4-to-1';
        set(handles.popupmenu2,'String',antenna2);
    case 'radiobutton4'
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



% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
% Execute these lines to know the name represented by each keyboard button
% eventdata; 
% disp(eventdata.Key);
switch eventdata.Key
    case 'return'%if we press button Enter
        pushbutton2_Callback(hObject, eventdata, handles);%Execute 'Start' button callback
    case 'o'
        pushbutton1_Callback(hObject, eventdata, handles);
end;

        


% --- Executes on selection change in popupmenu2.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function uipanel3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected object is changed in uipanel3.
function uipanel3_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel3 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton5'
        set(handles.popupmenu1,'Enable','off');
    case 'radiobutton6'
        set(handles.popupmenu1,'Enable','on');
end;
        
