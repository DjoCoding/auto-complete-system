unit ERRORF;

interface

    uses PFILE, COLORF;
    
    procedure usage();
    procedure error_write(s: string);

implementation

procedure usage();

    var line: string;
        stream: TEXT;

    begin 
        assign(stream, '../assets/usage.txt');  
        open_file(stream, 'r');

        while (not eof(stream)) do 
            begin
                readln(stream, line);
                writeln(line); 
            end;
        
        close(stream);
    end;

procedure error_write(s: string);

    begin   
        color_write(s, RED); 
    end;

begin
    
end.