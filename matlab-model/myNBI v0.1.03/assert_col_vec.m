function[v] = assert_col_vec(v)

if size(v,1) < size(v,2), % i.e. more rows than columns
	v = v';
end
