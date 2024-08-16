
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
 




# TODO

a list of stuff/ideas we should support

 * should tools define which llm / model to use - or should they be agnostic and implement snippet extraction / prompt on each llm-implementation

* better environment info extraction (right now only from file extension)
 * in js read prettierrc or eslintrc to infer code style
   * maybe we can even give that config files directly as prompt context to reduce work.

* ollama llm - test https://ollama.com/library/codellama

* config: --tool="create" will override the tool to use
* config: --prompt="a function that..." will override user's prompt
* config: --environment="node.js and axios" will override inferred environment
* config: --query="create function that..." if given it will parse and override --tool and --prompt (same syntax as @code-ai annotation)
    so we don't need to edit file.

* mock llm for tests
* tools definition from file in $HOME/.code-ai or from current folder .code-ai or from --config arg
* tool overrides (I can load several tools-configs and override defaults)

* a tool to rewrite a entire file... these tools, instead of appending code, will oevrride the whole file in place.

* in-line mode vs replace file
  in-file will just add code next to prompt, this wont work when we want to replace the whole file, we need a --inFileReplaceAll flag (for example, "review the entire" file prompt)
* CLI help to describe tool, example code-ai --describe create : will print create tool description and example
* config: --answerPrefix="> ": option to prefix answer with string, so for example we could print the answer as a comment
* config: option to delete `@code-ai` line when writing response.

* bug: if we have comments (invalid anotations) that describe some code creation instructions, currently the llm will also perform those, example: 
  @code-ai create edscription..
  @ invalid review foo-bar

 * realtime / watch (low priority): 
  AC: as a user I just save a file and you run the tool for it automatically
   * support input globs & folders --input
   * CLI to watch glob file changes
      * on change rerun tool 
      * how to we handle multiple @code-ai annotations?


## DONE

 * logs --printPrompt and --printAnswer to debug both prompt and gpt raw answer
 * explain tool and list tools

# working examples:

// @code-ai create typescript interface for object o
const o = {a: 1, b: ['s'], c: [{j: 9}]}

// @code-ai create function that returns the average of given numbers

// @code-ai review function f

## sql generation

Note: you can use a tool like mysqldump to extract schema from a data base, example: 
mysqldump -u root -p1234 --host 127.0.0.1 --port 3306 db_name > file.sql

-- @code-ai create given sql schema, generate a sql query that returns users which lastConnection is in the last 5 minutes and their photos of album 1







use cases:
 * I can ask the tool to generate code given english description.
   * write code directly to specified file & line
 * code-reviews
   * replace file or create new one with code-review rewrites
     example: given the following code, could you review it and generate code with your suggested modifications? <- gpt and llama both answers nicely
 * refactor
    can you move this code block to a funciotn in module scope
 * know how
    just ask chat to provide steps by steps guides on how to add X to current project. For example: "step by step gide to add jest to this project"

other ideas: 
 * create a folders and files and execute commands, examples: 
    * generate a lerna mono repo from scratch called "foo" with two sub projects foo-js and foo-cli. foo-cli depends on foo-js
        this should generate folders/files and execute commands like npm i

# project information inferense
we should implement project metadata tool to feed gpt - extracted from code projects, like:
 * infer project language (python, js)
 * infer more data: node.js, react-native, web
 * libraries present
 * imported/available APIs
 * current function/method context
Also user should be able to correct or feed more info somehow.   


# interfaces
we could have many interfaces like CLI, js API, mixed CLI plus annotations in code

examples:

 * 100% cli  
   * 100% command line params I can perform an action over a file, like creating a function in a given line
   * example: code-ai --file f.js --line 14 --command create --query "create js fibonachi function"

 * cli+code annotations
   In a certain line of a file I add an annotation with a query and then just run a basic command:
   line in file: `// $code-ai: create fibonachi function`
   and then just command `code-ai f.js`

 * js api: no so important, but could be nice to use API from vscode extension instead spawning proccess

## in-file interaface

syntax: 

```
// @code-ai $TOOL_NAME $PROMPT
```
this will trigger a tool with inFile: {content} assigning file contents to `code` var and $PROMPT to `prompt` var

# tools

## configuration and user customization

Each command will have a prompt snippet. These should be modeled and configurable by user. User can add their own commands and snippets.

each tool is dynmaically defined in files, for example: 

tools {
  reviewFile: {
    tags: [review],
    prompt: you are a developer assistant working in a project $PROJECT_INFO. Please make a code review of the following file only highlighting critical errors and please only print one big snippet with all the changes. Code: $CODE
  },
  create: {
    tags: [create]
    prompt: you are a developer assistant working in a project $PROJECT_INFO. Please write the code that implement the following requirement: $USER_INPUT
  }
}

# other / OLD


## requirements

from API we need to reference: 

 * "this file on this line and column index"
 * the next expression or statement
 the expression/statement named "ABC"
 * code between X and Y indexes

## important decisions: 

### language agnostic or not

 * do we want to tight us to some languages in ast references ? (need to parse js, python, etc)?
 * or we do want to remain language agnostic, only with markings on code/files 
    have dump library which only works on strings doesnt know anything about ast?
Maybe we want to be progressive: 
 * first implementy language agnostic tools and simple language referencing
 * then implement project inference like libraries, etc
 * then implement advanced ast parsing and tools for each language
    for example being able to reference ast nodes in typescript files



 (can we reuse other projects that performs this like github-linguist?)

apis:
cli
js api
future: vscode extension

oriented to typescript projects - extract near interfaces/types

basic idea: 

use prompt: 
in the context of this file.ts can you create a function that sort users by created_at in sql?


this is basically an initial barebones POC project to make a real separate app in the future





support for llama and gpt
  config params (openai api key or ollama server...)



CLI idea for shortcuts

instead of making the question IN cli args like 
code-ai --file fo.js --query "create a function that... " use can edit a file adding a line in a particular place like:

// CODE_AI: create here a function that filter users by lastConnection less than 120 hours from now with sql
and then just call:
code-ai --file fo.js




--write : write in file / line the code
   if not just print to stdout only the snippet.

# docs

about coding prompts:
 * https://www.learnprompt.org/chat-gpt-prompts-for-coding/#google_vignette
 * https://github.com/eriknomitch/CoderGPT

