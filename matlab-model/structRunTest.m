function d_of_c = structRunTest(x)
    [~, newRef, cri] = geoDescription(x);
    [~, d_of_c] = structRun(newRef, cri);
end