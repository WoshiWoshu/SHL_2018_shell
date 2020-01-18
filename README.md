# SHL_2018_shell
Second year mini project in Shell Scripting in which the goal is to write a shell script that allows to manage a database in a json file. It can create table, insert-update-remove data, run query ...

USAGE :

	./bdsh [OPTION]... [COMMAND] [REQUEST]

OPTION:

	  -h				display usage
	  -f FILE			json database file
	  -j                json formated output for select command

	COMMAND and REQUEST:
		create		create database
				Exemple: 
					./bdsh -f file.json create database
					./bdsh -f file.json create table user id,firstname,lastname
					./bdsh -f file.json create table age id,age

	insert		insert data in database
			Exemple:
				./bdsh -f file.json insert user id=1,firstname=John,lastname=SMITH
				./bdsh -f file.json insert user id=4,firstname=Robert\ John,lastname=WILLIAMS
				./bdsh -f file.json insert user id=2,firstname=Lisa,lastname=SIMPSON
				./bdsh -f file.json insert user id=10,lastname=SMITH
				./bdsh -f file.json insert user firstname=Laura,lastname=SMITH
				./bdsh -f file.json insert user id=9
				./bdsh -f file.json insert age id=1,age=42

	describe      describe table structure
			Exemple:
				./bdsh -f file.json describe user
				id
				firstname
				lastname

	select		display data from database
			Exemple:
				./bdsh -f file.json select user firstname,lastname
				firstname    | lastname
				-------------------------
				John         | SMITH
				Robert John  | WILLIAMS
				Lisa         | SIMPSON
				             | SMITH
				Laura        | SMITH
				             |
				./bdsh -f file.json select user lastname,firstname order
				lastname  | firstname
				-------------------------
				          |
				SIMPSON   | Lisa
				SMITH     |
				SMITH     | John
				SMITH     | Laura
				WILLIAMS  | Robert John
        
 NOTE :
 
	 - Shell must be /bin/sh or /bin/bash (#shebang)

	 - Database file is a json file correctly formated.
		Json file must contain 2 arrays for a table :
			desc_$table : array with field list of table
			data_$table : array with list : field:value
			see sample.json in subject directory
