% Opening read and write files
addpath('avl_geometries');
file = fopen('avl_geometries/hale.avl','r');

suf = 'Init';
fileID = fopen(strcat('avl_geometries/haleMod',suf,'.avl'),'w');

fileRex = '[a-zA-Z]+[0-9a-zA-Z]*\.dat';

%Geometry Modification parameters
%sweepMod = 1.5;
%dihedralMod = 1;
%chordMod = [1.5 1.05 1.025 1.0 1 1 1 1 1 1 1 1 1 1 1];
%leMod = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
%twistMod = [4 3 2 1.5 1 0.5 0 0 0 0 0 -0.5 -1 -1.5 -2.75];
%twistMod = zeros(1,15);
%flapHingeMod = [0.9 0.7 0.7 0.7 0.7];

%Initial inputs
initRef = [15.91 0.755 21.06]; %Sref, Cref, Bref (ft)
initWing = [0 0 0 1 0 0 0;
    0 3 0 1 0 0 0;
    0.0655 6 0 0.7378 0 0 0;
    0.1202 8.5 0 0.5194 0 0 0;
    0.142 9.5 0 0.432 0 0 0;
    0.1645 10.53 0 0.342 0 0 0];
%Xle Yle Zle Chord Ainc Nspanwise Sspace

% Generate new planform
chordMod = [1.0 1 1 1 1 1];
twistMod = [4 3 2 1.5 1 0];
leMod = [0 -0.2 -0.3 -0.2 -0.1 0];
sweepMod = 1.5; dihedralMod = 1.1;
bMod = 1.5;

line = fgets(file);
fprintf(fileID,'%s \n',line);
secID = 0;

%Geometry modification step
while ischar(line)
    line = fgets(file);
    if ~ischar(line)
        break
    end
    disp(line)
    %     afile = regexp(line,'AFILE','match');
    %     if ~isempty(afile)
    %         fprintf(fileID,'%s',' ');
    %         fprintf(fileID,'%s',line);
    %         break
    %     end
    section = regexp(line,'SECTION','match');
    fprintf(fileID,'%s',line);
    if ~isempty(section) && secID < 6
        secID = secID + 1;
        %Reading Xle,Yle,Zle,Chord,Ainc title
        line = fgets(file);
        fprintf(fileID,'%s',line);
        %Reading Xle,Yle,Zle,Chord,Ainc values
        line = fgets(file);
        posData = textscan(line,'%f');
        Xle = posData{1}(1);
        Yle = posData{1}(2);
        Zle = posData{1}(3);
        chord = posData{1}(4);
        Ainc = posData{1}(5);
        %Modifying Xle,Yle,Zle,Chord,Ainc values
        Xle = sweepMod*Xle+leMod(secID);
        Yle = Yle*bMod;
        Zle = dihedralMod*Zle;
        chord = chordMod(secID)*chord;
        Ainc = twistMod(secID) + Ainc;
        %Writing Xle,Yle,Zle,Chord,Ainc values
        newLine = strcat(['   ',num2str(Xle),...
            '   ',num2str(Yle),...
            '   ',num2str(Zle),...
            '   ',num2str(chord),...
            '   ',num2str(Ainc)]);
        fprintf(fileID,'%s \n',newLine);
    elseif ~isempty(section)
        secID = secID + 1;
        %Reading Xle,Yle,Zle,Chord,Ainc title
        line = fgets(file);
        fprintf(fileID,'%s',line);
        %Reading Xle,Yle,Zle,Chord,Ainc values
        line = fgets(file);
        newLine = line;
        fprintf(fileID,'%s \n',newLine);
    end
    airfoilfile = regexp(line,fileRex,'match');
    
    %% Check if we hit a file
    if ~isempty(airfoilfile)
        flapinfo = {'default','0.','0.9','0.','0.','0.','1'};
        while ~isempty(regexp(line,'\w','ONCE'))
            line = fgets(file);
            if ~isempty(regexp(line,'\w','ONCE'))
                fprintf(fileID,'%s',line);
            end
%             if strcmp('CONTROL',deblank(line))
%                 flapline = fgets(file);
%                 flapinfo = strsplit(strtrim(flapline));
%                 %Modify flap information
%                 flapname = flapinfo{1};
%                 %flapInd = int64(str2double(flapname(9)));
%                 flapPos = flapHingeMod(flapInd);
%                 %fprintf(filedID,'%s
%                 newLine = strcat([flapname,...
%                     '   ',num2str(flapinfo{2}),...
%                     '   ',num2str(flapPos),...
%                     '   ',num2str(flapinfo{4}),...
%                     '   ',num2str(flapinfo{5}),...
%                     '   ',num2str(flapinfo{6}),...
%                     '   ',num2str(flapinfo{7})]);
%                 fprintf(fileID,'%s \n',newLine);
%             end
        end
    end
end
fclose(file);
fclose(fileID);
