%Opening read and write files
addpath('/geometries');
file = fopen('geometries/bwborig.avl','r');

suf = 'Final';
fileID = fopen(strcat('../AVL/xfoilavl/bwbMod',suf,'.avl'),'w');

fileRex = '[a-zA-Z]+[0-9a-zA-Z]*\.dat';

%Geometry modification parameters
sweepMod = 1.15;
dihedralMod = 1;
%chordMod = [1.0 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
chordMod = [1.075 1.05 1.025 1.0 1 1 1 1 1 1 1 1 1 1 1];
leMod = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
twistMod = [4 3 2 1.5 1 0.5 0 0 0 0 0 -0.5 -1 -1.5 -2.75];
%twistMod = zeros(1,15);
flapHingeMod = [0.9 0.7 0.7 0.7 0.7];

line = fgets(file);
fprintf(fileID,'%s \n',line);
secID = 0;

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
    if ~isempty(section)
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
        Yle = Yle;
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
            if strcmp('CONTROL',deblank(line))
                flapline = fgets(file);
                flapinfo = strsplit(strtrim(flapline));
                %Modify flap information
                flapname = flapinfo{1};
                flapInd = int64(str2double(flapname(9)));
                flapPos = flapHingeMod(flapInd);
                %fprintf(filedID,'%s
                newLine = strcat([flapname,...
                    '   ',num2str(flapinfo{2}),...
                    '   ',num2str(flapPos),...
                    '   ',num2str(flapinfo{4}),...
                    '   ',num2str(flapinfo{5}),...
                    '   ',num2str(flapinfo{6}),...
                    '   ',num2str(flapinfo{7})]);
                fprintf(fileID,'%s \n',newLine);
            end
        end
    end
end
fclose(file);
fclose(fileID);
