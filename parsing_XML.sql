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


SELECT x.*
  FROM (SELECT Xmltype (
                  '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
   <soap:Body>
      <XXX xmlns="http://tempuri.org/">
         <XXX>
            <Response xmlns="">
               <header>
                  <resError>
                     <Code/>
                     <Message/>
                  </resError>
                  <Success>true</Success>
                  <MSGID>123fgsadh</MSGID>
               </header>
               <Body>
                  <Blocks>
                     <Block>
                        <BlockNo>AB57535</BlockNo>
                        <Amount>100</Amount>
                        <ExpireDate>19-12-2018</ExpireDate>
                        <MakerId>XXX</MakerId>
                     </Block>
                  </Blocks>
                  <ErrorMessage/>
                  <ErrorCode/>
                  <SuccessMessage/>
                  <SuccessCode/>
                  <WarningMessage/>
                  <WarningCode/>
                  <IsSucess>True</IsSucess>
               </Body>
            </Response>
         </XXX>
      </XXX>
   </soap:Body>
</soap:Envelope>'  )
                  Xml
          FROM DUAL) t,
       XMLTABLE ('//Response/Body/Blocks/Block'
                 PASSING t.Xml
                 COLUMNS Result VARCHAR2 (50) PATH 'BlockNo') x;