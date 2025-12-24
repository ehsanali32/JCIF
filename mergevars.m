function z = mergevars(vars)
% MERGEVARS  Merge multiple discrete variables into a single joint variable
%
%   z = mergevars(vars)
%
%   Each column of vars is treated as a discrete variable.
%   The output z is a single discrete variable representing joint states.

    if isempty(vars)
        z = [];
        return;
    end

    vars = vars(:,:);
    n = size(vars,1);

    % Convert each column to consecutive integers
    for k = 1:size(vars,2)
        [~,~,vars(:,k)] = unique(vars(:,k));
    end

    % Encode joint states
    z = vars(:,1);
    base = max(z);

    for k = 2:size(vars,2)
        z = (z-1)*max(vars(:,k)) + vars(:,k);
        base = max(z);
    end

    % Re-map to consecutive integers
    [~,~,z] = unique(z);
end
