classdef Swarm < handle
  % Swarm is a collection of Seeker objects whose behaviour is orchestrated towards achieving a common goal.
  %   Primarily, the Seekers move together in self-organized arrangement.
  %   Seekers make independent decisions (there is no central control). Self-organization of movement emerges from shared
  %   rules regulating relative position and velocity.
  %   The primary goal of the swarm is to traverse a gradient field, searching for the source of emmission.
  
  properties (SetAccess = public, GetAccess = public)
    debug = false
  end
  
  properties (SetAccess = private, GetAccess = public)
    % "Position" of the Swarm
    x = 0.0;
    y = 0.0;
    z = 0.0;
    % "Orientation" of the Swarm
    alpha = 0.0;
    beta = 0.0;
    gamma = 0.0;
    % Number of seekers
    nSeekers = 0;
    % Seeker List
    members = [] 
    % Minimum allowable range between any two Seekers
    minRange = 0.15;
  end
  
  properties (SetAccess = private, GetAccess = private)
    initialPositions;
  end
  
  methods
    % Constructor:
    function obj = Swarm ( nS )
      assert (((isnumeric(nS)) && (nS > 0)), 'Error in constructor: number of Seekers must be a positive number.');
      nS = fix(nS);
      obj.nSeekers = nS;
      X = zeros(1, nS);
      Y = zeros(1, nS);
      Z = zeros(1, nS);
      [X, Y, Z] = obj.initPos (nS); % Generate array of initial positions
      temp = cell(1,nS); % create a cell array
      for i = 1:nS
        temp{i} = Seeker (i, X(i), Y(i), Z(i));
      end
      
      obj.members = [temp{:}]; % convert to array and assign
      
    end% constructor Swarm
    
    % Generate array of initial positions
    function [X, Y, Z] = initPos (this, nP)
      % Given a number of elements, nP, calculate positions over an equilateral 3D space
      % Since a relatively close packing is desired initialliy, the dimensions of this initial space
      % is set to be proportional to the cube root of the number of elements.
      % The distance between any two elements cannot be less then the minimum range.
      % Note: the minimum range defines a sphere of proximity; the 3D grid is thus an approximation
      % Keeping it simple, the initial space is divided into mp x mp x mp sample points.
      % Elements are distributed uniformly around the "center" of the grid,
      mP = ceil(nthroot(nP, 3));
      
      uP = (mP - 1) / 2 * this.minRange;
      lP = -(mP - 1) / 2 * this.minRange;
      sScale = [lP:this.minRange:uP];
      sGrid = zeros (mP, mP, mP);
      % Initial positions are randomly assigned to a uniform grid spaced by minRange
      for i = 1:nP
        while true
          s = randi(mP, [1,3]);
          if (sGrid(s(1), s(2), s(3)) == 0)
            X(i) = sScale(s(1));
            Y(i) = sScale(s(2));
            Z(i) = sScale(s(3));
            sGrid(s(1), s(2), s(3)) = 1;
            break
          end
        end
      end
      this.initialPositions = [X, Y, Z];
    end % function initPos
    
    % Estimate the location (centroid) of the Swarm:
    %     function locate(this)
    %       if this.debug
    %         for
    %           fprintf ('\n Debug for %s', 'Swarm.locate');
    %           fprintf('\n  x: %f  y: %f  z: %f  alpha: %f  beta: %f  gamma: %f\n', this.x, this.y, this.z, this.alpha, this.beta, this.gamma);
    %         end
    %       end
    %     end % function locate
    
    % Poll all the seekers for their positions
    function pos = pollPositions(this)
      nS = this.nSeekers;
      pos = zeros (nS, 3);
      for i = 1:nS
        pos (i,:) = [this.members(i).x, this.members(i).y, this.members(i).z];
      end
    end % pollPositions
    
    % Preliminary function to plot the Swarm
    function plotSeekers(this)
      f1 = figure; hold on; grid on; box on; axis auto; view(3);
      % Put figure in upper right corner
      scrsz = get(0,'ScreenSize');
      figsz = get(f1, 'OuterPosition');
      set(f1, 'Position', [(scrsz(3) - figsz(3)) (scrsz(4) - figsz(4)) figsz(3) figsz(4)]);
      
      % get the current positions of the seekers
      coords = this.pollPositions; % returns n x 3 matrix
      % make all the axis equal to provide a better perspective
      lP = min(min(coords));
      uP = max(max(coords));
      xlim ([lP, uP]); ylim ([lP, uP]); zlim ([lP, uP]);
      %axis equal
      scatter3 (coords(:,1), coords(:,2), coords(:,3), 'filled');
      labels = cellstr(num2str([1:this.nSeekers]'));
      % Label each point with it's index number
      text(coords(:,1), coords(:,2), coords(:,3), labels, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right')
    end % plot Swarm
    
  end % methods
end % class