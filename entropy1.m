function H = entropy1(x)
% ENTROPY1  Discrete entropy H(X) in bits
%
%   H = entropy1(x)
%
%   Input:
%       x : vector of discrete values
%
%   Output:
%       H : entropy in bits

    x = x(:);

    % Map values to consecutive integers
    [~,~,x] = unique(x);

    N = numel(x);

    % Marginal probabilities
    px = accumarray(x, 1) / N;

    % Remove zeros
    px(px == 0) = [];

    % Entropy
    H = -sum(px .* log2(px));
end
