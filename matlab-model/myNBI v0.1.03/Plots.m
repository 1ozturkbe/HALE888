function Plots(Y,X)

    % 2-D in F-space
    if size(Y,1) == 2,
        plot(Y(1,:), Y(2,:), 'r*', Y(1,:), Y(2,:), 'b--');
        title('Pareto Front in F-space');
        xlabel('f_1');
        ylabel('f_2');
    % 3-D
    elseif size(Y,1) == 3,
      plot3(Y(1,:), Y(2,:), Y(3,:),'r*')
      title('Pareto Front in F-space');
      xlabel('f_1')
      ylabel('f_2')
      zlabel('f_3')
    end
 
    reply = input('Press any key to continue...');    
    
    % 2-D in X-space
    if size(X,1) == 2,
        reply = input('Want a plot of Pareto optimal X ? (0/1)   ');
        if reply == 1,  
            plot(X(1,:), X(2,:), 'b*');	
        end
    end