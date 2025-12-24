function I = condmutualinfo(x, y, z)
% CONDMUTUALINFO  Conditional mutual information I(X;Y|Z)
%
%   I = condmutualinfo(x, y)
%       returns I(X;Y)
%
%   I = condmutualinfo(x, y, z)
%       returns I(X;Y|Z)
%
%   Inputs:
%       x, y : discrete-valued vectors
%       z    : discrete-valued vector or matrix (conditioning variables)
%
%   Output:
%       I    : conditional mutual information in bits

    if nargin < 3 || isempty(z)
        % I(X;Y) = H(Y) - H(Y|X)
        I = entropy1(y) - condentropy(y, x);
        return;
    end

    % Merge multivariate Z if needed
    z = mergevars(z);

    % Merge (X,Z)
    xz = mergevars([x z]);

    % I(X;Y|Z) = H(Y|Z) - H(Y|X,Z)
    I = condentropy(y, z) - condentropy(y, xz);
end
