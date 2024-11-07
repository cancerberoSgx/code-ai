
# About 

 * Use LLM like chat-GPT or llama to generate code or review code in a practical way for programmers. 
 * It supports a practical interface for developers based on source code files.
 * Language agnostic
 * automatic source code & project context
 * designed to be easy to reuse in IDEs / editor extensions, both CLI and JS API.

TODO: animated showcase video.

# Install

```
npm i -g code-ai
```

Note: If you are developing in JavaScript, you can always install this as a local development dependency and use it locally with `npx code-ai ...`

# Usage

The easiest way to use it is by using `@code-ai` comments in your code to ask the tool to write some code. For example in typescript, create a `test.ts` file with the following content:

```ts
interface Person {
  name: string
  age: number
}

// @code-ai create function that, given a Person array deduplicate by name and sorts by age
```

Here we are asking the tool to `create` code with given specifications. Now execute the follwing command and after few seconds it will a new function will be generated after the comment:

```sh
code-ai test.ts
```

For this to work you should have to configure an LLM implementation like chat-gpt or ollama. The following sections explain how to configure both

Notes: 

 * This tool also provides other interfaces to use it, for example, one 100% command line without messing up with your source files. See CLI user interface section for more details.
 * here we used TypeScript as an example, you can do the same with any other kind of source code like python, sql, etc by using a comment with the same syntax. See in-file usage section below for more details about this syntax

## Using Open AI chat-gpt

You will need an openai_api_key. Follow these instructions if you don'g have one: https://help.openai.com/en/articles/4936850-where-do-i-find-my-openai-api-key

```sh
export OPENAI_API_KEY="your-key"
code-ai test.ts
```

By default the tool try to use chat-gpt with model `gpt-3.5-turbo`, but you can specify other models, for example: `--llm gpt --model gpt-4o`

## Using ollama

You can run [https://ollama.com/](ollama) 100% locally and use it like this:

```sh
code-ai test.ts --llm ollama 
```

As default will use llama3.1 model so you need to run `ollama run llama3.1`

If you want to try it with another model use `--model` arg

# CLI reference

```sh
Usage: 
  code-ai input/file.js [options]
Options: 
  --config              aditional tools yml config file to add
  --output              output file, if not given it will re-write input file in place
  --tool                indicate which tool to use, only mandatory on 100% CLI mode
  --prompt              indicate user prompt to use, only mandatory on 100% CLI mode
  --model               LLM model, such as gpt-4 or gpt-3.5-turbo for chat-GPT. Default for openAI is gpt-4o
  --llm         Which LLM service to use, currently must be one of 'gpt' or 'ollama', by default is 'gpt'
  --describe             Prints help on a tool, example: --describe create
  --list                list all available tools
  --verbose             prints on stdout all the info, like prompt given to llm, llm raw response, extracted snippets, etc
```

# CLI user interface

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


# JS API

TODO

# TODO

[See this doc](docs/TODO.md)


# Examples

TypeScript

```ts
// @code-ai create typescript interface for object o
const o = {a: 1, b: ['s'], c: [{j: 9}]}
```

```ts
// @code-ai create function that returns the average of given numbers
```

Python

```py
def f:
  return i+1
// @code-ai review function f
```

## sql generation

Note: you can use a tool like mysqldump to extract schema from a data base and then ask to write queries or review queries on it

```sql
-- @code-ai create given sql schema, generate a sql query that returns users which lastConnection is in the last 5 minutes and their photos of album 1
```

Example of generting schema from mysql db: `mysqldump -u root -p1234 --host 127.0.0.1 --port 3306 db_name > file.sql`
