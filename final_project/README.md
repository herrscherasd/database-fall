# Final project idea

A database for borrowing equipment at the university. Students could reserve a camera, laptop or projector, and staff would record when it was taken and returned.

## Tables I could use

- departments
- borrowers
- staff
- categories
- equipment_models
- equipment_items
- reservations
- loans
- maintenance_periods

A model and an actual item would be separate. For example, there could be three cameras of the same model, each with its own inventory number. A reservation is also different from a loan, since someone might cancel or never collect the item.

## What it should do

Show available equipment, make a reservation, record checkout and return, and list overdue loans. Equipment under maintenance should not be available. Two people should not be able to book the same item for overlapping times.

For queries I could use joins for borrowing history, aggregates for popular categories, and subqueries or window functions for reports.

## What I need to submit

The syllabus says this is a team project. It needs an ER diagram, a normalized schema, PostgreSQL scripts, basic and advanced queries, transactions, indexing, and a backup/restore strategy. It is worth 20% and goes on GitHub or GitLab.

I would start with the diagram and booking rules, then create the tables and sample data. After that, add the queries and test booking from two sessions. For indexing, compare query plans with enough data to see a difference. Finally, back up the database and restore it into a new one.

No need to start with a website; the database and SQL demonstration would be the first part. This is still the project idea, not the finished project.
