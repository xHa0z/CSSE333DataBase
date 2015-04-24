Create Procedure dbo.[get_events_today]
as
select *
From Event 
where convert()Start < getdate() and convert()End > getdate()