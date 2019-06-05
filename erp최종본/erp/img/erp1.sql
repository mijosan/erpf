SELECT * FROM (SELECT rownum as rnum, any_idx, any_title, any_name, any_date, any_hits, any_content, any_filename, any_filesize, emp_num 
FROM tblanonyboard)
WHERE rnum BETWEEN 10 AND 13;