DROP FUNCTION IF EXISTS popstdev (VARIADIC inputs NUMERIC[]);

CREATE OR REPLACE FUNCTION popstdev(VARIADIC inputs NUMERIC[])
  RETURNS TABLE(
    std VARCHAR(2),
    popMean DECIMAL
  ) AS
$$
DECLARE
  sum DECIMAL := 0; -- sum of all numbers
  diffsqrd DECIMAL := 0; -- square of the inputs minus the mean
  sum2 DECIMAL := 0; -- sum of all diffsqrd
  mean DECIMAL := 0; -- average of all the inputs
  cnt DECIMAL := 0; -- counter of numbers
  num DECIMAL := 0; -- each number
BEGIN
  FOR num IN SELECT unnest(inputs)
    LOOP
      sum := sum + num; -- sum all the inputs
      cnt := cnt + 1; -- count the number of inputs
    END LOOP;

  popMean := sum/cnt; -- calculate the population mean

  FOR num IN SELECT unnest(inputs)
    LOOP
      diffsqrd := (num - popMean)^2;
      sum2 := sum2 + diffsqrd;
    END LOOP;

  std := |/(sum2/cnt);

  RAISE NOTICE 'Sum: %, Counter: %, Population Mean: %', sum, cnt, popMean;

  RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM popstdev(70, 80, 90, 60, 50);
