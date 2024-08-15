import { getConfig } from '../config';
import { chatCompletion } from '../gpt/completionsApi';
import { renderTemplate } from '../util';
import { extractCodeSnippets } from './parsingTools';
import { OpenAiConfig, Tool, ToolOutput, ToolOutputDestination, ToolOutputFormat, ToolRunArgs } from './types';

export async function executeTool(tool: Tool, args: ToolRunArgs): Promise<ToolOutput> {
  // if(args.inFile) {
  //   args.vars.code = args.inFile.fileContents
  //   const inFileData = extractAnnotationInfo(args.inFile)
  // }
  const config = args.config||getConfig()
  if (tool.config.llm === 'gpt') {
    const prompt = renderTemplate(tool.config.prompt, args.vars);
    let t0 = new Date().getTime();
    // const openAiConfig: OpenAiConfig = { model: 'gpt-4o', openApiKey: process.env.OPENAI_API_KEY! }
    const response = args.dryRun ? '' : await chatCompletion({ prompt, config: config.openAi });
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
  } else {
    throw new Error('ollama not implemented');
  }
}
