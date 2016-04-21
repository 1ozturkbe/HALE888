function [Weights, Formers] = Weights( n, k )

global weight Weights Formers Layer lastone currentone

%[Weight, Former] = Weights( n, k )
%
% Generates all possible weights for NBI subproblems given:
% n, the number of objectives
% 1/k, the uniform spacing between two w_i (k integral) 
% This is essentially all the possible integral partitions 
% of integer k into n parts.


% Function called : wtgener_test(n,k)

% Having allocated the global spaces for W (and an intermediate wt_vec)
% this calls wtgener_test to actually allocate the weights
weight        = zeros(1,n);
Weights     = [];
Formers     = [];
Layer         = n;
lastone       = -1;
currentone  = -1;

Weight_Generate( 1, k );

% W = W/k;