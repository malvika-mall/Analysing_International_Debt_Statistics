DO $$
BEGIN
  FOR i IN 2006..2022 LOOP
    EXECUTE 'ALTER TABLE international_debt ADD COLUMN year_' || i || ' numeric';
  END LOOP;
END$$;


