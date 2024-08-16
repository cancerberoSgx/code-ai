

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

 * supports local folder .code-ai-tools.yml users can have in project root


## DONE

 * logs --printPrompt and --printAnswer to debug both prompt and gpt raw answer
 * explain tool and list tools
 * tool overrides (I can load several tools-configs and override defaults)
 * tools definition from file in $HOME/.code-ai or from current folder .code-ai or from --config arg