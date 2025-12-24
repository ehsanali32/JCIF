JCIF: Joint Conditional Mutual Information for Selecting Informative Feature (MATLAB)

Overview
********
This repository provides a MATLAB implementation of the Joint Conditional Mutual Information for Selecting Informative Feature (JCIF) selection criterion for supervised feature selection.

JCIF is an information-theoretic method that incrementally selects features by jointly considering:

Redundency handled using conditional mutual information, and Relevence via joint mutual information.

The method is designed for discrete-valued data and is particularly suitable for high-dimensional feature spaces.


Key Features
************
	Pure MATLAB implementation 
	Independent, first-principles implementation of:
		Entropy
		Mutual Information (MI)
		Conditional Entropy
		Conditional Mutual Information (CMI)
	No external toolboxes required
	Deterministic and reproducible
	Suitable for MATLAB Central distribution


Function Description
********************
SF = jcif(X, y, k, opts)

Input
	X : N × F data matrix (discrete features)
	y : N × 1 class labels (discrete)
	k : number of features to select
	opts : optional structure
		verbose (logical): display selection progress
		check_discrete (logical): warn if inputs are non-integer
Output
	SF : indices of selected features (1 × k)


Data Requirements
*****************
Inputs must be discrete-valued
Continuous features should be discretized prior to use (e.g., equal-width or equal-frequency binning)


Limitations
***********
Designed for discrete features
Computational cost grows with the number of selected features
Not intended for continuous MI estimation without discretization

Citation
********
If you use this code or the JCIF method in your research, please cite:

U. A. Md. Ehsan Ali and K. Kameyama,
“Informative Band Subset Selection for Hyperspectral Image Classification using Joint and Conditional Mutual Information,”
Proceedings of the IEEE Symposium on Computational Intelligence in Remote Sensing (SSCI), pp. 573–580, December 2022.
DOI: 10.1109/SSCI51031.2022.10022154


License
*******
This code is released for academic and research use.
See license.txt for details.