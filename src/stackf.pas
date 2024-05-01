unit STACKF;

interface

    const STACK_SIZE = 100;

    type 
        stack_type = record 
            chars: array[1..STACK_SIZE] of char;
            top: integer;
        end;
    
        stack_t = ^stack_type;


    function stack_init(): stack_t;
    procedure stack_reset(st: stack_t);
    procedure stack_remove(var st: stack_t);

    procedure push(st: stack_t; c: char);
    procedure pop(st: stack_t);

    procedure push_string(st: stack_t; s: string);
    function stack_to_string(st: stack_t): string;
    procedure write_stack(st: stack_t);
    
implementation

procedure stack_reset(st: stack_t);

    begin
        st^.top := 0; 
    end;

procedure stack_remove(var st: stack_t);

    begin
        dispose(st);
        st := NIL; 
    end;

function stack_init(): stack_t;

    var st: stack_t;

    begin
        new(st);
        stack_reset(st);
        stack_init := st;
        st := NIL;
    end;

function stack_empty(st: stack_t): boolean;

    begin 
        stack_empty := (st^.top = 0);
    end;

function stack_full(st: stack_t): boolean;

    begin
        stack_full := (st^.top = STACK_SIZE); 
    end;

procedure push(st: stack_t; c: char);

    begin
        if (stack_full(st)) then 
            begin
                writeln('[STACK] stack is FULL!');
                exit(); 
            end; 
        
        inc(st^.top);
        st^.chars[st^.top]:= c;
    end;

procedure pop(st: stack_t);

    begin
        if (stack_empty(st)) then 
            exit(); 
        
        dec(st^.top);
    end;

procedure push_string(st: stack_t; s: string);

    var i, size: integer;

    begin 
        size := length(s);
        for i := 1 to size do 
            push(st, s[i]);
    end;


function stack_to_string(st: stack_t): string;

    var s: string;
        i: integer;

    begin 
        s := '';
        for i := 1 to st^.top do 
            s := s + st^.chars[i];
        
        stack_to_string := s;
    end;


procedure write_stack(st: stack_t);

    begin 
        writeln(stack_to_string(st));
    end;

begin 
end.

