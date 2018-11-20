\copy userTP FROM '../resources/Users.tsv'  DELIMITER E'\t' CSV FORCE_QUOTE HEADER;
\copy badges FROM '../resources/Badges.tsv' DELIMITER E'\t' CSV FORCE_QUOTE HEADER;
