

with student_edited as (

select First_Name, Last_Name,
concat(First_Name, ' ', Last_Name) as Full_Name,
BIRTH_DATE,
year(current_date) - year(BIRTH_DATE) as Age,
WEIGHT, HEIGHT,
weight / ( (height / 100) * (height / 100) ) as BMI,
CASE
when weight / ( (height / 100) * (height / 100) ) < 18.5 then 'Underweight'
when 18.5 <= weight / ( (height / 100) * (height / 100) ) <= 24.9 Then 'Healthy'
when 25 <= weight / ( (height / 100) * (height / 100) ) <= 29.9 Then 'Overweight'
else 'Obese'
End as BMI_Class,
SCIENCE, MATHS, ENGLISH, MARATHI, HINDI,
SCIENCE + MATHS + ENGLISH + MARATHI + HINDI as Total_Marks,
(SCIENCE + MATHS + ENGLISH + MARATHI + HINDI) / 5 as Percentage,
CASE
when (SCIENCE + MATHS + ENGLISH + MARATHI + HINDI) / 5 >= 90 then 'A+'
when 75 <= (SCIENCE + MATHS + ENGLISH + MARATHI + HINDI) / 5 <= 89.9 Then 'A'
when 60 <= (SCIENCE + MATHS + ENGLISH + MARATHI + HINDI) / 5 <= 74.9 Then 'B+'
when 50 <= (SCIENCE + MATHS + ENGLISH + MARATHI + HINDI) / 5 <= 59.9 Then 'B'
when 35 <= (SCIENCE + MATHS + ENGLISH + MARATHI + HINDI) / 5 <= 49.9 Then 'C+'
else 'Fail'
End as Grade,
DENSE_RANK() OVER (ORDER BY (SCIENCE + MATHS + ENGLISH + MARATHI + HINDI) / 5 DESC) AS Rank
from {{ source('student_source', 'student') }}
order by Rank 

)

select * from student_edited