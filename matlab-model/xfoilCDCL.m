close all; clear all;
%Defining conversions
loadConversions;

%% Load all conditions
windtunnelSpeeds = [50 100];              % mph
velocity = windtunnelSpeeds * mpspermph;  % wind tunnel velocity mph -> m/s
a = 340.3;
M = velocity / a;                         % Mach number

%Defining parameters
choice = 1;
MN = [M, 0.1744, 0.2268, 0.8];    
rho = [1.225*ones(1,4), 0.38035];
mu = [1.79e-5*ones(1,4), 1.44e-5];
vel = [velocity 150/1.3*mpsperknot 150*mpsperknot 295.4*0.85];
scaling = [scaling scaling 1 1 1];
type = {'wind tunnel 50mph','wind tunnel 100mph','stall','approach',...
    'cruise'};
filenames = {'50','100','Stall','Approach','Cruise'};

% Set the choice
M = MN(choice);
vel = vel(choice);
rho = rho(choice);
mu = mu(choice);
filenames = filenames{choice};
scaling = scaling(choice);

fileRex = '[a-zA-Z]+[0-9a-zA-Z]*\.dat';
file = fopen('bwborig.avl','r');
line = fgets(file);
cd('xfoilavl');
        
while ischar(line)
    section = regexp(line,'SECTION','match');
    
    if ~isempty(section)
        fgets(file);
        line = fgets(file);
        posData = textscan(line,'%f');
        chord = posData{1}(4)*scaling;
        ReAirfoil = rho*vel*chord/mu;
    end
    airfoilfile = regexp(line,fileRex,'match');
    
    %% Check if we hit an airfoil file
    if ~isempty(airfoilfile)...
            && ~isempty(regexp(airfoilfile{1},'0','ONCE'));
        disp(airfoilfile)
        flapinfo = {'default','0.','0.9','0.','0.','0.','1'};
        while ~isempty(regexp(line,'\w','ONCE'))
            line = fgets(file);
            if strcmp('CONTROL',deblank(line))
               flapline = fgets(file);
               flapinfo = strsplit(strtrim(flapline));
               flapname = flapinfo{1};
            end
        end
        polar = xfoil(airfoilfile{1},-5:0.25:6,...
            ReAirfoil,M,... %reynolds number, mach number
            'oper iter 200',...
            ['gdes flap ' flapinfo{3} ' 0 ' flapinfo{2} ' exec']);
        minidx = find(polar.CD == min(polar.CD));
        minidx = minidx(1);
        
        CDmax = polar.CD(end);
        CLmax = polar.CL(end);
        CDmin = polar.CD(1);
        CLmin = polar.CL(1);
        CD0 = polar.CD(minidx);
        CL0 = polar.CL(minidx);
        
        a1 = (CDmax-CD0)/(CL0-CLmax)^2;
        b1 = -2*CL0*a1;
        c1 = CD0 - a1*CL0^2 - b1*CL0;
        a2 = (CDmin-CD0)/(CL0-CLmin)^2;
        b2 = -2*CL0*a2;
        c2 = CD0 - a2*CL0^2 - b2*CL0;
        
%         addpath('../../MATLAB tools/');
        CDCL = [polar.CL(1) polar.CD(1) polar.CL(minidx)...
            polar.CD(minidx) polar.CL(end) polar.CD(end)];
        endidx = length(polar.CD);
%         p = prettyplot('parabola');
%         p.largedata(polar.CD, polar.CL,'b');
%         p.data(CDCL(2:2:end),CDCL(1:2:end),'g');
%         p.model(a1*polar.CL(minidx:end).^2+b1*polar.CL(minidx:end)...
%             +c1, polar.CL(minidx:end),'g');
%         p.model(a2*polar.CL(1:minidx).^2+b2*polar.CL(1:minidx)...
%             +c2, polar.CL(1:minidx),'r');
%         p.title('XFOIL dragpolar for orig0mod.dat run at 50mph')
%         p.legend('SouthEast','raw data',...
%             'selected points','upper parabolic approximation',...
%             'lower parabolic approximation')
%         p.xlabel('C_D');
%         p.ylabel('C_L');
        save(['../xfoil_run_outputs/' airfoilfile{1}(1:end-4) filenames],'CDCL');
    end
    line = fgets(file);
end
fclose(file);
cd('..');
