CREATE DATABASE sqlskills;

create table numbers (numbercol int, charcol varchar (100));

SELECT * FROM generate_series(1,20);
SELECT LEFT(md5(random()::TEXT),100)
SELECT md5 (random ()::text),100

insert into numbers (numbercol, charcol)
select generate_series, left(md5 (random ()::text),100)
from generate_series (1,5000)
order by random ();

create index idx_numbers_numbercol on numbers (numbercol);

SELECT * FROM numbers n ;
cluster numbers using idx_numbers_numbercol;

select numbercol
from numbers n
where numbercol = 2500;

explain (analyze, buffers)
select numbercol
from numbers n
where numbercol = 2500;
--Index Only Scan using idx_numbers_numbercol on numbers n  (cost=0.28..4.30 rows=1 width=4) (actual time=0.063..0.066 rows=1 loops=1)
--  Index Cond: (numbercol = 2500)
--  Heap Fetches: 0
--  Buffers: shared hit=3
--Planning Time: 0.834 ms
--Execution Time: 0.116 ms


select hashtext ('Paul') as hashvalue;
select mod (hashtext ('Paul'), 10) as bucketpointer;


drop table numbers;

create table numbers (numbercol int, charcol varchar(100));

insert into numbers (numbercol, charcol)
select generate_series, left (md5 (random()::text),100)
from generate_series (1,5000)
order by random ();

create index idxhash_numbers_numbercol on numbers using hash (numbercol);

explain (analyze)
select *
from numbers n
where numbercol = 2500;
--Index Scan using idxhash_numbers_numbercol on numbers n  (cost=0.00..8.02 rows=1 width=37) (actual time=0.084..0.086 rows=1 loops=1)
--  Index Cond: (numbercol = 2500)
--Planning Time: 0.221 ms
--Execution Time: 0.131 ms

