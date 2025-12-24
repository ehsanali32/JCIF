function I = mutualinfo(x, y)
% MUTUALINFO  Discrete mutual information I(X;Y)
%
%   I = mutualinfo(x, y)
%
%   Inputs:
%       x, y : vectors of equal length (discrete values)
%
%   Output:
%       I    : mutual information in bits

    assert(numel(x) == numel(y), 'Inputs must have same length.');

    x = x(:);
    y = y(:);

    % Map to consecutive integers (important)
    [~,~,x] = unique(x);
    [~,~,y] = unique(y);

    Nx = max(x);
    Ny = max(y);
    N  = numel(x);

    % Joint histogram
    joint = accumarray([x y], 1, [Nx Ny]);
    Pxy = joint / N;

    % Marginals
    Px = sum(Pxy, 2);
    Py = sum(Pxy, 1);

    % Mutual Information
    I = 0;
    for i = 1:Nx
        for j = 1:Ny
            if Pxy(i,j) > 0
                I = I + Pxy(i,j) * log2(Pxy(i,j) / (Px(i)*Py(j)));
            end
        end
    end
end