function[ ] = Weight_Generate( n, k )

global weight Weights Formers Layer lastone currentone

% wtgener_test(n,k)
%
% Intended to test the weight generation scheme for NBI for > 2 objectives
% n is the number of objectives
% 1/k is the uniform spacing between two w_i (k integral)

% Recursive algorithm, courtesy of Sanjeeb Dash.

if ( n == Layer )
     if( currentone >= 0 )
        Formers = [Formers,lastone];
        lastone = currentone;
        currentone = -1;
    else
        num = size( Weights );
        Formers = [Formers,num(2)];
    end
    weight( Layer - n + 1 ) = k;
    Weights = [Weights,weight'];
else
	for i = 0 : k
         if( n == ( Layer - 2 ) )
            num = size(Weights);
            currentone = num(2)+1;
        end
        weight( Layer - n + 1 ) = i;
        Weight_Generate( n+1, k-i );
    end
end