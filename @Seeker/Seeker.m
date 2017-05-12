classdef Seeker < handle % & Swarm
  % Seeker objects are to be the fundamental components in the swarm.
  % They are quasi-independent in that each seeker makes its own decisions, but based upon information derived from
  % its own local sensors and communications with other seekers in the swarm.
  % A Seeker is a point in space, with velocity. For now, the implemenation platform is undetermined.
  %
  % A Seeker is analagous to a sparrow in a host (a flock of sparrows in flight).
  
  % Note: Matlab's OOP language requires that '< handle" be specified in order for handles to
  %          be used.
  
  properties  (SetAccess = private, GetAccess = public)  % Readable outside the class
    % Swarm number
    No = 0
    % "Position" of the Seeker
    x = 0.0
    y = 0.0
    z = 0.0
    % "Orientation" of the Seeker
    roll = 0.0
    pitch = 0.0
    yaw = 0.0
  end % Read-only properties
  
  properties (SetAccess = private, GetAccess = private) % Accessible only within the class
    
  end % Private properties
  
  
  methods
    function obj = Seeker (n, x, y, z )
      % default constructor
      if (nargin > 0)
        
        obj.No = n;
        obj.x = x;
        obj.y = y;
        obj.z = z;
      end
    end
    
%     function delete ( handle )
%       % deconstructor: allows clean-up of resources before the object instance is deleted by Matlab.
%       c = class(handle);
%       fprintf(['Destructor method invoked for class %s\n\n',c])
%     end
    
    %         display
    function plotImage ()
    % Plot an icon representing this seeker at the coordinates given by (x, y, z) with the orientation given by ( r, p,
    % y ).
    % The plot will be made to the currently active figure.
    
    end
    
    %         move
    %         broadcast
    %         receive
    %         sense
    
    
  end % methods
end % class