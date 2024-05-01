unit HANDLE_ERRORF;

interface

    procedure usage();

implementation

procedure usage();

    begin   
        writeln('COMMANDS:');
        writeln('           :add <filename>* : to add one or more files to the tree!');
        writeln('           :show            : show all the words available in the tree!');
        writeln('           :grah <filename> : outputs a file that contains source code for the tree generation! (use graphics)');
    end;

begin
    
end.