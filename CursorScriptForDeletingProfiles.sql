/*
 
CursorScriptForDeletingProfiles.sql
 
This is a cursor script that will allow you to delete a
profile from multiple site codes 
 
make sure to comment out the print @ASite statement and uncomment out the execute statement 
below it.
 
*/ 
 
SET NOCOUNT ON
 
declare @ASite varchar(2)
 
select *
from web.dbo.profile (nolock)
where Avis='zz' and profile_id=4005630
 
declare sitecodes cursor scroll for 
  select avis from web.dbo.siteinfo (nolock) 
   
open sitecodes
 
fetch first from sitecodes into @ASite
while @@fetch_status = 0
begin
  print 'Delete profile 4005630 for site code: ' + @ASite 
  exec  web.dbo.DeleteProfile @ASite , 4005630
  fetch next from sitecodes into @asite
end 
close sitecodes
deallocate sitecodes
 
SET NOCOUNT OFF
