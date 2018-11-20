\copy userTP FROM '../resources/Users.tsv'  WITH DELIMITER E'\t' CSV FORCE QUOTE HEADER;
\copy badges FROM '../resources/Badges.tsv' WITH DELIMITER E'\t' CSV FORCE QUOTE HEADER;
