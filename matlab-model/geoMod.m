% Opening read and write files
global newWing newRef newInd
file = fopen('avl_geometries/hale.avl','r');

suf = num2str(newInd);
fileID = fopen(strcat('avl_geometries/haleMod',suf,'.avl'),'w');

fileRex = '[a-zA-Z]+[0-9a-zA-Z]*\.dat';

line = fgets(file);
fprintf(fileID,'%s \n',line);
secID = 0;

%Geometry modification step
while ischar(line)
    line = fgets(file);
    if ~ischar(line)
        break
    end
    %     afile = regexp(line,'AFILE','match');
    %     if ~isempty(afile)
    %         fprintf(fileID,'%s',' ');
    %         fprintf(fileID,'%s',line);
    %         break
    %     end
    ref = regexp(line,'!Sref    Cref    Bref','match');
    section = regexp(line,'SECTION','match');
    fprintf(fileID,'%s',line);
    if ~isempty(ref)
        line = fgets(file);
        fprintf(fileID,'%s \n',num2str(newRef));
    elseif ~isempty(section) && secID < 6
        secID = secID + 1;
        %Reading Xle,Yle,Zle,Chord,Ainc title
        line = fgets(file);
        fprintf(fileID,'%s',line);
        %Reading Xle,Yle,Zle,Chord,Ainc values
        line = fgets(file);
        fprintf(fileID,'%s \n',num2str(newWing(secID,:)));       
        %Writing Xle,Yle,Zle,Chord,Ainc values
%         newLine = strcat(['   ',num2str(Xle),...
%             '   ',num2str(Yle),...
%             '   ',num2str(Zle),...
%             '   ',num2str(chord),...
%             '   ',num2str(Ainc)]);
%         fprintf(fileID,'%s \n',newLine);
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
