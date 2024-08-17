// pure js logic & tools for language and extensions metadata inference

const extensions: { [ext: string]: string } = {
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
};

export function getLanguageFromExtension(extension: string) {
  return extensions[extension];
}

const extensionCommentExpressions: { [ext: string]: string } = {
  '.js': '//',
  '.ts': '//',
  '.py': '#',
  '.java': '//',
  '.rb': '#',
  '.php': '//',
  '.cs': '//',
  '.cpp': '//',
  '.c': '//',
  '.swift': '//',
  '.go': '//',
  '.kt': '//',
  '.rs': '//',
  '.r': '#',
  '.sh': '#',
  '.ps1': '#',
  '.pl': '#',
  '.m': '//',
  '.scala': '//',
  '.lua': '--',
  '.hs': '--',
  '.groovy': '//',
  '.coffee': '#',
  '.dart': '//',
  '.ex': '#',
  '.erl': '%',
  '.jl': '#',
  '.v': '//',
  '.nim': '#',
  '.clj': ';',
  '.html': '<!-- -->',
  '.css': '/* */',
  '.scss': '/* */',
  '.json': '//',
  '.xml': '<!-- -->',
  '.yaml': '#',
  '.yml': '#',
  '.md': '<!-- -->',
  '.sql': '--',
  '.tex': '%',
  '.bat': 'REM',
  '.ini': ';',
  '.toml': '#',
  '.conf': '#',
  '.csv': '#',
  '.log': '#',
  '.txt': '#',
};

export function commentCode(extension: string, code: string) {
  const commentExpression = extensionCommentExpressions[extension] || '//';
  const splitted = commentExpression.split(' ');
  let result = '';
  if (splitted.length > 1) {
    result = `${splitted[0]} ${code} ${splitted[1]}`;
  } else {
    result = `${code
      .split('\n')
      .map(line => `${splitted[0]} ${line}`)
      .join('\n')}`;
  }
  return result;
}
