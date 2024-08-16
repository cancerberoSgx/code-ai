
# About 

 * Use LLM like chat-GPT or llama to generate code or review code in a practical way for programmers. 
 * It supports a practical interface for developers based on source code files.
 * Language agnostic
 * automatic source code & project context
 * designed to be easy to reuse in IDEs / editor extensions, both CLI and JS API.

TODO: animated showcase video.

# install

```
npm i -g code-ai
```

If you are working in a node.js environment, you can always install this as a local development dependency and use `npx code-ai ...` locally

# Usage

```
export OPENAI_API_KEY="your-key"
```

## in-file user-interface

 explain how to use file annotations and simple cli
 explain annotation syntax and the concept of tools
 
## CLI user interface

To use the tool 100% command line, you need to specify three parameters: `--output`, `--tool` and `--prompt`

`--output` without arguments will print the answer to stdout
`--output fileName` will append result to an existing or new file.

Examples: 

print to stdout:
```
code-ai file.js --output --tool create --prompt "function that calculate average of given array of numbers"
```

append the result to an existing or new file `out.js`:
```
code-ai file.js --output out.js--tool create --prompt "function that calculate average of given array of numbers"
```

Example: print in a new file some task withotut any context than the file extension (to know its language):
```
code-ai tmp.js --output tmp.js --tool create --prompt "function that calculate given numbers average"
```


## JS API

TODO


# working examples:

// @code-ai create typescript interface for object o
const o = {a: 1, b: ['s'], c: [{j: 9}]}

// @code-ai create function that returns the average of given numbers

// @code-ai review function f

## sql generation

Note: you can use a tool like mysqldump to extract schema from a data base, example: 
mysqldump -u root -p1234 --host 127.0.0.1 --port 3306 db_name > file.sql

-- @code-ai create given sql schema, generate a sql query that returns users which lastConnection is in the last 5 minutes and their photos of album 1



