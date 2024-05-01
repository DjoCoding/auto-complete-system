unit TOKENIZERF;

interface 

    uses PTYPEF, STRING_VIEWF;

    type 
        TOKEN_TYPE = (COMMAND_TYPE, ARG_TYPE);

        token_t = ^token_type_t;
        token_type_t = record 
            value: string;
            _type: TOKEN_TYPE;
            next: token_t;
        end;

        token_list = ^token_list_type;
        token_list_type = record 
            head, tail: token_t;
        end;

    function get_tokens(sv: sv_t): token_list;
    procedure tokens_write(tokens: token_list);
    procedure token_list_remove(var tokens: token_list);

implementation

function token_create(value: string; _type: TOKEN_TYPE): token_t;

    var token: token_t;

    begin 
        new(token);
        token^.value := value;
        token^._type := _type;
        token^.next := NIL;
        token_create := token;
        token := NIL;
    end;

procedure token_list_remove(var tokens: token_list);

    var current: token_t;

    begin
        if (tokens = NIL) then exit();
        
        while (tokens^.head <> NIL) do 
            begin
                current := tokens^.head;
                tokens^.head := current^.next;
                dispose(current);
            end; 
        
        current := NIL;
        tokens^.tail := NIL;
        tokens := NIL;
    end;

procedure token_list_init(var tokens: token_list);

    begin
        token_list_remove(tokens); 
        new(tokens);
        tokens^.head := NIL;
        tokens^.tail := NIL;
    end;

procedure add_token(tokens: token_list; token: token_t);

    begin
        if (tokens^.head = NIL) then 
            begin
                tokens^.head := token;
                tokens^.tail := token; 
            end 
        else 
            begin
                tokens^.tail^.next := token;
                tokens^.tail := token; 
            end;
    end;

function get_token_type(token_value: string): TOKEN_TYPE;

    begin
        case token_value[1] of 
            ':':
                get_token_type := COMMAND_TYPE;
            else
                get_token_type := ARG_TYPE;
        end; 
    end;

function get_next_token(sv: sv_t): token_t;

    var buffer: string;

    begin
        buffer := '';

        while (not sv_end(sv)) do 
            begin
                if (iswhitespace(sv_peek(sv))) then break; 
                buffer := buffer + sv_consume(sv);
            end; 
        
        if (not sv_end(sv)) then 
            sv_consume(sv); // consuming the whitespace!
        get_next_token := token_create(buffer, get_token_type(buffer));
    end;

function get_tokens(sv: sv_t): token_list;

    var tokens: token_list;

    begin
        tokens := NIL;
        token_list_init(tokens);


        while (not sv_end(sv)) do 
            add_token(tokens, get_next_token(sv)); 

        get_tokens := tokens; 
    end;

procedure token_write(token: token_t);

    begin
        writeln('TOKEN VALUE: ', token^.value);
        writeln('TOKEN TYPE: ', token^._type); 
    end;

procedure tokens_write(tokens: token_list);

    var current: token_t;
    
    begin 
        current := tokens^.head;

        while (current <> NIL) do 
            begin
                token_write(current);
                current := current^.next; 
            end; 
    end;

begin 
end.


