unit CLICKF;

interface

    uses BUFFERF, CRT;

    type 
        CLICK_TYPE = (NO_CLICK, CLICK);

        CLICK_T = record    
            CLICK_CHAR: char;
            C_TYPE: CLICK_TYPE;
        end;

    procedure get_click();
    procedure handle_click(buffer: buffer_t);

    var user_click: CLICK_T;

implementation

procedure on_click();

    begin
        user_click.CLICK_CHAR := readkey();
        user_click.C_TYPE := CLICK;
    end;

procedure on_not_click();

    begin
        user_click.C_TYPE := NO_CLICK; 
    end;

procedure get_click();

    begin
        if KEYPRESSED then 
            on_click()
        else 
            on_not_click();
    end;

procedure handle_click(buffer: buffer_t);

    begin
        get_click();

        if (user_click.C_TYPE = CLICK) then 
            case user_click.CLICK_CHAR of 
                #8:    
                    pop(buffer);
                #13:
                    begin 
                    end;
                else 
                    push(buffer, user_click.CLICK_CHAR);
            end;
    end;

begin 
end.