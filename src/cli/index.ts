import { getTool, getTools } from '../tool/registerTool';
import { Tool } from '../tool/types';
import { getEnvironment, setEnvironment } from './cliEnvironment';
import { executeCliInFile } from './cliInFile';
import { cliRegisterTools } from './cliLoadTools';

export interface CliArgs {
  config: any;
  input: string;
  // command: Command;
  /** Output file, if not given it will re-write input file in place */
  output?: string;

  describe?: string
  list?: boolean

  printPrompt?: boolean;
  printAnswer?: boolean;
}

const cliArgsHelp = {
  config: 'Optional tools yml file to add',
  output: 'Optional output file, if not given it will re-write input file in place',
  describe: 'Optional. Prints help on a tool, example: --describe create',
  list: 'Optional list all available tools'
  // TODO complete and use
}

function parseArgs(argv: any) {
  // console.log('argv', argv);
  let input=argv._[0]
  const a: CliArgs = { ...argv, input };
  return a
}

export async function handleCli() {
  const argv = require('minimist')(process.argv.slice(2)) as any;
  validateArgs(argv);
  const args: CliArgs = parseArgs(argv)
  setEnvironment(args);
  cliRegisterTools(args);
  handleDescribeTool(args)
  const result = await executeCliInFile({ ...args, vars: { environment: getEnvironment() } });
  if (args.printPrompt) {
    console.log('\n*** PROMPT: ', result.prompt);
  }
  if (args.printAnswer) {
    console.log('\n*** ANSWER: ', result.raw);
  }
  console.log('\n*** RESULT: ', result.inFileResult);
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
  --output Output file, if not given it will re-write input file in place
  `.trim();
}

function handleDescribeTool(args: CliArgs) {
  if(args.describe) {
    const tool = getTool(args.describe)
    const description = describeTool(tool)
    console.log(description);
    process.exit(0)
  }
  if(args.list) {
    const tools = getTools()
    // const s = '\n'+tools.map(describeTool).join('\n\n')
    const s = `
Tools:
${tools.map(t=>` * ${t.metadata.name}\t\t${t.metadata.description||''}`).join('\n')}
    `.trim()
    console.log(s);
    process.exit(0)
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
