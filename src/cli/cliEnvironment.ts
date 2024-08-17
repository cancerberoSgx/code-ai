import { extname } from 'path';
import { CliArgs } from '.';
import { getLanguageFromExtension } from '../tool/environmentTools';

let env = '';
/** takes care of basic environment guessing for CLI . */
export function setEnvironment(args: CliArgs) {
  const ext = extname(args.input);
  env = getLanguageFromExtension(ext);
}

export function getEnvironment() {
  return env;
}
