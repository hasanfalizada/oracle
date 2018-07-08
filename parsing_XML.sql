SELECT COUNT (*)
  FROM XMLTABLE (
           '//pr'
           PASSING XMLTYPE ('<prs><pr>
                    <name>Hasan Alizada</name>
                    <account>3811111115851265555</account>
                    <amount>15.83</amount>
               </pr>
               <pr>
                    <name>Hasan Alizada</name>
                    <account>3811111115851265555</account>
                    <amount>15.83</amount>
               </pr></prs>')
           COLUMNS CATEGORIESCOUNTCOLUMN NUMBER (2) PATH 'count(//item)');

SELECT COUNT (*) FROM XMLTABLE ('//prs/pr' PASSING XMLTYPE ('<prs><pr>
                    <name>Hasan Alizada</name>
                    <account>3811111115851265555</account>
                    <amount>15.83</amount>
               </pr>
               <pr>
                    <name>Hasan Alizada</name>
                    <account>3811111115851265555</account>
                    <amount>15.83</amount>
               </pr></prs>'));

DECLARE
    CATEGORIESCOUNT   NUMBER := 2;                         -- Just for example
BEGIN
    FOR I IN 1 .. CATEGORIESCOUNT
    LOOP
        BEGIN
            IF XMLTYPE (PBODY).EXTRACT (
                   '//root/items/item[' || I || ']/label/text()',
                   'xmlns=""').GETCLOBVAL () =
               'Invoice code '
            THEN
                V_INVOICE_CODE :=
                    XMLTYPE (PBODY).EXTRACT (
                        '//root/items/item[' || I || ']/value/text()',
                        'xmlns=""').GETCLOBVAL ();
                EXIT;
            END IF;
        EXCEPTION
            WHEN OTHERS
            THEN
                CONTINUE;
        END;
    END LOOP;
END;