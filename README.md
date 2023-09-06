# ReadMe

Hi! This was an extremely fun technical challenge. I thoroughly enjoyed it!

Just going over some technical things.
Ruby version: 3.2.2
RSpec version: 3.12.0
StanardRB version 1.13.0 (because I don't like making decisions on Ruby style and will pass that ownership off to the gem owners (Test Double))

To get this going and run tests:
```bash
$ bundle install
$ rspec
....................

Finished in 0.01489 seconds (files took 0.14799 seconds to load)
20 examples, 0 failures

```

To run it locally:
```bash
$ ruby lib/runner.rb input.csv # this is a copy of the originally included CSV

output.txt & records.csv have been generated
use `cat output.txt` or `cat records.csv` to view the files

$ cat output.txt

12 valid record(s)
2 invalid record(s).
Here are the list of errors from the invalid records:
effective_date cannot be blank
phone_number is improperly formatted

$ cat records.csv

first_name,last_name,dob,member_id,effective_date,expiry_date,phone_number
Brent,Wilson,2019-01-01,349090,2019-09-30,2020-09-30,(303) 887 3456
Nikola,Jokic,2019-02-02,890887,2019-09-30,2020-09-30,303-333-9987
Baker,Mayfield,1988-01-04,349093,2019-09-30,2050-12-13,13039873345
Serena,Williams,2019-04-04,jk 909009,2017-11-11,2050-12-14,444-555-9876
Jake,Jabs,2019-01-06,349090,2019-09-30,2050-12-15,444-555-9877
Mary,Poppins,2019-01-07,uu 90990,2019-09-30,2050-12-16,444-555-9878
Sally,Jesse Rephael,1988-01-08,349097,2019-09-30,2050-12-17,444-555-9879
Bruce,Springsteen,1988-01-09,234324,2019-09-30,"",444-555-9880
Jason,Statham,1988-02-12,349099,2019-09-30,"",606-555-9886
Lenny,Bruce,1988-01-11,349100,2019-09-30,"",202-555-9882
Martin,Short,1988-01-12,349101,2019-09-30,"",404-555-9883
Benny,Samson,1988-01-13,349102,2019-09-30,"",44425559884
```

## My Approach

My thought was to keep everything separated. After reading the original readme (still in tact below), I drew out some ideas and check boxes to keep myself moving in the right direction.

I started from the meatiest portion, the `PatientRecord` model. I happy pathed it without validations at first, then added validations, then extracted them to their own module. I then moved to the data store to move some reponsibility for generating the csv and separating the records by validity. From there I created a file handler to allow for reading / writing responsibilities. Then lastly was a runner file that pulled it all together. I was originally attempting to reach for a `rake` task, but it seemed like overkill to import it into a Ruby project when time was of the essence.


## Things I might do next if there was more time

- Make the validator more universal. It felt like I was recreating validations from ActiveRecord, which I've never properly given much thought to on how it's implemented, but the ability to check dates, phone numbers and other pieces of data.
- Write and test a proper rake file to replace the runner.
- Return the offending data that prevented records from being saved
- Refactor the assignement of data that needed to be parsed / coerced. I think I have a littleb it of inconsistency between phone numbers and dates
---
# Original Readme
## Goal

Write a Ruby program that transforms raw data into a standardized format. The objective is to provide a valid .csv which allows the highest number of valid patient records
to be imported by the next stage of the process (not seen here). Some of the data will be invalid so there will be 2 output
files from your program, one of which will be the .csv and the other a report.txt file.

## Expectations

Try to time-box the exercise at around ~ 3 hours.
Keep this constraint in mind as you work, it's very possible that certain items don't get finished, try
to save a few minutes to summarize your efforts in a readme or email if this is the case.

## Requirements

- Parse the provided .csv containing patient information
- Clean / coerce data elements according to transform rules
- Provide instructions on how to run your program
- Your program should process and produce a .csv file (output.csv)
- Your program should ALSO produce a report file (report.txt) that summarizes the processing outcome (be creative in its contents)
- Use a recent stable version of Ruby MRI
- Please specify Ruby version and / or include a .tool-versions or .ruby-version file
- Limit libraries used in your implementation to ONLY [standard library](http://www.ruby-doc.org/stdlib/)
- Leverage Git, and demonstrate your workflow / style via commits
- Ensure there are tests included:
  - [RSpec](https://github.com/rspec/rspec)
  - [test-unit](https://github.com/test-unit/test-unit)
  - [minitest](https://github.com/seattlerb/minitest)
- Email your solution as a public Github repository link OR a .zip package to engineeringjobs@cirrusmd.com, include 'Software Engineer Take-Home' in the subject.

### Transform Rules

- Trim extra white space for all fields
- Transform phone_numbers to E.164 format (Please assume all numbers to be US e.g. +1)
- Transform ALL dates to ISO8601 format (YYYY-MM-DD)

### Validation Rules

- Phone Numbers must be E.164 compliant (country code + 10 numeric digits)
- first_name, last_name, dob, member_id, effective_date are ALL required for each patient

## Evaluation

The qualities we're looking for are:

- **Clarity**: is the code organized and structured well, is it easy to read and comprehend?
- **Maintainability**: if it had to be updated / extended how easy would that be?
- **Testability**: are the tests comprehensive and covering the appropriate use cases?

## Input

Please use the provided data file as the input for your solution.

- input.csv
  - Delimiter: `,`
  - Fields: `last_name`, `first_name`, `dob`, `member_id`, `effective_date`, `expiry_date`, `phone_number`

## Output

1. Running your tests should produce 0 errors or be explained in your readme
2. Running your script should produce a cleaned .csv (output.csv)
3. Running your program should also produce a summary report (report.txt)

## Questions

If you have questions about the instructions, please ask. We want you to be successful. If you have a question about how
to handle something that wasn't specifically addressed, make a decision and feel free to call it out in your
readme or email with your reasoning behind your decision. No right or wrong answers for these types of things.
