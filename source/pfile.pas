unit PFILE;

interface 

    procedure open_file(var stream: TEXT; mode: char);
        
implementation

procedure open_file(var stream: TEXT; mode: char);

    begin
        case mode of 
            'r':
                reset(stream);
            'w':
                rewrite(stream);
            'a': 
                append(stream);
        end;
    end;

begin 
end.
