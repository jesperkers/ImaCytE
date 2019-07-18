function varargout = IMACytE(varargin)
% IMACYTE MATLAB code for IMACytE.fig
%      IMACYTE, by itself, creates a new IMACYTE or raises the existing
%      singleton*.
%
%      H = IMACYTE returns the handle to a new IMACYTE or the handle to
%      the existing singleton*.
%
%      IMACYTE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMACYTE.M with the given input arguments.
%
%      IMACYTE('Property','Value',...) creates a new IMACYTE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IMACytE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IMACytE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IMACytE

% Last Modified by GUIDE v2.5 18-Jul-2019 17:22:55
%   Copyright 2019 Antonios Somarakis (LUMC) ImaCytE toolbox

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IMACytE_OpeningFcn, ...
                   'gui_OutputFcn',  @IMACytE_OutputFcn, ...
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


% --- Executes just before IMACytE is made visible.
function IMACytE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IMACytE (see VARARGIN)

% % Choose default command line output for IMACytE
% handles.output = hObject;
% 
% % Update handles structure
% guidata(hObject, handles);
clear global
cla(handles.uipanel4)
cla(handles.uipanel1)
cla(handles.uipanel2)

% delete(handles.Slider)
% delete( handles.Edit_max)
% delete( handles.Text_max)
% delete(handles.Text_val)
% delete(handles.Edit_val)

setappdata(handles.figure1,'clustMembsCell',[])
set(handles.Markerlist,'String',[]);
set(handles.popup_Marker_selection,'Visible','off'); 

set(handles.uipanel1,'Visible','off')
set(handles.uipanel4,'Visible','off')
set(handles.uipanel2,'Visible','off')
set(handles.slider2,'Visible','off')
set(handles.arcsin,'Value',0);
set(handles.arcsin,'Visible','off');
set(handles.Compute_map,'Visible','off');


% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
setappdata(0,'mygui',gcf);
set(handles.figure1,'windowbuttonmotionfcn',[]);

set( findall( gcf, '-property', 'Units' ), 'Units', 'Normalized' ) %in order to make window resizable




% UIWAIT makes IMACytE wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = IMACytE_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
jFrame = get(handle(gcf),'JavaFrame');
jFrame.setMaximized(true);  



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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

set( hObject, 'Min', 1, 'Max', 2, 'Value', 1.5 )

% --- Executes on selection change in popup_Marker_selection.
function popup_Marker_selection_Callback(hObject, eventdata, handles)
% hObject    handle to popup_Marker_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_Marker_selection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_Marker_selection

% contents = cellstr(get(hObject,'String'));
value1=get(hObject,'Value');
setappdata(handles.figure1,'M_sel',value1);

if value1 == 1 
    Update_Scatter_Tissue(handles)
    heatmap_data(handles)
    set(handles.figure1,'windowbuttonmotionfcn',@mousemove);

% elseif value1 == 2
%     numClust=unique(clustered);
%     cluster2dataCell = cell(length(numClust),1);
%     for cN = 1:length(numClust)
%         myMembers = find(clustered == cN);
%         cluster2dataCell{cN} = myMembers';
%     end
%     setappdata(handles.figure1,'clustMembsCell',cluster2dataCell);
%     setappdata(handles.figure1,'cluster_names', cell(1,length(cluster2dataCell)))
%     Update_Scatter_Tissue(handles)
%     heatmap_data(handles)
else
   Update_Scatter_Tissue_Continious_var(handles); 
end

% --- Executes during object creation, after setting all properties.
function popup_Marker_selection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_Marker_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Markerlist.
function Markerlist_Callback(hObject, eventdata, handles)
% hObject    handle to Markerlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Markerlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Markerlist

selected_markers = get(hObject,'Value') ;
setappdata(handles.figure1,'selected_markers',selected_markers);


% --- Executes during object creation, after setting all properties.
function Markerlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Markerlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Compute_map.
function Compute_map_Callback(hObject, eventdata, handles)
% hObject    handle to Compute_map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global n_data
global tsne_map
global cell4
global tsne_idx
tsne_idx=0;


samples={cell4(:).name};
selected_samples=listdlg('PromptString','Select samples to utilize:','ListString',samples);
cell4=cell4(selected_samples);
setappdata(handles.figure1,'selection_samples',[]);

prev=0;
for i=1:length(cell4)    
    tsne_idx(prev+1:prev+length(cell4(i).idx))=i;
    prev=prev+ length(cell4(i).idx);
end

n_data=double(vertcat(cell4(:).data));

markerlist=getappdata(handles.figure1,'selected_markers');
if isempty(markerlist); warndlg('Please select features for tSNE'); return; end
used_data=n_data(:,markerlist);

tsne_choice=listdlg('PromptString','Select tSNE method to utilize:','ListString',{'tSNE', 'A-tSNE'},'SelectionMode','single');
f = waitbar(0,'Please wait...');
switch tsne_choice
    case 1
        try
            tsne_map=tsne(my_normalize(used_data,'column'));
        catch ME
            rethrow(ME)
        end
    case 2
        try
            tsne_map=fast_atsne(my_normalize(used_data,'column'));
        catch ME
            rethrow(ME)
        end
end
waitbar(1,f,'Finished');

f_scatter=getappdata(handles.figure1,'Scatter_Figure');
delete(get(f_scatter,'Children'));
x=axes(f_scatter);
scatter(x,tsne_map(:,1),tsne_map(:,2),'filled');
set(x,'Tag','Scatter_axes');
set(x,'Position',[0.05 0.05 0.9 0.9]);

handles.Slider = uicontrol(handles.figure1,'style', 'Slider', 'Min', 0, 'Max', 20, 'Value',10, 'Units','normalized','position', [0 0.9 0.067 0.025 ], 'callback', {@ slider2_Callback, handles});
handles.Text_val = uicontrol(handles.figure1,'Style','text','String','Value(#Clusters)','Units','normalized','position', [0.01 0.94 0.03 0.02 ]);
% handles.Edit_val = uicontrol(handles.figure1,'Style','text','String',num2str(get(handles.Slider,'Value')),'Units','normalized','position', [0.025 0.925 0.015 0.02 ]);
handles.Text_max = uicontrol(handles.figure1,'Style','text','String','Max','Units','normalized','position', [0.048 0.94 0.02 0.02 ]);
handles.Edit_max = uicontrol(handles.figure1,'Style','edit','String',num2str(get(handles.Slider,'max')),'Units','normalized','position', [0.05 0.926 0.015 0.02], 'Callback',{@ MaxCallback, handles});
guidata(handles.figure1,handles)


set(handles.uipanel1,'Visible','on')

function MinCallback(hObject, ~, handles)

        value_min=str2double(get(hObject, 'String'));
        if value_min > str2double(get(handles.Slider, 'Value'))
            set(handles.Slider, 'Value', value_min+1);
        end
        set(handles.Slider, 'Min', value_min);
        guidata(handles.figure1,handles)


function MaxCallback(hObject, ~, handles)

        value_max=str2double(get(hObject, 'String'));
        if value_max < get(handles.Slider, 'Value')
            set(handles.Slider, 'Value', value_max -0.5);
        end
        set(handles.Slider, 'Max', value_max);
        guidata(handles.figure1,handles)


% --- Executes on button press in arcsin.
function arcsin_Callback(hObject, eventdata, handles)
% hObject    handle to arcsin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of arcsin
global n_data
global cell4

setappdata(handles.figure1,'Arcsinh',get(hObject,'Value'))

if getappdata(handles.figure1,'Arcsinh')
    n_data=asinh(double(vertcat(cell4(:).data))/5);
else
    n_data=double(vertcat(cell4(:).data));
end



% --------------------------------------------------------------------
function Options_Callback(hObject, eventdata, handles)
% hObject    handle to Options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Load_data_Callback(hObject, eventdata, handles)
% hObject    handle to Load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global cell4
global tsne_map
global n_data
global tsne_idx
tsne_idx=0;
tsne_map=[];

mode='Imaging'; %'Vectra'
switch mode
    case 'Imaging'         
        cell4=[];
        r=uigetdir();
        direct_=dir(r);
        f = waitbar(0,'Please wait...');
        if isempty(find(vertcat(direct_(3:end).isdir), 1))
            cell4=Load_Multiple_Images_IMACytE(r);
        else
            for i=3:length(direct_)
                if direct_(i).isdir
                    try
                        cell4=[cell4 ; Load_Multiple_Images_IMACytE([direct_(i).folder '\' direct_(i).name])];
                        waitbar((1/(length(direct_)-2)*(i-2)),f,['Loaded ' num2str(i-2) ' out of ' num2str(length(direct_)-2) ' images ']);
                    catch
                        warndlg(['Problem loading File: ' direct_(i).folder '\' direct_(i).name],'Error');
                    end
                end
            end
        end
        waitbar(1,f,'Finished');
end

markers=cell4(1).cell_markers;
% for i=1:size(cell4(1).cell_markers,2)
%     markers{i}=['Marker ' num2str(i)];
% end
setappdata(handles.figure1,'markers',markers);

n_data=double(vertcat(cell4(:).data));
prev=0;
for i=1:length(cell4)
    tsne_idx(prev+1:prev+length(cell4(i).idx))=i;
    prev=prev+ length(cell4(i).idx);
end

set(handles.Markerlist,'String',markers);
set(handles.Markerlist,'Value',[]);

f_scatter=handles.uipanel1;
setappdata(handles.figure1,'Scatter_Figure',f_scatter);

f_image=handles.uipanel2;
setappdata(handles.figure1,'Tissue_Figure',f_image);
d = uicontextmenu(get(f_image,'Parent'));
Sava_as_interaction=uimenu('Parent',d,'Label','Save_as','Callback',{@Save_as_Context_Menu, f_image, handles});
set(f_image,'UIContextMenu',d);

f_heatmap=handles.uipanel4;
setappdata(handles.figure1,'Heatmap_Figure',f_heatmap);


gg=get(handles.uipanel2,'Children');
delete(gg);
set(handles.uipanel2,'Visible','on')
% set(handles.axes6,'Visible','off')
set(handles.arcsin,'Visible','on');
set(handles.Compute_map,'Visible','on');
uicontrol(handles.uipanel2,'Style', 'pushbutton', 'String', 'Samples','Units','normalized','position', [0.1 0.96 0.2 0.025 ], 'callback', {@ Samples_Callbacki, handles});
uicontrol(handles.uipanel2,'Style', 'pushbutton', 'String', 'Markers','Units','normalized','position', [0.7 0.96 0.2 0.025 ], 'callback', {@ Markers_Callbacki, handles}); 

% --------------------------------------------------------------------
function Interaction_Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to Interaction_Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cmap=getappdata(handles.figure1,'cmap');
clustMembsCell=getappdata(handles.figure1, 'clustMembsCell');
cluster_names=getappdata(handles.figure1, 'cluster_names');
markerlist=getappdata(handles.figure1,'selected_markers');
numClust=length(clustMembsCell);
for i=1:numClust
    point2cluster(clustMembsCell{i})=i;
end

% uisave({'clustMembsCell','cmap','cluster_names'},'For_interaction.mat')
Interactions_Motifs(clustMembsCell,cmap,1,cluster_names,markerlist);


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global tsne_map
global heatmap_selection
% persistent previous
    
% pause(0.5);
% bandwidth=get(hObject,'Value');
% if isequal(bandwidth,previous)
%     return
% else
%     previous=bandwidth;
% end
bandwidth=get(hObject,'Value');

[~,~,clustMembsCell] = HGMeanShiftCluster(tsne_map',bandwidth,'gaussian');

handles.Edit_val = uicontrol(handles.figure1,'Style','text','String',[num2str(round(bandwidth,2)) '(' num2str(length(clustMembsCell)) ')' ],'Units','normalized','position', [0.02 0.925 0.03 0.02 ]);
try
    clustMembsCell(cellfun(@isempty,clustMembsCell))=[];
    setappdata(handles.figure1, 'clustMembsCell',clustMembsCell);

    cluster_names=cell(1,length(clustMembsCell));
    for i=1:length(clustMembsCell)
        cluster_names{i}=['Cluster' num2str(i)];
    end
    setappdata(handles.figure1,'cluster_names',cluster_names);
    
    setappdata(handles.figure1,'selection_markers',1);
    color_assignment( handles)
    Update_Scatter(handles); 
    Update_Tissue(handles); 
    heatmap_data(handles)
    set(handles.uipanel4,'Visible','on')

    set(handles.figure1,'windowbuttonmotionfcn',@mousemove);
    heatmap_selection=[];
catch ME
    warndlg(ME.message)
    errordlg('Adjust the bandwidth accordingly')
end

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set( hObject, 'Min', 1, 'Max', 30, 'Value', 15 )


% --- Executes on button press in Markers.
function Markers_Callbacki(~, ~, handles)

Markers_Callback([], [], handles)

function Samples_Callbacki(~, ~, handles)

Samples_Callback([],[], handles)

% --------------------------------------------------------------------
function Load_Clustering_Callback(hObject, eventdata, handles)
% hObject    handle to Load_Clustering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global heatmap_selection
global tsne_map

[file,path] = uigetfile('*.mat');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end

clustMembsCell=load([path '\' file]);
old_clustMembsCell=getappdata(handles.figure1, 'clustMembsCell');

cmap=clustMembsCell.cmap;
try
    markerlist=clustMembsCell.markerlist;
    setappdata(handles.figure1,'selected_markers',markerlist);
catch
end
cluster_names=clustMembsCell.cluster_names;
tsne_map=clustMembsCell.t_scatter;
try 
    T=clustMembsCell.T;
    setappdata(handles.figure1,'h_cluster',T);
catch
end
clustMembsCell=clustMembsCell.clustMembsCell;
%if ~isequal(length([clustMembsCell{:}]),length([old_clustMembsCell{:}]));     errordlg('Different number of cells loading than already loaded smaples') ; end

setappdata(handles.figure1,'cluster_names',cluster_names);
setappdata(handles.figure1, 'clustMembsCell',clustMembsCell);
setappdata(handles.figure1, 'cmap',cmap);
    
setappdata(handles.figure1,'selection_markers',1);
Update_Tissue(handles); 
Update_Scatter(handles); 
heatmap_data(handles)
set(handles.uipanel4,'Visible','on')
set(handles.uipanel1,'Visible','on')

set(handles.figure1,'windowbuttonmotionfcn',@mousemove);
heatmap_selection=[];


% --------------------------------------------------------------------
function Save_Clustering_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Clustering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global tsne_map
global tsne_idx

markerlist=getappdata(handles.figure1,'selected_markers');
cluster_names=getappdata(handles.figure1, 'cluster_names');
clustMembsCell=getappdata(handles.figure1, 'clustMembsCell');
cmap=getappdata(handles.figure1, 'cmap');
t_scatter=tsne_map;
T=getappdata(handles.figure1,'h_cluster');
tsne_idx=tsne_idx;

uisave({'clustMembsCell','cmap','t_scatter','cluster_names','T','tsne_idx','markerlist'},'clustered_data.mat')

% --------------------------------------------------------------------
function Save_Image_as_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Image_as (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


saveas(gcf,'Screenshot.pdf');

selection_markers=getappdata(handles.figure1,'selection_markers');
f_scatter=figure;
setappdata(handles.figure1,'Scatter_Figure',f_scatter);
f_image=figure;
setappdata(handles.figure1,'Tissue_Figure',f_image);
f_heatmap=figure;
setappdata(handles.figure1,'Heatmap_Figure',f_heatmap);
% h=[f_scatter f_image f_heatmap handles.figure1];
% set(h, 'WindowStyle', 'Docked');

if selection_markers==1
    try
        Update_Scatter(handles); 
    catch
    end
    Update_Tissue(handles); 
    heatmap_data(handles)

else
    try
        Update_Scatter_Continious_var(handles); 
    catch
    end
    Update_Tissue_Continious_var(handles); 
end

f_scatter=handles.uipanel1;
setappdata(handles.figure1,'Scatter_Figure',f_scatter);
f_image=handles.uipanel2;
setappdata(handles.figure1,'Tissue_Figure',f_image);
f_heatmap=handles.uipanel4;
setappdata(handles.figure1,'Heatmap_Figure',f_heatmap);


% --------------------------------------------------------------------
function Batch_effect_Removal_Callback(hObject, eventdata, handles)
% hObject    handle to Batch_effect_Removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global cell4
global tsne_map
global tsne_idx

tsne_idx=[];
tsne_map=[];
f = waitbar(0,'Please wait...');

cell4=debatching(cell4);
markers=cell4(1).cell_markers;
setappdata(handles.figure1,'markers',markers);

prev=0;
for i=1:length(cell4)    
    tsne_idx(prev+1:prev+length(cell4(i).idx))=i;
    prev=prev+ length(cell4(i).idx);
end

waitbar(1,f,'Finished');
set(handles.Markerlist,'String',markers);
set(handles.Markerlist,'Value',[]);
set(handles.uipanel1,'Visible','off')
set(handles.uipanel4,'Visible','off')
set(handles.arcsin,'Visible','off')

delete(get(handles.uipanel2,'Children'));
uicontrol(handles.uipanel2,'Style', 'pushbutton', 'String', 'Samples','Units','normalized','position', [0.1 0.96 0.2 0.025 ], 'callback', {@ Samples_Callback, handles});
uicontrol(handles.uipanel2,'Style', 'pushbutton', 'String', 'Markers','Units','normalized','position', [0.7 0.96 0.2 0.025 ], 'callback', {@ Markers_Callback, handles});


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Scatter_overlay_Callback(hObject, eventdata, handles)
% hObject    handle to Scatter_overlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
scatter_overlay(handles);

% --------------------------------------------------------------------
function cluster_per_sample_Callback(hObject, eventdata, handles)
% hObject    handle to cluster_per_sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cluster_per_sample(handles);

% --------------------------------------------------------------------
function Find_Selection_Callback(hObject, eventdata, handles)
% hObject    handle to Find_Selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global find_selection

temp=listdlg('PromptString','Select samples to utilize:','ListString',{'Show previous selected samples'; 'Show only samples that have been selected'},'SelectionMode','single','InitialValue',find_selection + 1);
find_selection=temp -1;


% --------------------------------------------------------------------
function Export_fcs_Callback(hObject, eventdata, handles)
% hObject    handle to Export_fcs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cell4
prev=0;
r=uigetdir;
for i=1:length(cell4)
    temo=1:length(cell4(i).idx);
    temo=temo+prev;
    temo=[temo' ones(length(cell4(i).idx),1)*(i) cell4(i).data];
    temp_markers=[ 'Cell_id'  'Image_id' cell4(1).cell_markers];
    fca_writefcs([r '\' cell4(i).name '_mean_aggregated.fcs'],temo,temp_markers,temp_markers);
    my_csvwrite([r '\' cell4(i).name '_mean_aggregated.csv'],temo,temp_markers);
    prev=prev+ length(cell4(i).idx);
end



% --------------------------------------------------------------------
function Import_from_fcs_Callback(hObject, eventdata, handles)
% hObject    handle to Import_from_fcs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global heatmap_selection
global tsne_idx

r=uigetdir();
direct_=dir(r);
count=0;
for i=3:length(direct_)
    [a,~]=fca_readfcs([direct_(i).folder '\' direct_(i).name]);
    clustMembsCell{i-2}=a(:,1);
    count=count+length(a(:,1));
end

if ~isequal(count,length(tsne_idx))
    errordlg('Not all cells have an assigned cluster')
end

setappdata(handles.figure1, 'clustMembsCell',clustMembsCell);

cluster_names=cell(1,length(clustMembsCell));
for i=1:length(clustMembsCell)
    cluster_names{i}=['Cluster' num2str(i)];
end
setappdata(handles.figure1,'cluster_names',cluster_names);
    
setappdata(handles.figure1,'selection_markers',1);
color_assignment( handles)

try
    Update_Scatter(handles); 
catch
end

Update_Tissue(handles);
heatmap_data(handles)
set(handles.uipanel4,'Visible','on')

set(handles.figure1,'windowbuttonmotionfcn',@mousemove);
heatmap_selection=[];