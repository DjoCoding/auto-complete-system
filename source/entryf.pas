unit ENTRYF;

interface

    uses COLORF;

    procedure entry();
    
implementation

procedure entry();

    begin
        color_write('     *        *      *      *********       * * *', BLUE);
        color_write('    * *       *      *          *         *        *', BLUE);
        color_write('   *   *      *      *          *        *          *', BLUE);
        color_write('  *******     *      *          *        *          *', BLUE);
        color_write(' *       *     *    *           *         *        *', BLUE);
        color_write('*         *     ****            *           * * *', BLUE);
        writeln();
    end;

begin 
end.