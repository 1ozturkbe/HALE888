global initWing initRef

%Initial inputs
initRef = [15.91 0.755 21.06]; %Sref, Cref, Bref (ft^2, ft, ft)
initWing = [0 0 0 1 0 0 0;
    0 3 0 1 0 0 0;
    0.0655 6 0 0.7378 0.25 0 0;
    0.1202 8.5 0 0.5194 0.5 0 0;
    0.142 9.5 0 0.432 0.75 0 0;
    0.1645 10.53 0 0.342 1 0 0];
%Xle Yle Zle Chord Ainc Nspanwise Sspace (ft, ft, ft, ft, radians)