%DimasHerlambang/123190140
function varargout = responsiSAW(varargin)
% RESPONSISAW MATLAB code for responsiSAW.fig
%      RESPONSISAW, by itself, creates a new RESPONSISAW or raises the existing
%      singleton*.
%
%      H = RESPONSISAW returns the handle to a new RESPONSISAW or the handle to
%      the existing singleton*.
%
%      RESPONSISAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSISAW.M with the given input arguments.
%
%      RESPONSISAW('Property','Value',...) creates a new RESPONSISAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before responsiSAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to responsiSAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help responsiSAW

% Last Modified by GUIDE v2.5 25-Jun-2021 17:02:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @responsiSAW_OpeningFcn, ...
                   'gui_OutputFcn',  @responsiSAW_OutputFcn, ...
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


% --- Executes just before responsiSAW is made visible.
function responsiSAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to responsiSAW (see VARARGIN)

% Choose default command line output for responsiSAW
handles.output = hObject;


opts = detectImportOptions('DATA RUMAH.xlsx');%untuk memberi tahu fungsi cara mengimpor data
opts.SelectedVariableNames = [1 3:8];%memilih nama Kolomnya
data = readmatrix('DATA RUMAH.xlsx',opts);%untuk menampilkan data excel

set(handles.table1,'data',data);%menampilkan di table 1 gui

% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');%gui auto di tengah

% UIWAIT makes responsiSAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = responsiSAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Proses.
function Proses_Callback(hObject, eventdata, handles)
% hObject    handle to Proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


opts = detectImportOptions('DATA RUMAH.xlsx');%untuk memberi tahu fungsi cara mengimpor data
opts.SelectedVariableNames = (3:8);%memilih nama Kolomnya
x = readmatrix('DATA RUMAH.xlsx',opts);%untuk menampilkan data excel
k=[0,1,1,1,1,1];%nilai atribut, dimana 0= atribut biaya &1= atribut keuntungan
w=[0.30,0.20,0.23,0.10,0.07,0.10];% bobot untuk masing-masing kriteria


%tahapan 1. normalisasi matriks
[m n]=size (x); %matriks m x n dengan ukuran sebanyak variabel x (input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
for j=1:n,
    if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=x(:,j)./max(x(:,j));
    else
        R(:,j)=min(x(:,j))./x(:,j);
    end;
end;

%tahapan kedua, proses perangkingan
for i=1:m,
 V(i)= sum(w.*R(i,:));
end;

Vtranspose=V.';%transpose matrik
Vtranspose=num2cell(Vtranspose);
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (2);
x2= readtable('DATA RUMAH.xlsx',opts);
x2 = table2cell(x2);
x2=[x2 Vtranspose];
x2=sortrows(x2,-2);
x2 = x2(1:20,1);

set(handles.table2, 'data', x2);%menampilkan hasil rekomendasi di table 2 gui
%DimasHerlambang/123190140