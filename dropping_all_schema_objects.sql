BEGIN
   FOR dr
      IN (  SELECT    'DROP '
                   || object_type
                   || ' "'
                   || object_name
                   || '"'
                   || CASE
                         WHEN object_type = 'TABLE' THEN 'CASCADE CONSTRAINTS'
                         ELSE NULL
                      END
                   || ';'
                      obj
              FROM user_objects
          ORDER BY object_type DESC)
   LOOP
      BEGIN
         EXECUTE IMMEDIATE dr.obj;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line (dr.obj);
      END;
   END LOOP;
END;