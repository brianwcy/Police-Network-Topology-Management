function varargout = tops(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tops_OpeningFcn, ...
                   'gui_OutputFcn',  @tops_OutputFcn, ...
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


% --- Executes just before tops is made visible.
function tops_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tops (see VARARGIN)
set(gcf,'name','警务网络可视化'); %第三个参数为要修改的界面名称
% Choose default command line output for tops
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tops wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tops_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%============================================================================场景初始化<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
%============================================================================场景初始化<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
%============================================================================场景初始化<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
%============================================================================场景初始化<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
parameter;

Times        = str2num(get(handles.edit10,'String'));  
PACK         = str2num(get(handles.edit11,'String'));

SEEK         = str2num(get(handles.edit7,'String'));  
rand('state',SEEK); 
SEEK2        = str2num(get(handles.edit8,'String'));  
POWERS       = str2num(get(handles.edit12,'String'));
POWERS2      = str2num(get(handles.edit14,'String'));
SNRs         = str2num(get(handles.edit15,'String'));
SPEEDs       = str2num(get(handles.edit16,'String'));

A            = str2num(get(handles.edit1,'String'));  
nodes_number = str2num(get(handles.edit2,'String'));  
R            = str2num(get(handles.edit3,'String'));  

X            = rand(1,nodes_number)*A;  
Y            = rand(1,nodes_number)*A;  

views        = get(handles.checkbox1,'Value');

%节点初始化，这里直接进行编程，不通过GUI界面设置
%节点状态的初始化
%节点状态的初始化
%负载
rand('state',SEEK2); 
tmps            = 0.7*rand(3,nodes_number);
%假设节点的负载时随机的
% Fload = tmps(1,:);%负载百分比0~1之间
[xs,ys,ds,iscom] = func_dist([X',Y'],nodes_number,R);
for i = 1:nodes_number
    dd       = ds(i,:);
    NEAR     = length(find(dd<R));
    Fload(i) = 0.4+0.6*NEAR/nodes_number;
end
%剩余能量
PLest          = 0.95 - 0.1*tmps(2,:)/0.7;%剩余能量百分比0~1之间
%损坏
BREAK          = tmps(3,:) >= 0.2;%0表示的损坏的节点，1表示正常的节点


axes(handles.axes1); 
cla reset;
plot(X,Y,'b s');
hold on; 
xlabel('x（m）');
ylabel('y（m）');
hold on; 
for i = 1:nodes_number
    %给节点标注号码
    if views == 1
       text(X(i)+2, Y(i)+2, num2str(i));    
    end
    for j = 1:nodes_number
        distance = sqrt((X(i) - X(j))^2 + (Y(i) - Y(j))^2); 
        if distance <= R
           nodes_link(i, j) = 1;
           grid on;
        else
           nodes_link(i, j) = inf;
        end;
     end;
end;



%============================================================================路径搜索<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
%============================================================================路径搜索<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
%============================================================================路径搜索<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
%============================================================================路径搜索<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
parameter;
if get(handles.radiobutton1,'value')
    SEL1=1;
elseif get(handles.radiobutton2,'value')
    SEL1=2;
elseif get(handles.radiobutton3,'value')
    SEL1=3;
end
if get(handles.radiobutton4,'value')
    SEL2=1;
elseif get(handles.radiobutton5,'value')
    SEL2=2;
end
S      = str2num(get(handles.edit5,'String'));  
D      = str2num(get(handles.edit6,'String'));  
   


if S < 1 | S > nodes_number
   msgbox('源节点错误，请重新输入');  
end
if D < 1 | D > nodes_number
   msgbox('目标节点错误，请重新输入');   
end

axes(handles.axes1); 
cla reset;
plot(X,Y,'b s');
hold on; 
xlabel('空间横坐标 x  单位：m');
ylabel('空间纵坐标 y  单位：m');
hold on; 
grid on;
for i = 1:nodes_number
    %给节点标注号码
    if views == 1
       text(X(i)+2, Y(i)+2, num2str(i));    
    end   
    for j = 1:nodes_number
        distance = sqrt((X(i) - X(j))^2 + (Y(i) - Y(j))^2); 
        if distance <= R
           nodes_link(i, j) = 1;
           grid on;
        else
           nodes_link(i, j) = inf;
        end;
     end;
end;
%%
%LEACH
if SEL1 == 1
   [PATHS,hop] = leach_path_discovery(nodes_number,nodes_link,S,D); 
   l=length(PATHS);  
end

%%
%AODV
if SEL1 == 2
   [PATHS,hop] = aodv_path_discovery(nodes_number,nodes_link,S,D); 
   l=length(PATHS);
end

%%
%改进AODV
if SEL1 == 3
   [PATHS,hop] = aodv_path_discovery_new(nodes_number,nodes_link,S,D,Fload,PLest,BREAK);    
   l           = length(PATHS); 
end

if l==0 & S~=D 
   fprintf('源节点 %d 到目的节点 %d 的路径为：空！\n',S,D);
   fprintf('\n');
   plot(X(S),Y(S),'rp','markersize',15); 
   plot(X(D),Y(D),'rp','markersize',15);
elseif l==0 & S==D
       fprintf('源节点 %d 与目的节点 %d 为同一节点。\n',S,D);
       fprintf('跳数为 %d 。\n',hop);
       fprintf('\n')
       plot(X(D),Y(D),'rp','markersize',15);
else fprintf('源节点 %d 到目的节点 %d 的路径为：',S,D);
     i=2;
     fprintf('%d',S);
     while i~=l+1
           fprintf(' -> %d',PATHS(i));
           i=i+1;
     end;
     fprintf('\n');
     fprintf('跳数为 %d 。\n',hop);
     fprintf('\n');
end;
if l ~= 0
   for i = 1:(l-1)
       line([X(PATHS(i)) X(PATHS(i+1))],[Y(PATHS(i)) Y(PATHS(i+1))],'Color','r','LineWidth',1.50);
   end;
end;

if SEL1 == 1
   save data_save\path1.mat l S D X Y PATHS 
end
if SEL1 == 2
   save data_save\path2.mat l S D X Y PATHS 
end
if SEL1 == 3
   save data_save\path3.mat l S D X Y PATHS 
end

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
set(handles.radiobutton4,'value',1);
set(handles.radiobutton5,'value',0);

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
set(handles.radiobutton4,'value',0);
set(handles.radiobutton5,'value',1);

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
set(handles.radiobutton1,'value',1);
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',0);


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',1);
set(handles.radiobutton3,'value',0);


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',1);

% Hint: get(hObject,'Value') returns toggle state of radiobutton3



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%============================================================================性能仿真<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
%============================================================================性能仿真<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
%============================================================================性能仿真<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
%============================================================================性能仿真<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
parameter;


 
if SEL1 == 1
   [Throughput,Power,Loads,droprate,death] = func_leach_performance(R,A,PACK,nodes_number,Times,X,Y,SEL2,POWERS,POWERS2,SNRs); 
end
if SEL1 == 2
   [Throughput,Power,Loads,droprate,death] = func_AODV_performance(R,nodes_link,A,PACK,nodes_number,Times,X,Y,SEL2,POWERS,POWERS2,SNRs);
end
if SEL1 == 3
   [Throughput,Power,Loads,droprate,death] = func_advance_AODV_performance(R,nodes_link,A,PACK,nodes_number,Times,X,Y,SEL2,POWERS,POWERS2,SNRs,Fload,PLest,BREAK);  
end    
 
axes(handles.axes2); 
cla reset;
plot(Throughput,'b','linewidth',2);
grid on;
xlabel('x(time)');
ylabel('y(数据吞吐)');


axes(handles.axes3); 
cla reset;
plot(Power,'b','linewidth',2);
grid on;
xlabel('x(time)');
ylabel('y(网络能量消耗)');

axes(handles.axes4); 
cla reset;
plot(Loads,'b','linewidth',2);
grid on;
xlabel('x(time)');
ylabel('y(负载均衡度对比)');

axes(handles.axes5); 
cla reset;
plot(droprate,'b','linewidth',2);
grid on;
xlabel('x(time)');
ylabel('y(丢包率)');

axes(handles.axes6); 
cla reset;
plot(death,'b','linewidth',2);
grid on;
xlabel('x(time)');
ylabel('y(死亡节点数)');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
parameter;
 
if SEL2 == 1
axes(handles.axes2); 
cla reset;
load data_save\r0_1.mat
plot(Throughput,'b','linewidth',2);
hold on
load data_save\r1_1.mat
plot(Throughput,'r','linewidth',2);
hold on
load data_save\r2_1.mat
plot(Throughput,'g','linewidth',2);
hold on

legend('leach','AODV','改进AODV');
grid on;
xlabel('x(time)');
ylabel('y(数据吞吐)');


axes(handles.axes3); 
cla reset;
load data_save\r0_1.mat
plot(Power,'b','linewidth',2);
hold on
load data_save\r1_1.mat
plot(Power,'r','linewidth',2);
hold on
load data_save\r2_1.mat
plot(Power,'g','linewidth',2);
hold on
legend('leach','AODV','改进AODV');
grid on;
xlabel('x(time)');
ylabel('y(网络能量消耗)');



axes(handles.axes4); 
cla reset;
load data_save\r0_1.mat
plot(Loads,'b','linewidth',2);
hold on
load data_save\r1_1.mat
plot(Loads,'r','linewidth',2);
hold on
load data_save\r2_1.mat
plot(Loads,'g','linewidth',2);
hold on
legend('leach','AODV','改进AODV');
grid on;
xlabel('x(time)');
ylabel('y(负载均衡度对比)');



axes(handles.axes5); 
cla reset;
load data_save\r0_1.mat
plot(droprate,'b','linewidth',2);
hold on
load data_save\r1_1.mat
plot(droprate,'r','linewidth',2);
hold on
load data_save\r2_1.mat
plot(droprate,'g','linewidth',2);
hold on
legend('leach','AODV','改进AODV');
grid on;
xlabel('x(time)');
ylabel('y(丢包率)');



axes(handles.axes6); 
cla reset;
load data_save\r0_1.mat
plot(death,'b','linewidth',2);
hold on
load data_save\r1_1.mat
plot(death,'r','linewidth',2);
hold on
load data_save\r2_1.mat
plot(death,'g','linewidth',2);
hold on
legend('leach','AODV','改进AODV');
grid on;
xlabel('x(time)');
ylabel('y(死亡节点数)');

end




if SEL2 == 2
axes(handles.axes2); 
cla reset;
load data_save\r0_2.mat
plot(Throughput,'b','linewidth',2);
hold on
load data_save\r1_2.mat
plot(Throughput,'r','linewidth',2);
hold on
load data_save\r2_2.mat
plot(Throughput,'g','linewidth',2);
hold on

legend('leach','AODV','改进AODV');
grid on;
xlabel('x(time)');
ylabel('y(数据吞吐)');


axes(handles.axes3); 
cla reset;
load data_save\r0_2.mat
plot(Power,'b','linewidth',2);
hold on
load data_save\r1_2.mat
plot(Power,'r','linewidth',2);
hold on
load data_save\r2_2.mat
plot(Power,'g','linewidth',2);
hold on
legend('leach','AODV','改进AODV');
grid on;
xlabel('x(time)');
ylabel('y(网络能量消耗)');



axes(handles.axes4); 
cla reset;
load data_save\r0_2.mat
plot(Loads,'b','linewidth',2);
hold on
load data_save\r1_2.mat
plot(Loads,'r','linewidth',2);
hold on
load data_save\r2_2.mat
plot(Loads,'g','linewidth',2);
hold on
legend('leach','AODV','改进AODV');
grid on;
xlabel('x(time)');
ylabel('y(负载均衡度对比)');



axes(handles.axes5); 
cla reset;
load data_save\r0_2.mat
plot(droprate,'b','linewidth',2);
hold on
load data_save\r1_2.mat
plot(droprate,'r','linewidth',2);
hold on
load data_save\r2_2.mat
plot(droprate,'g','linewidth',2);
hold on
legend('leach','AODV','改进AODV');
grid on;
xlabel('x(time)');
ylabel('y(丢包率)');



axes(handles.axes6); 
cla reset;
load data_save\r0_2.mat
plot(death,'b','linewidth',2);
hold on
load data_save\r1_2.mat
plot(death,'r','linewidth',2);
hold on
load data_save\r2_2.mat
plot(death,'g','linewidth',2);
hold on
legend('leach','AODV','改进AODV');
grid on;
xlabel('x(time)');
ylabel('y(死亡节点数)');

end
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
clear;
close all;
warning off;



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
parameter;
 
for pso = 1:100:Times
    
    pso
    
    X = X + SPEEDs*randn(size(X));
    Y = Y + SPEEDs*randn(size(X));
    
    
    S = str2num(get(handles.edit5,'String'));  
    D = str2num(get(handles.edit6,'String'));  
 
    if S < 1 | S > nodes_number
       msgbox('源节点错误，请重新输入');  
    end
    if D < 1 | D > nodes_number
       msgbox('目标节点错误，请重新输入');   
    end

    axes(handles.axes1); 
    cla reset;
    plot(X,Y,'b s');
    hold on; 
    xlabel('空间横坐标 x  单位：m');
    ylabel('空间纵坐标 y  单位：m');
    hold on; 
    grid on;
    for i = 1:nodes_number
        %给节点标注号码
        if views == 1
           text(X(i)+2, Y(i)+2, num2str(i));    
        end   
        for j = 1:nodes_number
            distance = sqrt((X(i) - X(j))^2 + (Y(i) - Y(j))^2); 
            if distance <= R
               nodes_link(i, j) = 1;
               grid on;
            else
               nodes_link(i, j) = inf;
            end;
         end;
    end;
    %%
    
    if SEL1 == 1
       [PATHS,hop] = leach_path_discovery(nodes_number,nodes_link,S,D); 
       l=length(PATHS);  
    end

    %%
    
    if SEL1 == 2
       [PATHS,hop] = aodv_path_discovery(nodes_number,nodes_link,S,D); 
       l=length(PATHS);
    end

    %%
    
    if SEL1 == 3
       [PATHS,hop] = aodv_path_discovery_new(nodes_number,nodes_link,S,D,Fload,PLest,BREAK);    
       l           = length(PATHS); 
    end

    if l==0 & S~=D 
       fprintf('源节点 %d 到目的节点 %d 的路径为：空！\n',S,D);
       fprintf('\n');
       plot(X(S),Y(S),'rp','markersize',15); 
       plot(X(D),Y(D),'rp','markersize',15);
    elseif l==0 & S==D
           fprintf('源节点 %d 与目的节点 %d 为同一节点。\n',S,D);
           fprintf('跳数为 %d 。\n',hop);
           fprintf('\n')
           plot(X(D),Y(D),'rp','markersize',15);
    else fprintf('源节点 %d 到目的节点 %d 的路径为：',S,D);
         i=2;
         fprintf('%d',S);
         while i~=l+1
               fprintf(' -> %d',PATHS(i));
               i=i+1;
         end;
         fprintf('\n');
         fprintf('跳数为 %d 。\n',hop);
         fprintf('\n');
    end;
    if l ~= 0
       for i = 1:(l-1)
           line([X(PATHS(i)) X(PATHS(i+1))],[Y(PATHS(i)) Y(PATHS(i+1))],'Color','r','LineWidth',1.50);
       end;
    end;
    axis([0,A,0,A]);
pause(0.1);
end
