unit BUFFERF;

interface

    const BUFFER_SIZE = 100;

    type 
        buffer_type = record 
            chars: array[1..BUFFER_SIZE] of char;
            top: integer;
        end;
    
        buffer_t = ^buffer_type;


    function buffer_init(): buffer_t;
    procedure buffer_reset(buffer: buffer_t);
    procedure buffer_remove(var buffer: buffer_t);

    procedure push(buffer: buffer_t; c: char);
    procedure pop(buffer: buffer_t);

    procedure push_string(buffer: buffer_t; s: string);
    function buffer_to_string(buffer: buffer_t): string;
    procedure write_buffer(buffer: buffer_t);
    
implementation

procedure buffer_reset(buffer: buffer_t);

    begin
        buffer^.top := 0; 
    end;

procedure buffer_remove(var buffer: buffer_t);

    begin
        dispose(buffer);
        buffer := NIL; 
    end;

function buffer_init(): buffer_t;

    var buffer: buffer_t;

    begin
        new(buffer);
        buffer_reset(buffer);
        buffer_init := buffer;
        buffer := NIL;
    end;

function buffer_empty(buffer: buffer_t): boolean;

    begin 
        buffer_empty := (buffer^.top = 0);
    end;

function buffer_full(buffer: buffer_t): boolean;

    begin
        buffer_full := (buffer^.top = BUFFER_SIZE); 
    end;

procedure push(buffer: buffer_t; c: char);

    begin
        if (buffer_full(buffer)) then 
            begin
                writeln('[buffer] buffer is FULL!');
                exit(); 
            end; 
        
        inc(buffer^.top);
        buffer^.chars[buffer^.top]:= c;
    end;

procedure pop(buffer: buffer_t);

    begin
        if (buffer_empty(buffer)) then 
            exit(); 
        
        dec(buffer^.top);
    end;

procedure push_string(buffer: buffer_t; s: string);

    var i, size: integer;

    begin 
        size := length(s);
        for i := 1 to size do 
            push(buffer, s[i]);
    end;


function buffer_to_string(buffer: buffer_t): string;

    var s: string;
        i: integer;

    begin 
        s := '';
        for i := 1 to buffer^.top do 
            s := s + buffer^.chars[i];
        
        buffer_to_string := s;
    end;


procedure write_buffer(buffer: buffer_t);

    begin 
        writeln(buffer_to_string(buffer));
    end;

begin 
end.

