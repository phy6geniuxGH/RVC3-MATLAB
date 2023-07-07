% run the tests for Travis CI
%
% Travis file system looks like this:
%    ./           ** RVC3TB is unpacked at this level, not its own folder
%    ./unit_test  ** WORKING folder

%% set up the test runner
import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoberturaFormat
import matlab.unittest.TestRunner

suite = testsuite('IncludeSubfolders', false);
runner = TestRunner.withTextOutput;

% add a coverage report
reportFile = fullfile('..', 'coverage.xml');
reportFormat = CoberturaFormat(reportFile);
plugin = CodeCoveragePlugin.forFolder('..', 'Producing',reportFormat);
runner.addPlugin(plugin);


%% setup the path
fprintf('---------------------------------- Setup path ------------------------------------\n')
fprintf('-->> current working folder is %s\n', pwd)


%% Run all unit tests in my repository
fprintf('---------------------------------- Run the unit tests ------------------------------------\n')

results = runner.run(suite);

% Assert no tests failed
assert(all(~[results.Failed]));

% %% Build the toolbox distribution file
% fprintf('---------------------------------- Build the MLTBX file ------------------------------------\n')
% cd ..
% % add more folders to the path to ensure they go in the MLTBX file
% addpath demos
% addpath examples
% addpath Apps

% matlab.addons.toolbox.packageToolbox('PackageToolbox.prj', 'RVCTB.mltbx')