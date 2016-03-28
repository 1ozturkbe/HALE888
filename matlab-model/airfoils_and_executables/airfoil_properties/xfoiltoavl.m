choice = 2;
type = {'wind tunnel 50mph','wind tunnel 100mph','stall','approach',...
    'cruise'};
filenames = {'50','100','Stall','Approach','Cruise'};
filenames = filenames{choice};

fileRex = '[a-zA-Z]+[0-9a-zA-Z]*\.dat';
file = fopen('geometries/bwborig.avl','r');
fileID = fopen(['geometries/bwbdrag' filenames '.avl'],'w');

line = fgets(file);
fprintf(fileID,line);
        
while ischar(line)
    disp(line)
    section = regexp(line,'SECTION','match');
    
    if ~isempty(section)
        line = fgets(file);
        fprintf(fileID,line);
        line = fgets(file);
        fprintf(fileID,line);
        posData = textscan(line,'%f');
        chord = posData{1}(4)*scaling;
        ReAirfoil = rho*vel*chord/mu;
    end
    airfoilfile = regexp(line,fileRex,'match');
    
    %% Check if we hit an airfoil file
    if ~isempty(airfoilfile);
        disp(airfoilfile)
        while ~isempty(regexp(line,'\w','ONCE'))
            line = fgets(file);
            if ~isempty(regexp(line,'\w','ONCE'))
                fprintf(fileID,'%s \n',deblank(line));
            else
                fprintf(fileID,deblank(line));
            end
        end
        load(['xfoil results/' airfoilfile{1}(1:end-4) filenames]);
        disp(CDCL);
        fprintf(fileID,'CDCL \n %s \n \n',num2str(CDCL,'%2.4f '));
    end
    line = fgets(file);
    fprintf(fileID,'%s',line);
end
fclose(file);
fclose(fileID);