\copy userTP FROM '../resources/Users.tsv'  DELIMITER E'\t' CSV QUOTE '"' HEADER;
\copy badges FROM '../resources/Badges.tsv' DELIMITER E'\t' CSV QUOTE '"' HEADER;
