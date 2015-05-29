function varargout = movieCommand(varargin)
% MOVIECOMMAND M-file for movieCommand.fig
%      MOVIECOMMAND, by itself, creates a new MOVIECOMMAND or raises the existing
%      singleton*.
%
%      H = MOVIECOMMAND returns the handle to a new MOVIECOMMAND or the handle to
%      the existing singleton*.
%
%      MOVIECOMMAND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOVIECOMMAND.M with the given input arguments.
%
%      MOVIECOMMAND('Property','Value',...) creates a new MOVIECOMMAND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before movieCommand_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to movieCommand_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help movieCommand

% Last Modified by GUIDE v2.5 15-May-2010 00:25:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @movieCommand_OpeningFcn, ...
    'gui_OutputFcn',  @movieCommand_OutputFcn, ...
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


function editFor1_Callback(hObject, eventdata, handles)
% hObject    handle to editFor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFor1 as text
%        str2double(get(hObject,'String')) returns contents of editFor1 as a double
thisString = get(hObject, 'string');
thisValue = round(str2double(thisString) / handles.video.rate * 1000);
set(handles.textFor1, 'string', sprintf('%4i', thisValue));


% --- Executes during object creation, after setting all properties.
function editFor1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editFor2_Callback(hObject, eventdata, handles)
% hObject    handle to editFor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFor4 as text
%        str2double(get(hObject,'String')) returns contents of editFor4 as a double
thisString = get(hObject, 'string');
thisValue = round(str2double(thisString) / handles.video.rate * 1000);
set(handles.textFor2, 'string', sprintf('%4i', thisValue));


% --- Executes during object creation, after setting all properties.
function editFor2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editFor3_Callback(hObject, eventdata, handles)
% hObject    handle to editFor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFor2 as text
%        str2double(get(hObject,'String')) returns contents of editFor2 as a double
thisString = get(hObject, 'string');
thisValue = round(str2double(thisString) * handles.video.rate);
set(handles.textFor3, 'string', sprintf('%4i', thisValue));
% --- Executes during object creation, after setting all properties.


function editFor3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editFor4_Callback(hObject, eventdata, handles)
% hObject    handle to editFor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFor4 as text
%        str2double(get(hObject,'String')) returns contents of editFor4 as a double
thisString = get(hObject, 'string');
thisValue = round(str2double(thisString) * handles.video.rate);
set(handles.textFor4, 'string', sprintf('%4i', thisValue));


% --- Executes during object creation, after setting all properties.
function editFor4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editRew1_Callback(hObject, eventdata, handles)
% hObject    handle to editRew1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRew1 as text
%        str2double(get(hObject,'String')) returns contents of editRew1 as a double
thisString = get(hObject, 'string');
thisValue = round(str2double(thisString) / handles.video.rate * 1000);
set(handles.textRew1, 'string', sprintf('%4i', thisValue));


% --- Executes during object creation, after setting all properties.
function editRew1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRew1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editRew2_Callback(hObject, eventdata, handles)
% hObject    handle to editRew4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRew4 as text
%        str2double(get(hObject,'String')) returns contents of editRew4 as a double
thisString = get(hObject, 'string');
thisValue = round(str2double(thisString) / handles.video.rate * 1000);
set(handles.textRew2, 'string', sprintf('%4i', thisValue));


% --- Executes during object creation, after setting all properties.
function editRew2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRew4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editRew3_Callback(hObject, eventdata, handles)
% hObject    handle to editRew3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRew2 as text
%        str2double(get(hObject,'String')) returns contents of editRew2 as a double
thisString = get(hObject, 'string');
thisValue = round(str2double(thisString) * handles.video.rate);
set(handles.textRew3, 'string', sprintf('%4i', thisValue));


% --- Executes during object creation, after setting all properties.
function editRew3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRew3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editRew4_Callback(hObject, eventdata, handles)
% hObject    handle to editRew4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRew4 as text
%        str2double(get(hObject,'String')) returns contents of editRew4 as a double
thisString = get(hObject, 'string');
thisValue = round(str2double(thisString) * handles.video.rate);
set(handles.textRew4, 'string', sprintf('%4i', thisValue));


% --- Executes during object creation, after setting all properties.
function editRew4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRew4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figureMovieCommand.
function figureMovieCommand_CloseRequestFcn(hObject, ~, handles)
% hObject    handle to figureMovieCommand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isfield(handles, 'hView'),
    try
        close(handles.hView);
    catch ME
        disp(ME)
    end
end
% Hint: delete(hObject) closes the figure
try delete(handles.hFigureMovieView), catch ME; disp(ME); end; 
hFigureBRCommand = findobj('tag', 'figureBRCommand'); 
if isempty(hFigureBRCommand), 
else
    handlesFigureBRCommand = guidata(hFigureBRCommand); 
    set(handlesFigureBRCommand.uitoggletoolTV, 'State', 'off'); 
end
try delete(hObject); catch ME; disp(ME); end


% --- Executes on selection change in listboxComment.
function listboxComment_Callback(hObject, eventdata, handles)
% hObject    handle to listboxComment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxComment contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxComment


% --- Executes during object creation, after setting all properties.
function listboxComment_CreateFcn(hObject, ~, handles)
% hObject    handle to listboxComment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes just before movieCommand is made visible.
function movieCommand_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to movieCommand (see VARARGIN)

% Choose default command line output for movieCommand
handles.output = hObject;
%
try close('movieView'); catch ME; end
handles.hFigureMovieView = movieView;
handlesMovieView = guidata(handles.hFigureMovieView); 
nargin = size(varargin);
if isfield(handles, 'video'),
    video = handles.video;
end
video.iFrame = 1;
if nargin == 0,
    handles.aviFilename = getappdata(0,'file');
elseif nargin > 0, % first varargin is a dummy number to avoid the function evaluation that generates errors
    handles.aviFilename = varargin{2};
end
hWMP = handlesMovieView.hWMP; 
hWMP.set('url', handles.aviFilename); % create video
hWMPProp = get(hWMP); % this solution to slow down and check the opening for getting good properties values. 
while ~strcmpi(hWMPProp.openState, 'wmposMediaOpen'),
    pause(1); 
    hWMPProp = get(hWMP); 
end
hWMP.controls.pause;
video.rate = hWMP.network.get('encodedFrameRate');
currentItem = hWMP.controls.get('currentItem');
video.duration = currentItem.get('duration');
video.width = currentItem.get('imageSourceWidth');
video.height = currentItem.get('imageSourceHeight');
video.name = currentItem.get('name');
video.maxFrames = floor(video.duration * video.rate);
video = setVideoFrame(handles, video);
% if handles.video.width > handles.video.height,
%     axesW = 0.9;
%     axesH = 0.9 * handles.video.height / handles.video.width;
% else
%     axesW = 0.9 * handles.video.width / handles.video.height;
%     axesH = 0.9;
% end
% Initialisation des text/edit
listEdit(1,:) = [handles.editFor1, handles.textFor1];
listEdit(2,:) = [handles.editFor2, handles.textFor2];
listEdit(3,:) = [handles.editRew1, handles.textRew1];
listEdit(4,:) = [handles.editRew2, handles.textRew2];
listEdit(5,:) = [handles.editFor3, handles.textFor3];
listEdit(6,:) = [handles.editFor4, handles.textFor4];
listEdit(7,:) = [handles.editRew3, handles.textRew3];
listEdit(8,:) = [handles.editRew4, handles.textRew4];
% handles.video.rate ;
for i = 1 : 8,
    thisString = get(listEdit(i, 1), 'string');
    if i < 5,
        thisValue = round(str2double(thisString) / video.rate * 1000);
    else
        thisValue = round(str2double(thisString) * video.rate );
    end
    set(listEdit(i, 2), 'string', sprintf('%4i', thisValue));
end
handles.video = video;
% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = movieCommand_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
varargout{2} = handles.hFigureMovieView; 

function changeURL(handles, fullfilename, iFrame)
handlesMovieView = guidata(handles.figureMovieView);
hWMP = handlesMovieView.hWMP;
hWMP.set('url', fullfilename); % create video
hWMPProp = get(hWMP); % this solution to slow down and check the opening for getting good properties values. 
while ~strcmpi(hWMPProp.openState, 'wmposMediaOpen'),
    pause(1); 
    hWMPProp = get(hWMP); 
end
hWMP.controls.pause;
video.rate = hWMP.network.get('encodedFrameRate');
currentItem = hWMP.controls.get('currentItem');
video.duration = currentItem.get('duration');
video.width = currentItem.get('imageSourceWidth');
video.height = currentItem.get('imageSourceHeight');
video.name = currentItem.get('name');
video.maxFrames = floor(video.duration * video.rate);
video.iFrame = iFrame;
video = setVideoFrame(guidata(handles.figureMovieCommand), video);


function hFigureMovieCommand = open(filename)
hFigureMovieView = movieCommand(1, filename); 


function setVideoFrameFromExt(hFigureMovieCommand, extTime)
handles = guidata(hFigureMovieCommand); 
video = handles.video; 
video.iFrame = floor(extTime * video.rate); 
video = setVideoFrame(handles, video); 
handles.video = video; 
guidata(hFigureMovieCommand, handles); 


% --- Executes on button press in pushbuttonFor1.
function pushbuttonFor1_Callback(hObject, ~, handles)
% hObject    handle to pushbuttonFor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step = str2double(get(handles.editFor1, 'string'));
video = handles.video; 
video.iFrame = video.iFrame + step;
if video.iFrame > video.maxFrames,
    video.iFrame = video.iFrame - step;
else
    video = setVideoFrame(handles, video); 
    setVerticalVideoMarkerOnViewer(video);
end
handles.video = video;
guidata(get(hObject, 'parent'), handles)


% --- Executes on button press in pushbuttonFor2.
function pushbuttonFor2_Callback(hObject, ~, handles)
% hObject    handle to pushbuttonFor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step = str2double(get(handles.editFor2, 'string'));
video = handles.video; 
video.iFrame = video.iFrame + step;
if video.iFrame > video.maxFrames,
    video.iFrame = video.iFrame - step;
else
    video = setVideoFrame(handles, video);
    setVerticalVideoMarkerOnViewer(video);
end
handles.video = video; 
guidata(get(hObject, 'parent'), handles)


% --- Executes on button press in pushbuttonFor3.
function pushbuttonFor3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonFor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step = str2double(get(handles.textFor3, 'string'));
video = handles.video; 
video.iFrame = video.iFrame + step;
if video.iFrame > video.maxFrames,
    video.iFrame = video.iFrame - step;
else
    video = setVideoFrame(handles, video); 
    setVerticalVideoMarkerOnViewer(video); 
end
handles.video = video; 
guidata(get(hObject, 'parent'), handles)


% --- Executes on button press in pushbuttonFor4.
function pushbuttonFor4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonFor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step = str2double(get(handles.textFor4, 'string'));
video = handles.video; 
video.iFrame = video.iFrame + step;
if video.iFrame > video.maxFrames,
    video.iFrame = video.iFrame - step;
else
    video = setVideoFrame(handles, video); 
    setVerticalVideoMarkerOnViewer(video); 
end
handles.video = video; 
guidata(get(hObject, 'parent'), handles)


% --- Executes on button press in pushbuttonForEnd.
function pushbuttonForEnd_Callback(hObject, ~, handles)
% hObject    handle to pushbuttonForEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video = handles.video; 
video.iFrame = floor(video.duration * video.rate) ; % video.maxFrames does not work on micromed avi files when video are short
video = setVideoFrame(handles, video);
setVerticalVideoMarkerOnViewer(video);
handles.video = video;
guidata(get(hObject, 'parent'), handles)


% --- Executes on button press in pushbuttonRew1.
function pushbuttonRew1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonRew1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step = -str2double(get(handles.editRew1, 'string'));
video = handles.video; 
video.iFrame = video.iFrame + step;
if video.iFrame < 1,
    video.iFrame = video.iFrame - step;
else
    video = setVideoFrame(handles, video);
    setVerticalVideoMarkerOnViewer(video); 
end
handles.video = video; 
guidata(get(hObject, 'parent'), handles)


% --- Executes on button press in pushbuttonRew4.
function pushbuttonRew2_Callback(hObject, ~, handles)
% hObject    handle to pushbuttonRew4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step = -str2double(get(handles.editRew2, 'string'));
video = handles.video; 
video.iFrame = video.iFrame + step;
if video.iFrame < 1,
    video.iFrame = video.iFrame - step;
else
    video = setVideoFrame(handles, video); 
    setVerticalVideoMarkerOnViewer(video); 
end
handles.video = video; 
guidata(get(hObject, 'parent'), handles)


% --- Executes on button press in pushbuttonRew1.
function pushbuttonRew3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonRew3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step = -str2double(get(handles.textRew3, 'string'));
video = handles.video; 
video.iFrame = video.iFrame + step;
if video.iFrame < 1,
    video.iFrame = video.iFrame - step;
else
    video = setVideoFrame(handles, video); 
    setVerticalVideoMarkerOnViewer(video)
end
handles.video = video; 
guidata(get(hObject, 'parent'), handles)


% --- Executes on button press in pushbuttonRew4.
function pushbuttonRew4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonRew4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step = -str2double(get(handles.textRew4, 'string'));
video = handles.video; 
video.iFrame = video.iFrame + step;
if video.iFrame < 1,
    video.iFrame = video.iFrame - step;
else
    video = setVideoFrame(handles, video); 
    setVerticalVideoMarkerOnViewer(video); 
end
handles.video = video; 
guidata(get(hObject, 'parent'), handles)


% --- Executes on button press in pushbuttonRewStart.
function pushbuttonRewStart_Callback(hObject, ~, handles)
% hObject    handle to pushbuttonRewStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
video = handles.video; 
video.iFrame = 1;
video = setVideoFrame(handles, video);
setVerticalVideoMarkerOnViewer(video); 
handles.video = video; 
guidata(get(hObject, 'parent'), handles)


function setVerticalVideoMarkerOnViewer(video)
hFigMovieCommand = findobj('Tag', 'figureMovieCommand');
set(hFigMovieCommand, 'interruptible', 'off'); 
hFigBRView = findobj('Tag', 'axesBRView');
if isempty(hFigBRView),
    % do nothing,
else
    hFigBRCommand = findobj('Tag', 'figureBRCommand');
    handles = guihandles(hFigBRCommand);
    BiomedReaderCommand('setVerticalVideoMarker', video);
end
set(hFigMovieCommand, 'interruptible', 'on'); 


function [video, hWMP] = setVideoFrame(handles, video)
handlesMovieView = guidata(handles.hFigureMovieView);
hWMP = handlesMovieView.hWMP;
%hWMP.set('url', handles.aviFilename); % create video
%pause(1)
video.time = video.iFrame / video.rate;
hWMP.controls.pause; % avant de positionner le fichier.
hWMP.controls.set('currentPosition', video.time);
currentItem = hWMP.controls.get('currentItem');
video.rate = hWMP.network.get('encodedFrameRate');
video.duration = currentItem.get('duration');
video.width = currentItem.get('imageSourceWidth');
video.height = currentItem.get('imageSourceHeight');
video.name = currentItem.get('name');
set(handles.listboxComment, 'String', {...
    sprintf('%64s', video.name), ...
    sprintf('Width:%5i Height:%5i', video.width, video.height), ...
    sprintf('nrFramesTotal:%10i', video.maxFrames), ...
    sprintf('rate:%10.5f', video.rate), ...
    sprintf('totalDuration (s): %10.5f', video.duration), ...
    sprintf('time (s) :%10.5f', video.time), ...
    });
handlesMovieView.hWMP = hWMP;
guidata(handlesMovieView.figureMovieView, handlesMovieView);
