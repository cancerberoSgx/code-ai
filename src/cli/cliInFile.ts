import { appendFile, appendFileSync, readFileSync, writeFileSync } from 'fs';
import { CliArgs } from '.';
import { executeInFile } from '../tool/executeInFile';
import { ToolOutputDestination, ToolOutputFormat, ToolRunArgs } from '../tool/types';
import { getTool } from '../tool/registerTool';
import { executeTool } from '../tool/executeTool';
import { getConfig } from '../config';
import { getEnvironment } from './cliEnvironment';

/**
 * handles in-file prompt operation
 */
export async function executeCliInFile(args: CliArgs & { vars?: { [k: string]: string } }) {
  const fileContents = readFileSync(args.input).toString();
  const r = await executeInFile({ fileContents, model: args.model, fileName: args.input, vars: args.vars });
  const file = args.output || args.input;
  if (!r.inFileResult || !file) {
    throw new Error(`Cannot cli-in-file for r.inFileResult="${r.inFileResult} and file="${file}"`);
  }
  writeFileSync(file, r.inFileResult);
  return r;
}

/**
 * handles a 100% CLI prompt operation
 */
export async function executeCli(args: CliArgs & { vars?: { [k: string]: string } }) {
  const fileContents = readFileSync(args.input).toString();
  const runArgs: ToolRunArgs = {
    vars: {
      ...(args.vars || {}),
      code: fileContents,
      prompt: args.prompt!,
    },
    output: {
      destination: ToolOutputDestination.none,
      format: ToolOutputFormat.firstSnippet,
    },
    config: args.config || getConfig(),
    model: args.model,
  };
  const tool = getTool(args.tool!);
  const result = await executeTool(tool, runArgs);
  if (typeof args.output === 'string') {
    appendFileSync(args.output, result.output);
  }
  return result;
}
