%% MEMF Plot Generator
%   Reads the .f06 file produced by NASTRAN SEMODES (SOL 103) analysis and 
%   generates various Modal Effective Mass Fraction plots.
%
%   plot1: Modal Effective Mass Fraction [Translation]
%   plot2: Modal Effective Mass Sum [Translation]
%   plot3: Modal Effective Mass Fraction [Rotation]
%   plot4: Modal Effective Mass Sum [Rotation]
%   plot5: Modal Effective Mass Fraction [Translation & Rotation]
%
%   C. Kim 27July2018, JHUAPL

%Updates
%   17Oct2018 - Renamed to "SCRIPT_memfPlotGenerator". Added "NOTES" 
%               section.

%ToDo
%   Add preallocation for Beginning and Ending arrays.

%Notes
%   watch this clip to understand NASTRAN input file formats
%   this code will only work if the input file is SMALL FIELD Format
%   https://www.youtube.com/watch?v=bqmwt8CJfxA&feature=PlayList&p=9861123CA1CC83AA&index=8

%% Initialize
clear
close all

%find filepath 
[file, path]=uigetfile('*.f06');
fileName=fullfile(path,file);
S=fileread(fileName); 

%split by char(10), which is a carriage return in ASCII. char(13) doesn't work. 
C = strsplit(S, char(10));

%compare the first 81 characters of the string to find start of MEMF table
ini = strncmp(C,'                                                    MODAL EFFECTIVE MASS FRACTION',81);
location=find(ini);

%% Algorithm
%2nd instance of the table title is the MEMF-Rotation Table. 6 lines prior 
%to that is the last line of hte MEMF-Translation table. This line reveals 
%the total # of modes calculated. 
a=str2num(C{location(2)-6}); 
totModeQty=a(1);
%modes are presented in groups of 50
chunks=ceil(totModeQty/50); 
%gaps=floor(totModeQty/50); 

jump=0;
for i = 1:chunks
    beginning(i,:)=location(1)+6+49*(i-1)+(jump*8);
    ending(i,:)=beginning(i,:)+49;
    jump=jump+1;
    count=i*50;
    if count>totModeQty
        ending(i,:)=ending(i,:)-(count-totModeQty);
    end    
end
%beginning 
%ending

%% Store data in matrices
k=1;
for i =1:length(beginning)
    for j = beginning(i,:):ending(i,:)        
        memfTrans(k,:)=C{:,j};
        k=k+1;
    end
end
memfTrans=str2num(memfTrans);
freqTrans=memfTrans(:,2);
mFracTrans=[memfTrans(:,3) memfTrans(:,5) memfTrans(:,7)]; 
mSumTrans=[memfTrans(:,4) memfTrans(:,6) memfTrans(:,8)]; 

newBeginning=beginning+(ending(length(ending))-beginning(1))+12;
newEnding=ending+(ending(length(ending))-beginning(1))+12;
k=1;
for i =1:length(newBeginning)
    for j = newBeginning(i,:):newEnding(i,:)        
        memfRot(k,:)=C{:,j};
        k=k+1;
    end
end
memfRot=str2num(memfRot);
freqRot=memfRot(:,2);
mFracRot=[memfRot(:,3) memfRot(:,5) memfRot(:,7)]; 
mSumRot=[memfRot(:,4) memfRot(:,6) memfRot(:,8)]; 
%% Generate MEMF and MEMS Translation plots
fig1=figure(1);
axs1=axes('Parent',fig1);
plot(axs1,freqTrans,mFracTrans)
legend(axs1,'T1', 'T2', 'T3')
grid on
xlabel(axs1,'frequency[Hz]')
title(axs1,'Modal Effective Mass Fraction [Translation]')

fig2=figure(2);
axs2=axes('Parent',fig2); 
plot(axs2,freqTrans,mSumTrans)
legend(axs2,'Tx', 'Ty', 'Tz')
grid on
xlabel(axs2,'frequency[Hz]')
title(axs2,'Modal Effective Mass Sum [Translation]')
%% Generate MEMF and MEMS Rotation plots
%clear
fig3=figure(3);
axs3=axes('Parent',fig3);
plot(axs3,freqRot,mFracRot)
legend(axs3,'R1', 'R2', 'R3')
grid on
xlabel(axs3,'frequency[Hz]')
title(axs3,'Modal Effective Mass Fraction [Rotation]')

fig4=figure(4);
axs4=axes('Parent',fig4);
plot(axs4,freqRot,mSumRot)
legend(axs4,'Rx', 'Ry', 'Rz')
grid on
xlabel(axs4,'frequency[Hz]')
title(axs4,'Modal Effective Mass Sum [Rotation]')

%% Overlay
fig5=figure(5);
axs5=axes('Parent',fig5);
plot(axs5,freqTrans,mFracTrans,freqRot,mFracRot,'--','LineWidth',1.5)
legend(axs5,'Tx','Ty','Tz','Rx','Ry','Rz')
grid on
xlabel(axs5,'frequency[Hz]')
title(axs5,'Modal Effective Mass Fraction [Translation & Rotation]')

%% This will determine the total number of frequencies output
% C = strsplit(S, char(10));
% ini = strncmp(C,'                                                    MODAL EFFECTIVE MASS FRACTION',81);
% location=find(ini);
% a=str2num(C{location(2)-6});
% app.totFreq.Value=a(1);

%% This is the brute force method. Use for reference only.
%get out the first 50 modes
% j=1;
% for i = location(1)+6:location(1)+50
%     memfTrans(j,:)=str2num(C{i});
%     j=j+1;
% end
% j=0;
% 
% %get out the first 50 rotation modes
% j=1;
% for i = location(2)+6:location(2)+50
%     memfRot(j,:)=str2num(C{i});
%     j=j+1;
% end
% j=0;
% 
% freqTrans=memfTrans(:,2);
% mFracTrans=[memfTrans(:,3) memfTrans(:,5) memfTrans(:,7)]; 
% mSumTrans=[memfTrans(:,4) memfTrans(:,6) memfTrans(:,8)]; 
% 
% 
% freqRot=memfRot(:,2);
% mFracRot=[memfRot(:,3) memfRot(:,5) memfRot(:,7)]; 
% mSumRot=[memfRot(:,4) memfRot(:,6) memfRot(:,8)]; 
% 
% freqNum=str2num(C{location(2)-6})
