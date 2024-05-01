unit PARSERF;

interface

    uses TOKENIZERF;

    type 
        parser_t = ^parser_type;
        parser_type = record 
            tokens: token_list;
            current: token_t;
        end;
    
    function parser_create(tokens: token_list): parser_t;
    function end_tokens(parser: parser_t): boolean;
    function parser_peek(parser: parser_t): token_t;
    function parser_consume(parser: parser_t): token_t;
    procedure parser_remove(var parser: parser_t);


implementation

function parser_create(tokens: token_list): parser_t;

    var result: parser_t;
    
    begin 
        new(result);
        result^.tokens := tokens;
        result^.current := tokens^.head;
        parser_create := result;
        result := NIL;
    end;

procedure parser_remove(var parser: parser_t);

    begin
        token_list_remove(parser^.tokens);
        parser^.current := NIL;
        dispose(parser);
        parser := NIL;
    end;

function end_tokens(parser: parser_t): boolean;

    begin
        end_tokens := (parser^.current = NIL); 
    end;

function parser_peek(parser: parser_t): token_t;

    begin 
        parser_peek := parser^.current;
    end;

function parser_consume(parser: parser_t): token_t;

    begin 
        parser_consume := parser_peek(parser);
        parser^.current := parser^.current^.next;
    end;

begin 
end.

