import { readFileSync, writeFileSync } from 'fs';
import { CliArgs } from '.';
import { executeInFile } from '../tool/executeInFile';
import path from 'path';

/** we read and write files here, so we don't contaminate core code with FS apis. */
export async function executeCliInFile(args: CliArgs & { vars?: { [k: string]: string } }) {
  // console.log('DEBUG process.cwd()', process.cwd());
  // console.log('DEBUG args.input', args.input);
  // console.log('ARGS', args);
  
  const fileContents = readFileSync(args.input).toString();
  const r = await executeInFile({ fileContents, vars: args.vars });
  const file = args.output || args.input;
  if (!r.inFileResult || !file) {
    throw new Error(`Cannot cli-in-file for r.inFileResult="${r.inFileResult} and file="${file}"`);
  }
  writeFileSync(file, r.inFileResult);
  return r;
}
