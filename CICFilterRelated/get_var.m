%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006-2007 David MacMahon, Aaron Parsons                     %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function value = get_var(varname, varargin)
% Find the value of varname in varargin.  If varname is not found, looks
% for 'defaults' and tries to find varname in there.  If any of this fails,
% return Nan.
%
% value = get_var(varname, varargin)
%
% varname = the variable name to retrieve (as a string).
% varargin = {'varname', value, ...} pairs

i = find(strcmp(varname,varargin));
if i >= 1,
    value = varargin{i+1};
else,
    i = find(strcmp('defaults',varargin));
    if i >= 1,
        value = get_var(varname,varargin{i+1}{:});
    else,
        value = nan;
    end
end

