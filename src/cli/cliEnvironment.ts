import { extname } from 'path';
import { CliArgs } from '.';

let env = '';
/** takes care of basic environment guessing for CLI . */
export function setEnvironment(args: CliArgs) {
  const ext = extname(args.input);
  env = extensions[ext]
  // if (ext === '.js') {
  //   env = 'JavaScript';
  // } else if (ext === '.ts') {
  //   env = 'TypeScript';
  // } else if (ext === '.py') {
  //   env = 'python';
  // }
}

export function getEnvironment() {
  return env;
}

const extensions: {[ext: string]: string} = {
  '.js': 'JavaScript',
  '.ts': 'TypeScript',
  '.py': 'Python',
  '.java': 'Java',
  '.rb': 'Ruby',
  '.php': 'PHP',
  '.cs': 'C#',
  '.cpp': 'C++',
  '.c': 'C',
  '.swift': 'Swift',
  '.go': 'Go',
  '.kt': 'Kotlin',
  '.rs': 'Rust',
  '.r': 'R',
  '.sh': 'Shell',
  '.ps1': 'PowerShell',
  '.pl': 'Perl',
  '.m': 'Objective-C',
  '.scala': 'Scala',
  '.lua': 'Lua',
  '.hs': 'Haskell',
  '.groovy': 'Groovy',
  '.coffee': 'CoffeeScript',
  '.dart': 'Dart',
  '.ex': 'Elixir',
  '.erl': 'Erlang',
  '.jl': 'Julia',
  '.v': 'V',
  '.nim': 'Nim',
  '.clj': 'Clojure',
  '.html': 'HTML',
  '.css': 'CSS',
  '.scss': 'Sass/SCSS',
  '.json': 'JSON',
  '.xml': 'XML',
  '.yaml': 'YAML',
  '.yml': 'YAML',
  '.md': 'Markdown',
  '.sql': 'SQL',
  '.tex': 'LaTeX',
  '.bat': 'Batch',
  '.ini': 'INI',
  '.toml': 'TOML',
  '.conf': 'Configuration File',
  '.csv': 'CSV',
  '.log': 'Log File',
  '.txt': 'Text File',
}
