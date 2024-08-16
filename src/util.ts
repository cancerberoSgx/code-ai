import * as Mustache from 'mustache';

export function renderTemplate(s: string, vars: any) {
  return Mustache.render(s, vars, {}, { escape: s => s });
}

export function asArray<T>(value: T | T[]): T[] {
  return Array.isArray(value) ? value : [value];
}
