DROP FUNCTION IF EXISTS public.product(INTEGER, INTEGER);
CREATE FUNCTION product(a INTEGER, b INTEGER)
  RETURNS INTEGER AS
  $$
  BEGIN
    RETURN a * b;
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM product(4,5);

-- create fibonacci function recursive
DROP FUNCTION IF EXISTS public.fibo(INTEGER);
CREATE FUNCTION fibo(num_terms INTEGER)
  RETURNS INTEGER AS
  $$
  BEGIN
    IF num_terms < 2 THEN
      RETURN num_terms;
    ELSE
      RETURN fibo(num_terms-2) + fibo(num_terms-1);
    END IF;
  END;
  $$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS public.concatenate(VARCHAR, VARCHAR);
CREATE FUNCTION concatenate(a VARCHAR, b VARCHAR)
  RETURNS VARCHAR AS
  $$
  BEGIN
    RETURN CONCAT(INITCAP(a),INITCAP(b));
  END;
  $$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS public.construct(VARCHAR, VARCHAR, VARCHAR);
CREATE FUNCTION construct(a VARCHAR, b VARCHAR, c VARCHAR DEFAULT 'pas.org')
  RETURNS VARCHAR AS
  $$
  BEGIN
    RETURN CONCAT(LOWER(SUBSTRING (a, 1,1)), LOWER(b), '@', c);
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM construct ('Annshine', 'Wu');
SELECT * FROM construct('Alex', 'Tai', 'has.org');

DROP FUNCTION IF EXISTS public.myMIMO(INTEGER, INTEGER, INTEGER);
CREATE FUNCTION myMIMO(a INTEGER, b INTEGER, c INTEGER,
    OUT total INTEGER, OUT maxi INTEGER) AS
  $$
  BEGIN
    total := a + b + c;
    maxi := greatest(a, b, c);
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM myMIMO (2,4,5);

DROP FUNCTION IF EXISTS public.getName(VARCHAR, VARCHAR);
CREATE FUNCTION getName(firstName VARCHAR, email VARCHAR,
    OUT domain VARCHAR, OUT lastName VARCHAR, OUT firstNameO VARCHAR) AS
  $$
  BEGIN
    domain := substr(email, strpos(email, '@')+1, char_length(email));
    lastName := INITCAP(substr(email, 2, strpos(email, '@')-2));
    firstNameO := INITCAP(firstName);
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM getName('annshine', construct('annshine', 'wu'));

-- average and total

DROP FUNCTION IF EXISTS public.ave_total(NUMERIC[]);
CREATE FUNCTION Ave_Total(Variadic inputs NUMERIC [], OUT total INTEGER, OUT average FLOAT) AS
  $$
  DECLARE
    r INTEGER;
  BEGIN
    total := 0;
    average := 0;
    FOR r IN SELECT unnest(inputs)
    LOOP
      RAISE NOTICE' %', r;
      total := total + r;
      average := average + 1;
    END LOOP;
    average := total / average;
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM Ave_total(12,15,1,7,8,8,8);
