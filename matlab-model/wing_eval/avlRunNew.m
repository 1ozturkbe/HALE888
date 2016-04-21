filename = 'bwborig.avl';
text = fileread(['avl_geometries\' filename]);
searchregex = '(.*)\nAFILE\n(\w*\.dat)(\s*CONTROL\n(?:.*))*';
[mat,tok] = regexp(text,searchregex,'match','tokens');