
# about 

 * Use LLM like chat-GPT or llama to generate code or review code in a practical way for programmers. 
 * Language agnostic
 * automatic source code & project context
 * has a practical user interface in the source code itself, by writing/replacing code in-file
 * designed to be easy to reuse in IDEs / editor extensions, both CLI and JS API.


TODO: animated showcase.

# install

```
npm i -g code-ai
```

# Usage

```
export OPENAI_API_KEY="your-key"
```

## in-file user-interface
 explain how to use file annotations and simple cli
 explain annotation syntax and the concept of tools
 


# working examples:

// @code-ai create typescript interface for object o
const o = {a: 1, b: ['s'], c: [{j: 9}]}

// @code-ai create function that returns the average of given numbers

// @code-ai review function f

## sql generation

Note: you can use a tool like mysqldump to extract schema from a data base, example: 
mysqldump -u root -p1234 --host 127.0.0.1 --port 3306 db_name > file.sql

-- @code-ai create given sql schema, generate a sql query that returns users which lastConnection is in the last 5 minutes and their photos of album 1



