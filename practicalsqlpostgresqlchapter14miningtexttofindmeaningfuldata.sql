select ('hello'); --print hello
select upper('upperCASE7'); --print UPPERCASE7
select lower('LOWERcase7'); --printlowercase7
select initcap('The sentence all words begin with a capital letter 7 PostgreSQL only'); --The Sentence All Words Begin With A Capital Letter 7 Postgresql Only
select char_length(' Pat count spaces  '); --print 19
select length(' Pat count spaces  '); --print 19
select position(',' in 'The comma position, is 19'); --print 19
select trim(' remove spaces at beginning and the end '); --"remove spaces at beginning and the end"
select trim('s' from 'socks'); --print ock
select trim(leading 's' from 's remove the s at the begin socks'); --" remove the s at the begin socks"
select trim(trailing 's' from 's remove the s at the end socks'); --s remove the s at the end sock
select ltrim('sPostgreSQL specific remove s from the left ends','s'); --"PostgreSQL specific remove s from the left ends"
select rtrim('sPostgreSQL specific remove s from the right ends','s'); --"sPostgreSQL specific remove s from the right end"
select left('leftExtract the selected characters from the left',35);  --leftExtract the selected characters
select right('from the right Extract the selected characters right',37);  --Extract the selected characters right
select replace('Substitute substitute for replace','Substitute','Replace');  --Replace substitute for replace