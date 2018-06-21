#Chapter 13 Mining Text To Find Meaningful Data (p 211)
#Complete list of PostgreSQL string functions at https://www.postgresql.org/docs/current/static/functions-string.html

select upper('hello');  --return HELLO
select lower('Randy');  --return Randy
select initcap('at the end of the day');  --return At The End Of The Day
select char_length('Patrick');  --return 7
select length('Patrick');  --return 7
select position(',' in 'Tan, Bella');  --return 4
select trim('s' from 'socks'); --return ock
select trim(trailing 's' from 'socks');  --return sock
select trim(leading 's' from 'socks');  --return ocks
select trim('     Pat     '); --return Pat without spaces
select char_length(trim('     Pat     '));  --return 3
select ltrim('socks','s');  --return ocks
select rtrim('socks','s');  --return sock
select left('Peanut Butter Sandwiches',5);  --return Peanu
select right('Peanut Butter Sandwiches',5);  --return iches
select replace('bat','b','c');  --return cat

--RM:  skipped Matching Text With Regular Expressions p214-231

--PostgreSQL comes with a powerful full text search engine.  Instructor shows a simple example of setting up a table for text search and functions for searching using PostgreSQL.  PostgreSQL implementation of text search includes two data types.  tsvector data type represents the text to be stored and to be stored in an optimized form.  tsquery data type represents the search query terms and operators.
--tsvector data type reduces text to a sorted list of lexemes which are units of meaning in language.  Think of lexemes as words without the variations created by suffixes; e.g. the tsvector format store the words washes, washed, and washing as the lexeme wash.  Also, converting text to tsvector also removes small stop words which usually don't play a role in search such as "the" or "it".
select tsvector('I am walking across the sitting room to sit with you.');  --return 'I' 'across' 'am' 'room' 'sit' 'sitting' 'the' 'to' 'walking' 'with' 'you.'
select to_tsvector('I am walking across the sitting room to sit with you.');  --return 'across':4 'room':7 'sit':6,9 'walk':3.  Number of words reduced from eleven to four, elimiated words such as "I", "am", and "the", removes suffixes such as walking to walk and sitting to sit, orders the words alphabetically, and recognized sit in two positions sitting and sit.
--tsquery search terms & for AND, | for OR, ! for NOT, <-> for adjacent words or words a certain distance apart
select to_tsquery('walking & sitting')  --return 'walk' & 'sit'.  Convert search terms to the tsquery data type.
--@@ checks whether a query matches text
select to_tsvector('i am walking across the sitting room') @@ to_tsquery('walking & sitting');  --return true
select to_tsvector('i am walking across the sitting room') @@ to_tsquery('walking & running');  --return false
create table president_speeches (sotu_id serial primary key, president varchar(100) not null, title varchar(250) not null, speech_date date not null, speech_text text not null, search_speech_text tsvector);
copy president_speeches (president, title, speech_date, speech_text)
from 'i:\program files\postgresql\sotu-1946-1977.csv'
with (format csv, delimiter '|', header off, quote '@');
update president_speeches
set search_speech_text = to_tsvector('english', speech_text);  --copy speech_text column to search_speech_text column and transforming search_speech_text to tsvector as english language
create index search_idx on president_speeches using gin(search_speech_text);  --create index on search_speech_text column adding gin index containing an entry for each lexeme and its location.
select president, speech_date
from president_speeches
where search_speech_text @@ to_tsquery('Vietnam')
order by speech_date;  --return presidents and speech date containing Vietnam
--ts_headline() pass speech_text column searching Vietnam.  Identify or highlighting Vietnam beginning with < and ending with >.  Set minimum words and maximum words to display.  Set maximum number of fragments to show.  RM:  I think fragments is number of searches return.
select president, speech_date, ts_headline(speech_text, to_tsquery('Vietnam'), 'StartSel = <, StopSel = >, MinWords = 5, MaxWords=7, MaxFragments=1')
from president_speeches
where search_speech_text @@ to_tsquery('Vietnam');
--multiple search terms
select president, speech_date, ts_headline(speech_text, to_tsquery('transportation & !roads'), 'StartSel = <, StopSel = >, MinWords = 5, MaxWords=7, MaxFragments=1')
from president_speeches
where search_speech_text @@ to_tsquery('transportation & !roads');  --include the word transportation and exclude the word roads
--adjacent words or words must be together
select president, speech_date, ts_headline(speech_text, to_tsquery('military <-> defense'), 'StartSel = <, StopSel = >, MinWords = 5, MaxWords=7, MaxFragments=1')
from president_speeches
where search_speech_text @@ to_tsquery('military <-> defense');  --military defense must be together
--two words apart or one word separting the two words
select president, speech_date, ts_headline(speech_text, to_tsquery('military <2> defense'), 'StartSel = <, StopSel = >, MinWords = 5, MaxWords=7, MaxFragments=1')
from president_speeches
where search_speech_text @@ to_tsquery('military <2> defense');  --e.g. our military and defense commitments
--ts_rank() generates a decimal rank value based on how often the lexemes you're searching for appear in the text.  The other function, ts_rank_cd(), considers how close the lexemes earched are to each other.  The rank value is an arbitrary decimal that's useful for sorting.  There's no inherent meaning.
select president, speech_date, ts_rank(search_speech_text, to_tsquery('war & security & threat & enemy')) as tsrankscore
from president_speeches
where search_speech_text @@ to_tsquery('war & security & threat & enemy')
order by tsrankscore desc;
select president, speech_date, ts_rank(search_speech_text, to_tsquery('war & security & threat & enemy'),2)::numeric as tsrankscore
from president_speeches
where search_speech_text @@ to_tsquery('war & security & threat & enemy')
order by tsrankscore desc;  --adding number 2 or code 2 to to_tsquery divide the score by the length of the data.  It factors the length of each speech.  The socre is normalized by the document length giving an apples-to-apples comparison.  https://www.postgresql.org/docs/current/static/textsearch-controls.html lists all the options available for text search.