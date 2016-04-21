function [Pareto_Fmat, Pareto_Xmat] = NBI(X0,Spac,Fnum,VLB,VUB,TolX,TolF,TolCon)

%[Pareto_Fmat, Pareto_Xmat] = NBI(X0, Spac, Fnum, VLB, VUB, TolX, TolF, TolCon)
%  This is an implementation of Normal-Boundary Intersection for finding 
%  Pareto optimal points of multi-objective problems using the quasi-normal
%  as developed by Das and Dennis (1996). 
%	
%The user inputs are as follows:
%  X0      : starting point for the finding the minimum of F_1
%  Spac    : an integer whose reciprocal is the discretization gridsize on each component of Weights
%  Fnum    : number of objective functions
%  VLB     : vector of lower bounds on the variables(default [])
%  VUB     : vector of upper bounds on the variables(default [])   
%  TolX    : tolerance of X            (default 1E-4)
%  TolF    : tolerance of objectives   (default 1E-4)
%  TolCon  : tolerance of constraints  (default 1E-7)
%
%File List:
%  NBI.m             : the main file for solving MOPs
%  myT.m             : returns function for actual NBI subproblem
%  myTCon.m          : return  constraints for actual NBI subproblem
%  LinCom.m          : linear weights aggregation optimization for the problem
%  myLinCom.m        : evaluates the objective for LinCom
%  assert_col_vec.m  : convert a vector to a column vector
%  Plots.m           : plot 2-D or 3-D graphics
%  Weights.m	     : used for generate weights and search 'nearest' weight index
%  Weight_Generate.m : used for generate weights and search 'nearest' weight
%
%User defined files:
%  myFM.m          : evaluates the objective vector F(x) at a given x
%  myFS.m          : evaluates one of the objective F_i(x), needed for finding the shadow minimum
%  myCon.m         : evaluates the constraints at a given x
%	
%Copyright (c) 1996  Indraneel Das, Rice University 
%Modified:
%  myNBI version 0.1.1
%  Dec.27 2004 
%  Aimin Zhou
%  Department of Computer Science, University of Essex
%  Wivenhoe Park, Colchester, CO4 3SQ, U.K
%  azhou@essex.ac.uk
%  http://privatewww.essex.ac.uk/~azhou for latest version


% global variables
global g_Index g_Normal g_StartF

more off

%%%%%%%%%%%%%%%%%%%%%%%%%%%Check Parameters%%%%%%%%%%%%%%%%%%%%%
  if nargin < 1, 
    X0 = input('Enter X0   '); 
  end;
  if nargin<2, 
    Spac_1   = input('Enter the mesh size  '); 
  end;
  if nargin < 3,
    Fnum    = input('Enter the number of the objectives ');
  end;
  if nargin < 4   , VLB   = [];   end;
  if nargin < 5   , VUB   = [];   end;
  if nargin < 6   , TolX  = 1e-4; end;
  if nargin < 7   , TolF  = 1e-4; end;
  if nargin < 8   , TolCon= 1e-7; end;

  %Make column vector
  X0   = assert_col_vec(X0);
  VLB  = assert_col_vec(VLB);
  VUB  = assert_col_vec(VUB);
    
%%%%%%%%%%%%%%%%%%%%%%%%%Initialize Options%%%%%%%%%%%%%%%%%%%%%%%%
  % Nunber of variables
  nvars   = size(X0,1);    
    
  % Max Iterations
  % Tolerance for F
  % Tolerance for X
  % Tolerance for Constraints
  % Medium scale
  % Not display temporary results
  options = optimset('MaxIter',(nvars+1)*150,'TolFun',TolF,'TolX',TolX,'TolCon',TolCon,'LargeScale','off','Display','off','GradObj','off');
    
  %Initialize PHI
  PHI = zeros(Fnum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%Shadow Point%%%%%%%%%%%%%%%%%%%%%%
  disp('----Step 1: find shadow minimum...');
    
  ShadowF = zeros(Fnum,1);
  ShadowX = zeros(nvars,Fnum);
  xstart  = X0;
  for i = 1:Fnum
    g_Index = i;
    [ShadowX(:,i),ShadowF(i), fiasco] = fmincon('myFS',xstart,[],[],[],[],VLB,VUB,'myCon',options);
    xstart  = ShadowX(:,i);    % possibly a better option for the next starting point
  end
    
  disp('Shadow Minimum-F:');
  disp(ShadowF);
  disp('Shadow Minimum--X(column)');
  disp(ShadowX);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Matrix PHI%%%%%%%%%%%%%%%%%
  disp('----Step 2: find PHI...');    
  %Find Matrix PHI = [F(x1*) - F* | F(x2*)- F* | ... | F(xn*) - F*];
  for i = 1:Fnum
    PHI(:,i)  = myFM(ShadowX(:,i)) - ShadowF;
    PHI(i,i)  = 0;
  end
    
  disp(PHI);
    
  %Check to make sure that QPP is n-1 dimensional
  if rcond(PHI) < 1e-8,
    disp(' Phi matrix singular, aborting.');
    return;
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Quasi-Normal Direction%%%%%%%%%%%%%%%
  disp('----Step 3: find Quasi-Normal...');
  g_Normal  = -PHI*ones(Fnum,1);
  g_Normal  = g_Normal/norm(g_Normal);
	
  disp(g_Normal); 
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%weights%%%%%%%%%%%%%%%%%%%%%%%%%
  disp('----Step 4: create weights...');
  [Weight, Near]  = Weights(Fnum,Spac);
  Weight = Weight/Spac;
  num_w = size(Weight, 2);
    
  disp('Weights in row:');
  disp(Weight');
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%NBI Subproblems%%%%%%%%%%%%%%%%%%
  reply = input('----Step 5: solve NBI sub-problems(hit return to continue)...');
  disp('......Solving NBI sub-problems......');
    
  % Starting point for first NBI subproblem is the minimizer of f_1(x)
  xstart = [ShadowX(:,1);0];
    
  Pareto_Fmat = [];       % Pareto Optima in F-space
  Pareto_Xmat = [];       % Pareto Optima in X-space
  X_Near      = [];
     
  num_fiascos     = 0;            % The failuer numbers

  % solve NBI subproblems
  for k = 1:num_w
    w  = Weight(:,k);      

    % Solve problem only if it is not minimizing one of the individual objectives
    indiv_fn_index = find( w == 1 );
        
    % the boundary solution which has been solved
    if indiv_fn_index ~= 0
      % w has a 1 in indiv_fn_index th component, zero in rest
      % Just read in solution from shadow data
      Pareto_Fmat = [Pareto_Fmat, ( PHI(:,indiv_fn_index) + ShadowF)];
      Pareto_Xmat = [Pareto_Xmat, ShadowX(:,indiv_fn_index)];
      X_Near      = [X_Near, [ShadowX(:,indiv_fn_index);0] ] ;
    else 
      if( Near(k) > 0 )
        xstart = X_Near(:,Near( k ) );
      end
            
      %start point in F-space
      g_StartF = PHI*w + ShadowF;
      % SOLVE NBI SUBPROBLEM
      [x_trial,tmp, fiasco] = fmincon('myT',xstart,[],[],[],[],VLB,VUB,'myTCon',options);

      %success
      if fiasco >= 0
        Pareto_Fmat = [Pareto_Fmat, myFM(x_trial)];  % Pareto optima in F-space
        Pareto_Xmat = [Pareto_Xmat, x_trial(1:nvars)];        % Pareto optima in X-space
        X_Near      = [X_Near,x_trial];
      %unsuccess
      else
        num_fiascos = num_fiascos + 1;
        X_Near      = [X_Near,xstart];
        giveup      = input('Give up ?  (0/1)  ');
        if giveup == 1, break; end	
      end
    end % if indiv_fn_index ~= 0
  end %for	

%%%%%%%%%%%%%%%%%%%%%%%%Plot%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
  disp('----Step 6: Plot if possible...');
  Plots(Pareto_Fmat,Pareto_Xmat);
    
%%%%%%%%%%%%%%%%%%%%%%%%Weight Combination%%%%%%%%%%%%%%%%%%%%%%%%%
  reply =  input('----Step 7: solve MOP by Weights Combination(1)...');
  if( reply == 1 )
     [F,X] = LinCom(X0, Weight, VLB, VUB, options);
     Plots(F,X);
  end