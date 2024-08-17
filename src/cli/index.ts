import { getTool, getTools } from '../tool/registerTool';
import { Tool, ToolOutput } from '../tool/types';
import { getEnvironment, setEnvironment } from './cliEnvironment';
import { executeCli, executeCliInFile } from './cliInFile';
import { cliRegisterTools } from './cliLoadTools';

export interface CliArgs {
  config: any;
  input: string;
  /** Output file, if not given it will re-write input file in place */
  output?: string;
  tool?: string;
  prompt?: string;
  model?: string;
  describe?: string;
  list?: boolean;
  verbose?: boolean;
}

const cliArgsHelp: { [name: string]: string } = {
  config: 'aditional tools yml config file to add',
  output: 'output file, if not given it will re-write input file in place',
  tool: 'indicate which tool to use, only mandatory on 100% CLI mode',
  prompt: 'indicate user prompt to use, only mandatory on 100% CLI mode',
  model: `LLM model, such as gpt-4 or gpt-3.5-turbo for chat-GPT. Default for openAI is gpt-4o`,
  describe: ' Prints help on a tool, example: --describe create',
  list: 'list all available tools',
  verbose: 'prints on stdout all the info, like prompt given to llm, llm raw response, extracted snippets, etc',
};

function parseArgs(argv: any) {
  let input = argv._[0];
  const a: CliArgs = { ...argv, input };
  return a;
}

export async function handleCli() {
  const argv = require('minimist')(process.argv.slice(2)) as any;
  validateArgs(argv);
  const args: CliArgs = parseArgs(argv);
  setEnvironment(args);
  cliRegisterTools(args);
  handleDescribe(args);

  // HEADS UP: if user pass --tool, --output and --prompt we use pure cli - if not we try to use in-file mode
  let result: ToolOutput;
  // const extras = {...args.model?{model: args.model}:{}}
  if (args.tool && args.prompt && args.output) {
    result = await executeCli({ ...args, vars: { environment: getEnvironment() } });
  } else {
    result = await executeCliInFile({ ...args, vars: { environment: getEnvironment() } });
  }
  if (args.verbose) {
    console.log('PROMPT:\n', result.prompt, '\n');
    console.log('RAW ANSWER:\n', result.raw, '\n');
    console.log('SNIPPETS:\n', '  ' + result.snippets.map(s => `${s.language}:\n${s.text}`).join('\n  '), '\n');
  }
}

function validateArgs(argv: any) {
  if (argv.help) {
    console.log(help());
    process.exit(0);
  }
  let error = '';
  if (!argv._?.length) {
    error = 'Missing input file';
  }
  if (error) {
    console.log('ERROR: ' + error);
    console.log(help());
    process.exit(1);
  }
}

function help() {
  return `
Usage: 
  code-ai input/file.js [options]
Options: 
${Object.keys(cliArgsHelp)
  .map(name => `  --${name}\t\t${cliArgsHelp[name]}`)
  .join('\n')}
  `.trim();
}

function handleDescribe(args: CliArgs) {
  if (args.describe) {
    const tool = getTool(args.describe);
    const description = describeTool(tool);
    console.log(description);
    process.exit(0);
  }
  if (args.list) {
    const tools = getTools();
    // const s = '\n'+tools.map(describeTool).join('\n\n')
    const s = `
Tools:
${tools.map(t => ` * ${t.metadata.name}\t\t${t.metadata.description || ''}`).join('\n')}
    `.trim();
    console.log(s);
    process.exit(0);
  }
}

function describeTool(tool: Tool) {
  return `
Tool "${tool.metadata.name}"
  ${tool.metadata.description}
Examples:
  ${(tool.metadata.examples || []).join('\n  ')} 
    `.trim();
}

// old yargs code:

// import yargs from 'yargs';
// import { hideBin } from 'yargs/helpers';

// export enum Command {
//   create = 'create',
// }
// const argv = (yargs(hideBin(process.argv)) as any)
// .option('input', {
//   alias: 'i',
//   type: 'string',
//   description: 'Input file',
// })
// .option('output', {
//   alias: 'o',
//   type: 'string',
//   description: 'Output file, if not given it will re-write input file in place',
// })
// .command(
//   '$0 <positional>',
//   'Input file',
//   (yargs: any) => {
//     yargs.positional('positional', {
//       describe: 'The mandatory positional argument',
//       type: 'string',
//     });
//   },
//   (argv: any) => {
//     console.log(`You provided: ${argv.positional}`);
//   }
// )
// .option('_', {
//   type: 'string',
//   description: 'Input file',
// })

// .demandCommand(1, 'You need to provide input file')
// .help()
// .argv;
