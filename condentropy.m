function H = condentropy(x, y)
% CONDENTROPY  Conditional entropy H(X|Y) in bits
%
%   H = condentropy(x)
%       returns H(X)
%
%   H = condentropy(x, y)
%       returns H(X|Y)
%
%   Inputs:
%       x, y : discrete-valued vectors
%
%   Output:
%       H    : entropy in bits

    if nargin < 2
        % H(X)
        H = entropy1(x);
        return;
    end

    % H(X|Y) = H(X,Y) - H(Y)
    Hxy = jointentropy(x, y);
    Hy  = entropy1(y);
    H   = Hxy - Hy;
end
