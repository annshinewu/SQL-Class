CREATE OR REPLACE FUNCTION public.improve(score integer)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
  DECLARE
    prevAve DECIMAL;
    sum INTEGER;
    cnt INTEGER;
    num INTEGER;
  BEGIN
    cnt := 0;
    sum := 0;
    FOR num IN SELECT * FROM randTable(5)
      LOOP
        cnt:= cnt + 1;
        sum:= sum + num;
    END LOOP;
    prevAve := sum/cnt;
    IF score > prevAve THEN
      RAISE NOTICE 'The student has improved.';
      RETURN true;
    ELSE
      return false;
    END IF;
  END;
  $function$
