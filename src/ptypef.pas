unit PTYPEF;

interface

    function iswhitespace(c: char): boolean;

implementation

function iswhitespace(c: char): boolean;

    begin
        iswhitespace := (c = ' '); 
    end;

begin 
end.