--CREATE A NEW FIELD CALL "contest"
--CREATE A NEW FIELD CALL "date_contest" 
-- TABLE dbo.[order]
alter table dbo.[order] add contest bit; 
alter table dbo.[order] add date_contest datetime;