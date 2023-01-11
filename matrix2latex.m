function [s,mm] = matrix2latex(Mat, fmtstr_numbers, type)
%% Author: Mark Locherer, 
% Date: 2023-01-11
%matrix2latex Produce a latex string and Matlab code out of a Matlab or 
% Octave matrix. The idea is that we generate matrices randomly,
% e.g. for elearning exercises etc. using MATLAB with randi and randn.
% The matrix2latex function prints out a latex string that we can use in a
% exercise task description and the Matlab representation for the actual
% exercise (e.g. Moodle with coderunner).
%Optionally, you can specify a format string to format the numberse 
% and a latex matrix type.
%   outputs: 
% s = latex string of the matrix 
% mm = Matlab or Octave representation of the matrix if you for example 
% create matrices using randi or randn. 
% Usage: 
% A = [1,2;3,4]; 
% [s,mm] = matrix2latex(A); 
% or
% [s,mm] = matrix2latex(A, '%6.3f'); 
% or 
% [s,mm] = matrix2latex(A,'%6.3f','(') etc. 
% 
% standard latex matrix type is bmatrix and standard format string is %d. 
% 
% The function is inspired by inspired by  Lu Ce (2022). 
% Matlab matrix to LaTeX conversion example 
% (https://www.mathworks.com/matlabcentral/fileexchange/80629-matlab-matrix-to-latex-conversion-example), 
% MATLAB Central File Exchange. Retrieved December 27, 2022.

if nargin == 3
    switch (type)
        case ' '
          mType = 'matrix';
        case '('
          mType = 'pmatrix';
        case '['
          mType = 'bmatrix';
        case '{'
          mType = 'Bmatrix';
        case '|'
          mType = 'vmatrix';
        case '||'
          mType = 'Vmatrix';
        case '<'
          mType = 'matrix';
    end 
elseif nargin == 2
    mType = 'bmatrix';
else
    fmtstr_numbers = '%d';
    mType = 'bmatrix';    
end

fprintf('formatstring = %s\n', fmtstr_numbers);
fprintf('latex matrix type = %s\n', mType);

%% Convert

% Get matrix dimensions
m = size(Mat, 1);
n = size(Mat, 2);
mat_name = inputname(1);

% Create first line
s = sprintf('\\textbf{%s}_{%d \\times %d} = \\begin{%s}\n  ', mat_name, m, n, mType);
mm = sprintf('%s = [', mat_name);

% Print matrix
for k = 1:m
    for l = 1:n
        s = sprintf(strcat('%s ', fmtstr_numbers), s, Mat(k, l));
        mm = sprintf(strcat('%s', fmtstr_numbers), mm, Mat(k, l));
        if l < n
            s = sprintf('%s &', s);
            mm = sprintf('%s, ', mm);
        end
    end
    if k < m
        s = sprintf('%s \\\\', s);
        mm = sprintf('%s; ', mm);
    end
    s = sprintf('%s\n  ', s);
end

% Add last line
s = sprintf('%s\\end{%s}', s, mType);
mm = sprintf('%s]', mm);
fprintf('%s\n', s);
fprintf('%s\n', mm);

end
