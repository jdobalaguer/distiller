
function eq = isequalni(x,y)
    mx = (isnan(x) | isinf(x));
    my = (isnan(y) | isinf(y));
    eq = mx | my | (x == y);
end