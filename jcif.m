function SF = jcif(X, y, k, opts)
%JCIF  Joint Conditional Mutual Information for Selecting Informative Feature
%
% This function implements the JCIF feature selection method described in:
%
%   U. A. Md. Ehsan Ali and K. Kameyama,
%   "Informative Band Subset Selection for Hyperspectral Image Classification
%    using Joint and Conditional Mutual Information," Proc. IEEE SSCI, 2022.
%   DOI: 10.1109/SSCI51031.2022.10022154.
%
%
%   [SF, scores] = jcif_select(X, y, k)
%   [SF, scores] = jcif_select(X, y, k, opts)
%
% Inputs:
%   X    : N × F feature matrix (discrete-valued)
%   y    : N × 1 class labels (discrete)
%   k    : number of features to select (k <= F)
%   opts : optional struct
%
% Outputs:
%   SF     : indices of selected features (1 × k)
%
% Reference:
%   JCIF feature selection criterion

%% -------------------- Input checking --------------------

arguments
    X double
    y double
    k (1,1) double {mustBeInteger, mustBePositive}
    opts.verbose (1,1) logical = false
    opts.check_discrete (1,1) logical = true
end

[N, F] = size(X);

if size(y,1) ~= N
    error('X and y must have the same number of samples.');
end

if k > F
    error('k must be <= number of features.');
end

if opts.check_discrete
    if any(mod(X(:),1) ~= 0) || any(mod(y(:),1) ~= 0)
        warning('Inputs are not integers. Ensure proper discretization.');
    end
end

%% -------------------- Preallocation --------------------

SF     = zeros(1, k);
scores = zeros(1, k);

MI_f_C = zeros(1, F);

%% -------------------- Step 1: MI(fi; C) --------------------

bestMI  = -inf;
bestIdx = -1;

for fi = 1:F
    MI_f_C(fi) = mutualinfo(X(:,fi), y);

    if MI_f_C(fi) > bestMI
        bestMI  = MI_f_C(fi);
        bestIdx = fi;
    end
end

SF(1)     = bestIdx;
scores(1)= bestMI;

if opts.verbose
    fprintf('Selected feature %d (MI = %.4f)\n', bestIdx, bestMI);
end

%% -------------------- Step 2: JCIF loop --------------------

for t = 2:k

    JCIF_vals = -inf(1, F);

    for fi = 1:F

        if ismember(fi, SF(1:t-1))
            continue;
        end

        % --- Step A: find fm that minimizes H(fi|fs) - H(fi|C)
        best_val = inf;
        best_m   = -1;

        for s = 1:(t-1)
            fs = SF(s);

            H_fi_fs = condentropy(X(:,fi), X(:,fs));
            H_fi_C  = condentropy(X(:,fi), y);

            val = H_fi_fs - H_fi_C;

            if val < best_val
                best_val = val;
                best_m   = fs;
            end
        end

        % --- Step B: JCIF score
        I_fi_C    = MI_f_C(fi);
        I_fm_C    = MI_f_C(best_m);
        I_fi_C_fm = condmutualinfo(X(:,fi), X(:,best_m), y);

        JCIF_vals(fi) = I_fi_C + (I_fi_C_fm + I_fm_C);
    end

    [scores(t), SF(t)] = max(JCIF_vals);

    if opts.verbose
        fprintf('Selected feature %d (JCIF = %.4f)\n', SF(t), scores(t));
    end
end
end
