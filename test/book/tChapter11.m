classdef tChapter11 < RunMLX & RVCTest
    %tChapter11 Unit tests for chapter 11 book code
    %   The RunMLX base class will automatically run the MLX code in the
    %   "MLXFile" property and ensure there are no errors.
    %
    %   The RVCTest base class ensures that all the RVC Toolbox code is
    %   available.
    % 
    %   Add additional unit tests for this chapter in the methods(Test) 
    %   section.

    % Copyright 2022-2023 Peter Corke, Witold Jachimczyk, Remo Pillat

    properties
        %MLXFile - Name of MLX file to test
        %   This property is declared in the RunMLX base class.
        MLXFile = "chapter11.mlx"
    end

    methods (TestClassSetup)
        function shadowImtool(testCase)
            % Shadow the existing helpview function, so we can just verify
            % the calling arguments.
            testCase.applyFixture(...
                matlab.unittest.fixtures.PathFixture(fullfile(fileparts(mfilename("fullpath")), ...
                "imtoolShadow")));            
        end
    end

    methods(Test)
        % Additional test points for the chapter
    end

end
