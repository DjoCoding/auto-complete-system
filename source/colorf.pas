unit COLORF;

interface

    uses CRT;

    const RED = 4;
        BLUE = 1;
        GREEN = 2;


    procedure color_write(s: string; color: word);

implementation

procedure color_write(s: string; color: word);

    begin
        TextColor(color);
        writeln(s);
        writeln();
        TextColor(LightGray);
    end;

begin 
end.

