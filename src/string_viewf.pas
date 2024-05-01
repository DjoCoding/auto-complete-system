unit STRING_VIEWF;

interface 

    type 
        sv_t = ^sv_type;
        sv_type = record 
            content: string;
            size: integer;
            current: integer;
        end;

    function sv_create(content: string): sv_t;
    procedure sv_remove(var sv: sv_t);

    function sv_end(sv: sv_t): boolean;
    function sv_peek(sv: sv_t): char;
    function sv_consume(sv: sv_t): char;
    
implementation

function sv_create(content: string): sv_t;

    var result: sv_t;

    begin
        new(result);
        result^.content := content;
        result^.size := length(content);
        result^.current := 1;
        sv_create := result;
        result := NIL;
    end;

procedure sv_remove(var sv: sv_t);

    begin
        dispose(sv);
        sv := NIL;
    end;

function sv_end(sv: sv_t): boolean;

    begin
        sv_end := (sv^.current = sv^.size + 1); 
    end;

function sv_peek(sv: sv_t): char;

    begin
        sv_peek := sv^.content[sv^.current];
    end;

function sv_consume(sv: sv_t): char;

    begin
        sv_consume := sv_peek(sv);
        inc(sv^.current); 
    end;

begin 
end.