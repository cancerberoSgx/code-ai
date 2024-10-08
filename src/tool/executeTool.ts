import { getConfig } from '../config';
import * as gpt from '../gpt/completionsApi';
import * as ollama from '../ollama/completionsApi';
import { renderTemplate } from '../util';
import { extractCodeSnippets } from './parsingTools';
import { LLMs, Tool, ToolOutput, ToolOutputDestination, ToolOutputFormat, ToolRunArgs } from './types';

export async function executeTool(tool: Tool, args: ToolRunArgs): Promise<ToolOutput> {
  const config = args.config || getConfig();
  const prompt = renderTemplate(tool.config.prompt, args.vars);
  const llm = args.llm || tool.config.llm || LLMs.gpt;
  // console.log('executeTool', args, { llm });
  let t0 = new Date().getTime();
  let response: string;
  if (llm === LLMs.gpt) {
    config.openAi.model = args.model || config.openAi.model;
    response = args.dryRun ? '' : await gpt.chatCompletion({ prompt, config: config.openAi });
  } else if (llm === LLMs.ollama) {
    config.ollama.model = args.model || config.ollama.model;
    response = args.dryRun ? '' : await ollama.chatCompletion({ prompt, config: config.ollama });
    console.log(response);
    // throw new Error(`LLM ${llm} not implemented`);
  } else {
    throw new Error(`LLM ${llm} not implemented`);
  }

  const output: ToolOutput = {
    raw: response,
    snippets: extractCodeSnippets(response),
    llmTime: new Date().getTime() - t0,
    prompt,
    output: '',
  };

  let out = '';
  if (args.output.format === ToolOutputFormat.raw) {
    out = output.raw;
  } else if (args.output.format === ToolOutputFormat.firstSnippet) {
    // TODO: validate if !output.snippets.length ? throw error?
    out = output.snippets[0]?.text || '';
  } else {
    throw new Error('not implemented args.output.format=' + args.output.format);
  }

  if (args.output.destination === ToolOutputDestination.stdout) {
    console.log(out);
  }
  if (args.output.destination === ToolOutputDestination.none) {
    // console.log(out);
  } else {
    throw new Error('not implemented args.output.destination=' + args.output.destination);
  }
  output.output = out;
  return output;
}
