function varargout = UI_demo(varargin)
% UI_DEMO MATLAB code for UI_demo.fig
%      UI_DEMO, by itself, creates a new UI_DEMO or raises the existing
%      singleton*.
%
%      H = UI_DEMO returns the handle to a new UI_DEMO or the handle to
%      the existing singleton*.
%
%      UI_DEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI_DEMO.M with the given input arguments.
%
%      UI_DEMO('Property','Value',...) creates a new UI_DEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UI_demo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UI_demo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UI_demo

% Last Modified by GUIDE v2.5 03-Jun-2017 11:49:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UI_demo_OpeningFcn, ...
                   'gui_OutputFcn',  @UI_demo_OutputFcn, ...
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


% --- Executes just before UI_demo is made visible.
function UI_demo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UI_demo (see VARARGIN)

% Choose default command line output for UI_demo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global path;
path = './pic';

global croped;
croped = [];

global im3;
im3 = imread('IM23_INIT.jpg');
axes(handles.axes7);
im3_callback = imshow(im3);
set(im3_callback,'ButtonDownFcn',{@pic3Callback,handles});

global im2;
im2 = imread('IM23_INIT.jpg');
axes(handles.axes6);
im2_callback = imshow(im2);
set(im2_callback,'ButtonDownFcn',{@pic2Callback,handles});


% UIWAIT makes UI_demo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UI_demo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im1;
global im2;
global im3;
global path;
im1 = readIm(path);
if im1 == 0
    return 
end
axes(handles.axes5);
im1_callback = imshow(im1);
set(im1_callback,'ButtonDownFcn',{@pic1Callback,handles});
guidata(hObject,handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im1;
global im2;
global im3;
global outim;
global rect;
global croped;
global im1_pre;
set(handles.pushbutton4,'Visible','on');
set(handles.pushbutton5,'Visible','on');
set(handles.pushbutton6,'Visible','on');
set(handles.pushbutton3,'Visible','off');
im1_pre = im1;
if isempty(croped)
    outim = styleTrans(im1, im2, im3);
    im1 = uint8(outim);
    axes(handles.axes5);
    im1_callback = imshow(im1);
    set(im1_callback,'ButtonDownFcn',{@pic1Callback,handles});
    guidata(hObject,handles);
else
    outim = styleTrans(croped, im2, im3);
    croped = [];
    row = round(rect(1)):round(rect(1)+rect(3));
    col = round(rect(2)):round(rect(2)+rect(4));
    im1(col, row, :) = outim;
    axes(handles.axes5);
    im1_callback = imshow(im1);
    set(im1_callback,'ButtonDownFcn',{@pic1Callback,handles});
    guidata(hObject,handles);
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2;
%obtains the slider value from the slider component 
sliderValue = get(handles.slider1,'value');    
slV_N = num2str(sliderValue);
%puts the slider value into the edit text component  
set(handles.text1,'String', slV_N);
imed = double(rgb2gray(im2));
ed = edge(imed,'canny',sliderValue);


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


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
[filename,pathname]=uiputfile({'*.jpg';},'????????','Undefined.jpg');
if ~isequal(filename,0)
    str = [pathname filename];
    px=getframe(handles.axes5);
    imwrite(px.cdata,str,'jpg');
else
    disp('save failed');
end;

function pic1Callback(hObject, eventdata, handles)
global rect;
global croped;
[croped, rect] = imcrop();


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im1;
global im1_pre;
set(handles.pushbutton5,'Visible','off');
set(handles.pushbutton6,'Visible','off');
set(handles.pushbutton3,'Visible','on');
im1 = im1_pre;
axes(handles.axes5);
im1_callback = imshow(im1);
set(im1_callback,'ButtonDownFcn',{@pic1Callback,handles});
guidata(hObject,handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton5,'Visible','off');
set(handles.pushbutton6,'Visible','off');
set(handles.pushbutton3,'Visible','on');

% % --- Executes on mouse press over axes background.
% function axes6_ButtonDownFcn(hObject, eventdata, handles)
% % hObject    handle to axes6 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global path;
% global im2;
% im2 = readIm(path);
% if im2 == 0
%     return 
% end
% axes(handles.axes6);
% im2_callback = imshow(im2);
% set(im2_callback,'ButtonDownFcn',{@pic2Callback,handles});
% %guidata(hObject,handles);

function pic2Callback(hObject, eventdata, handles)
global path;
global im2;
im2 = readIm(path);
if im2 == 0
    return 
end
axes(handles.axes6);
im2_callback = imshow(im2);
set(im2_callback,'ButtonDownFcn',{@pic2Callback,handles});
%guidata(hObject,handles);


% % --- Executes on mouse press over axes background.
% function axes7_ButtonDownFcn(hObject, eventdata, handles)
% % hObject    handle to axes7 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global path;
% global im3;
% im3 = readIm(path);
% if im3 == 0
%     return 
% end
% axes(handles.axes7);
% im3_callback = imshow(im3);
% set(im3_callback,'ButtonDownFcn',{@pic3Callback,handles});
% %guidata(hObject,handles);

function pic3Callback(hObject, eventdata, handles)
global path;
global im3;
im3 = readIm(path);
if im3 == 0
    return 
end
axes(handles.axes7);
im3_callback = imshow(im3);
set(im3_callback,'ButtonDownFcn',{@pic3Callback,handles});
%guidata(hObject,handles);



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



