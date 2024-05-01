uses TOKENIZERF, STRING_VIEWF;

procedure main();

    var input: string;
        sv: sv_t;
        tokens: token_list;

    begin
        repeat
            write('> ');
            readln(input);
            if (input <> 'q') then 
                begin
                    sv := sv_create(input);
                    tokens := get_tokens(sv);
                    tokens_write(tokens);
                    token_list_remove(tokens); 
                    sv_remove(sv);
                end;
        until (input = 'q'); 
    end;

begin
    main();
end.