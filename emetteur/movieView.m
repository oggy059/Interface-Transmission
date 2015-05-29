function varargout = movieView(varargin)
% MOVIEVIEW M-file for movieView.fig
%      MOVIEVIEW, by itself, creates a new MOVIEVIEW or raises the existing
%      singleton*.
%
%      H = MOVIEVIEW returns the handle to a new MOVIEVIEW or the handle to
%      the existing singleton*.
%
%      MOVIEVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOVIEVIEW.M with the given input arguments.
%
%      MOVIEVIEW('Property','Value',...) creates a new MOVIEVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before movieView_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to movieView_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help movieView

% Last Modified by GUIDE v2.5 13-Oct-2009 15:35:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @movieView_OpeningFcn, ...
                   'gui_OutputFcn',  @movieView_OutputFcn, ...
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


% --- Executes just before movieView is made visible.
function movieView_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to movieView (see VARARGIN)

% Choose default command line output for movieView
handles.output = hObject;
hWMP = actxcontrol('WMPlayer.OCX', ...
    [10 10 400 300], handles.figureMovieView);
hWMP.controls.pause; 
set(handles.figureMovieView, 'DockControls', 'on', 'HandleVisibility', 'on'); 
handles.hWMP = hWMP; 
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes movieView wait for user response (see UIRESUME)
% uiwait(handles.figureMovieView);


% --- Outputs from this function are returned to the command line.
function varargout = movieView_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
