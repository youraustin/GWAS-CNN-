mat = [1 2 3 4;5 6 7 8;9 10 11 12; 13 14 15 16];
M = length(mat) % Assuming mat is always MxM

r = 2;
c = 2;

temp = spiral(2 * M - 1)
temp = temp(M - r + 1:end - r + 1, M - c + 1:end - c + 1)
[~, idx] = sort(temp(:))
vec = mat(idx).'
