CREATE OR REPLACE FUNCTION public.setdomain(role character varying)
 RETURNS TABLE(category_id integer, category_name character varying, domain_id integer, domain_suffix character varying)
 LANGUAGE plpgsql
AS $function$
  DECLARE
    domainid INT;
    countduplicate INT;
  BEGIN
    SELECT count(category_name) INTO countduplicate FROM category WHERE category_name = role;

    IF countduplicate = 0 THEN
      INSERT INTO domain(domain_suffix) VALUES (concat(role, '.pas.org'));
      SELECT domain.domain_id INTO domainid FROM domain WHERE domain.domain_suffix = concat(role, '.pas.org');
      INSERT INTO category(category_name, domain_id) VALUES (role, domainid);
    ELSE
      RAISE NOTICE 'Duplicate Entry';
    END IF;
    RETURN QUERY SELECT category.category_id, category.category_name, domain.domain_id, domain.domain_suffix FROM domain INNER JOIN category USING (domain_id);
  END;
  $function$
  
CREATE OR REPLACE FUNCTION public.randtable(numvalue integer)
 RETURNS TABLE(number integer)
 LANGUAGE plpgsql
AS $function$
  BEGIN
    FOR counter IN 1..numVALUE  LOOP
      number:= TRUNC(random()*100);
      RETURN NEXT;
    END LOOP;
  END;
  $function$
