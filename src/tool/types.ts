export interface ToolMetadata {
  tags: string[];
  name: string;
  description?: string;
  examples?: string[];
}

/** tool defines model and prompt template which is feed by ToolRunArgs's vars and actions to produce output */
export interface Tool {
  metadata: ToolMetadata;
  config: ToolConfig;
  // input: ToolInput
}

/** response format, for example, extracting first code snippet only */
export enum ToolOutputFormat {
  raw = 'raw',
  firstSnippet = 'firstSnippet',
  // /** if raw response is "yes" then it exits process with status 0, otherwhise with 1 */
  // yesNoExitStatus = 'yesNoExitStatus',
}

/** how the tool will action. For example, print all in stdout, or first snippet, or create a new file or modify in-file */
export enum ToolOutputDestination {
  stdout = 'stdout',
  newFile = 'newFile',
  /** writes in current file given line number */
  currentFile = 'currentFile',
  none = 'none',
}

export interface ToolConfig {
  prompt: string;
  // outputType: ToolOutputType
  llm: 'gpt' | 'ollama'; // TODO remove
  model: string; // TODO remove
  // output: {
  //   destination?: ToolOutputDestination,
  //   currentFile?: string
  //   /** line number where to insert output for destination.currentFile. If none it prints at line 0 */
  //   lineNumber?: number
  //   /** name of new file for destination.newFile */
  //   newFile?: string
  //   format: ToolOutputFormat
  // }
}

export enum ToolOutputType {
  code = 'code',
  yesNo = 'yesNo',
}

export interface ToolRunArgs {
  /** to be matched in any prompt template */
  vars: { [key: string]: string };
  output: {
    /** action to perform */
    destination: ToolOutputDestination;
    format: ToolOutputFormat;
    currentFile?: string;
    /** line number where to insert output for destination.currentFile. If none it prints at line 0 */
    lineNumber?: number;
    /** name of new file for destination.newFile */
    newFile?: string;
  };
  /** just print final prompt, don't hit llm (testing) */
  dryRun?: boolean;
  config?: ToolRunConfig;
  model?: string;
  llm?: LLMs;
  // openAiConfig: OpenAiConfig

  // /** this is for in-file annotations */
  // inFile?: ToolRunInFileArgs
}

export interface ToolRunConfig {
  openAi: OpenAiConfig;
  ollama: OllamaConfig;
}
export interface OllamaConfig {
  host?: string;
  model?: string;
}

export interface OpenAiConfig {
  model?: string;
  apiKey?: string;
}

/** high level tool run args */
export interface ToolArgs {
  fileContents: string;
  fileName: string;
  /** base prompt vars, like `environment` */
  vars?: { [k: string]: string };
  config?: ToolRunConfig;
  model?: string;
  llm?: LLMs;
}

export enum LLMs {
  gpt = 'gpt',
  ollama = 'ollama',
}

export interface ToolRunInFileArgs extends ToolArgs {
  annotationRegex?: string;
}

export interface CodeSnippet {
  language: string;
  text: string;
}

export interface ToolOutput {
  /** final extracted output, could be code snippet */
  output: string;
  /** in-file replacement, this is the original given code plus inserted llm answer */
  inFileResult?: string;
  raw: string;
  snippets: CodeSnippet[];
  llmTime: number;
  /** final prompt given to LLM */
  prompt: string;
}

/** generic message type */
export interface ChatMessage {
  role: 'system' | 'user' | 'assistant';
  content: string;
}
